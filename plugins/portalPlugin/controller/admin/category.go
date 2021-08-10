/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　: 插件名采用大驼峰命名法，都带 Plugin类名后缀，如 DemoPlugin,CustomAdminLoginPlugin
 */
package admin

import (
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/portalPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"strconv"
)

type Category struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看分类列表
 * @Date 2020/11/11 18:23:49
 * @Param
 * @return
 **/
func (rest *Category) List(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt, _ := mid.(int)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	category := model.PortalCategory{
		Mid: midInt,
		Db:  db,
	}
	data, err := category.ListWithTree()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Category) Options(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt, _ := mid.(int)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	category := model.PortalCategory{
		Db: db,
	}

	var query = []string{"mid = ? AND delete_at  = ?"}
	var queryArgs = []interface{}{midInt, 0}

	data, err := category.ListWithOptions(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 门户分类查询
 * @Date 2020/11/7 19:58:25
 * @Param
 * @return
 **/
func (rest *Category) Get(c *gin.Context) {

	query := []string{"delete_at = ?"}
	queryArgs := []interface{}{"0"}

	name := c.Query("name")
	if name != "" {
		query = append(query, "name like ?")
		queryArgs = append(queryArgs, "%"+name+"%")
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	category := model.PortalCategory{
		Db: db,
	}
	data, err := category.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询单个门户分类
 * @Date 2020/11/7 21:14:53
 * @Param
 * @return
 **/
func (rest *Category) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	portalCategory := model.PortalCategory{
		Id: rewrite.Id,
		Db: db,
	}

	data, err := portalCategory.Show()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Category) Edit(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	name := c.PostForm("name")

	if name == "" {
		rest.rc.Error(c, "分类名称不能为空！", nil)
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	portalCategory := model.PortalCategory{
		Id:   rewrite.Id,
		Mid:  midInt,
		Name: name,
		Db:   db,
	}

	pid := c.DefaultPostForm("parent_id", "")
	if pid != "" {
		parentId, _ := strconv.Atoi(pid)
		portalCategory.ParentId = parentId
	}

	status := c.PostForm("status")
	statusInt := 1
	if status != "" {
		statusInt, _ = strconv.Atoi(status)
	}
	portalCategory.Status = statusInt

	listTpl := c.PostForm("list_tpl")

	if listTpl != "" {
		portalCategory.ListTpl = listTpl
	}

	description := c.PostForm("description")
	if description != "" {
		portalCategory.Description = description
	}
	thumbnail := c.PostForm("thumbnail")
	portalCategory.Thumbnail = thumbnail
	/*if thumbnail != "" {
		portalCategory.Thumbnail = thumbnail
	}*/
	seoTitle := c.PostForm("seo_title")
	if seoTitle != "" {
		portalCategory.SeoTitle = seoTitle
	}
	seoDescription := c.PostForm("seo_description")
	if seoDescription != "" {
		portalCategory.SeoDescription = seoDescription
	}
	seoKeywords := c.PostForm("seo_keywords")
	if seoKeywords != "" {
		portalCategory.SeoKeywords = seoKeywords
	}

	oneTpl := c.PostForm("one_tpl")
	if oneTpl != "" {
		portalCategory.OneTpl = oneTpl
	}

	data, err := portalCategory.Edit()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", data)
}

func (rest *Category) Store(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "分类名称不能为空！", nil)
		return
	}

	pid := c.DefaultPostForm("parent_id", "0")
	parentId, _ := strconv.Atoi(pid)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	portalCategory := model.PortalCategory{
		Mid:      midInt,
		ParentId: parentId,
		Name:     name,
		Db:       db,
	}
	status := c.PostForm("status")
	statusInt := 1
	if status != "" {
		statusInt, _ = strconv.Atoi(status)
	}
	portalCategory.Status = statusInt
	alias := c.PostForm("alias")
	if alias != "" {
		portalCategory.Alias = alias
	}
	description := c.PostForm("description")
	if description != "" {
		portalCategory.Description = description
	}
	thumbnail := c.PostForm("thumbnail")
	if thumbnail != "" {
		portalCategory.Thumbnail = thumbnail
	}
	seoTitle := c.PostForm("seo_title")
	if seoTitle != "" {
		portalCategory.SeoTitle = seoTitle
	}
	seoDescription := c.PostForm("seo_description")
	if seoDescription != "" {
		portalCategory.SeoDescription = seoDescription
	}
	seoKeywords := c.PostForm("seo_keywords")
	if seoKeywords != "" {
		portalCategory.SeoKeywords = seoKeywords
	}
	listTpl := c.PostForm("list_tpl")

	if listTpl != "" {
		portalCategory.ListTpl = ""
	}
	oneTpl := c.PostForm("one_tpl")
	if oneTpl != "" {
		portalCategory.OneTpl = oneTpl
	}

	result, err := portalCategory.Save()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "新建成功！", result)
}

func (rest *Category) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	ids := c.QueryArray("ids")

	fmt.Println("ids", ids)

	var (
		result interface{}
		err    error
	)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 软删除
	portalCategory := model.PortalCategory{
		Db: db,
	}

	if len(ids) == 0 {
		if err := c.ShouldBindUri(&rewrite); err != nil {
			c.JSON(400, gin.H{"msg": err})
			return
		}
		portalCategory.Id = rewrite.Id
		result, err = portalCategory.Delete()
	} else {
		result, err = portalCategory.BatchDelete(ids)
	}

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "删除成功！", result)

}
