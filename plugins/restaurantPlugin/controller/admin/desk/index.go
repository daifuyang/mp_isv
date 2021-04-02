/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　:
 */
package desk

import (
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type IndexController struct {
	rc controller.Rest
}

// @Summary 桌位管理
// @Description 查看全部桌位列表
// @Tags restaurant 桌位管理
// @Accept mpfd
// @Param name formData string true "桌位名称"
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.Desk} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk [get]
func (rest *IndexController) Get(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")
	query = append(query, "d.mid = ?")
	queryArgs = append(queryArgs, mid)

	storeId := c.Query("d.store_id")
	if storeId != "" {
		query = append(query, "d.store_id = ?")
		queryArgs = append(queryArgs, storeId)
	}

	categoryId := c.Query("category_id")
	if storeId != "" {
		query = append(query, "category_id = ?")
		queryArgs = append(queryArgs, categoryId)
	}

	name := c.Query("name")
	if name != "" {
		query = append(query, "name = ?")
		queryArgs = append(queryArgs, "%"+name+"%")
	}

	desk := model.Desk{}

	data, err := desk.Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 单个桌位管理
 * @Date 2020/11/01 13:25:35
 * @Param
 * @return
 **/

// @Summary 单个桌位详情
// @Description 查看单个桌位
// @Tags restaurant 桌位管理
// @Accept mpfd
// @Param id path string true "单个桌位id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Desk} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/{id} [get]
func (rest *IndexController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	desk := model.Desk{}

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")

	query = append(query, "d.id = ? AND d.mid = ?")
	queryArgs = append(queryArgs, rewrite.Id, mid)

	data, err := desk.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该桌位不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 编辑单个桌位
 * @Date 2020/11/01 13:25:35
 * @Param
 * @return
 **/

// @Summary 提交修改单个桌位
// @Description 提交修改单个桌位
// @Tags restaurant 桌位管理
// @Accept mpfd
// @Param id path string true "单个桌位id"
// @Produce mpfd
// @Param id path string true "单个桌位id"
// @Param mid query string true "小程序唯一编号"
// @Param name formData string true "桌位名称"
// @Param store_id formData string true "所属门店"
// @Param category_id formData string true "所属分类"
// @Success 200 {object} model.ReturnData{data=model.Desk} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/{id} [post]
func (rest *IndexController) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "座位名称不能为空！", nil)
		return
	}

	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "所属门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	categoryId := c.PostForm("category_id")
	if categoryId == "" {
		rest.rc.Error(c, "所属分类不能为空！", nil)
		return
	}

	categoryIdInt, err := strconv.Atoi(categoryId)
	if err != nil {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	desk := model.Desk{
		Id:         rewrite.Id,
		Mid:        mid.(int),
		StoreId:    storeIdInt,
		Name:       name,
		CategoryId: categoryIdInt,
	}

	data, err := desk.Update()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增一项菜品
 * @Date 2020/11/01 13:25:35
 * @Param
 * @return
 **/

// @Summary 提交删除桌位
// @Description 提交删除单个桌位
// @Tags restaurant 桌位管理
// @Accept mpfd
// @Param id path string true "单个菜单类型id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Desk} "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk [post]
func (rest *IndexController) Store(c *gin.Context) {

	mid, _ := c.Get("mid")

	// midInt := mid.(int)

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "桌位名称不能为空！", nil)
		return
	}

	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "所属门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店id参数非法！", nil)
		return
	}

	categoryId := c.PostForm("category_id")
	if categoryId == "" {
		rest.rc.Error(c, "所属分类不能为空！", nil)
		return
	}

	categoryIdInt, err := strconv.Atoi(categoryId)
	if err != nil {
		rest.rc.Error(c, "门店id参数非法！", nil)
		return
	}

	// 桌位号
	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":desk" + yearStr + monthStr + dayStr
	number := util.EncryptUuid(insertKey, date, mid.(int))
	deskNumber, _ := strconv.Atoi(number)

	desk := model.Desk{
		Mid:        mid.(int),
		StoreId:    storeIdInt,
		Name:       name,
		DeskNumber: deskNumber,
		CategoryId: categoryIdInt,
	}

	data, err := desk.Store()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "添加成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一个桌位
 * @Date 2020/11/01 13:25:35
 * @Param
 * @return
 **/

// @Summary 提交删除桌位
// @Description 提交删除桌位
// @Tags restaurant 桌位管理
// @Accept mpfd
// @Produce mpfd
// @Param id path string true "单个桌位id"
// @Success 200 {string} nil "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/{id} [delete]
func (rest *IndexController) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)
	desk := model.Desk{}

	result := cmf.NewDb().Where("mid = ? AND id = ?", midInt, rewrite.Id).Delete(&desk)

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
	}

	rest.rc.Success(c, "删除成功！", nil)

}
