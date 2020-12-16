/**
** @创建时间: 2020/11/1 1:20 下午
** @作者　　: return
** @描述　　:
 */
package desk

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type CategoryController struct {
	rc controller.RestController
}

// 文档所需
type deskCatePaginate struct {
	Data     []model.DeskCategory `json:"data"`
	Current  string               `json:"current" example:"1"`
	PageSize string               `json:"page_size" example:"10"`
	Total    int64                `json:"total" example:"10"`
}

type deskCateGet struct {
	Code int              `json:"code" example:"1"`
	Msg  string           `json:"msg" example:"获取成功！"`
	Data deskCatePaginate `json:"data"`
}

type deskCateStore struct {
	Code int                `json:"code" example:"1"`
	Msg  string             `json:"msg" example:"添加成功！"`
	Data model.DeskCategory `json:"data"`
}

type deskCateShow struct {
	Code int                `json:"code" example:"1"`
	Msg  string             `json:"msg" example:"获取成功！"`
	Data model.DeskCategory `json:"data"`
}

type deskCateEdit struct {
	Code int                `json:"code" example:"1"`
	Msg  string             `json:"msg" example:"修改成功！"`
	Data model.DeskCategory `json:"data"`
}

type deskCateDel struct {
	Code int                `json:"code" example:"1"`
	Msg  string             `json:"msg" example:"删除成功！"`
	Data model.DeskCategory `json:"data"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部桌位类型列表
 * @Date 2020/10/30 00:02:36
 * @Param
 * @return
 **/

// @Summary 桌位类型管理
// @Description 查看全部桌位类型列表
// @Tags restaurant 菜单类型
// @Accept mpfd

// @Produce json
// @Success 200 {object} deskCateGet "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/desk/category [get]
func (rest CategoryController) Get(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")
	query = append(query, "mid = ?")
	queryArgs = append(queryArgs, mid)

	categoryName := c.PostForm("category_name")
	if categoryName != "" {
		query = append(query, "category_name = ?")
		queryArgs = append(queryArgs, "%"+categoryName+"%")
	}

	category := model.DeskCategory{}

	data, err := category.Index(c,query,queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单个菜单类型
 * @Date 2020/10/30 00:03:07
 * @Param
 * @return
 **/

// @Summary 查看单个菜单类型
// @Description 查看单个菜单类型
// @Tags restaurant 菜单类型
// @Accept mpfd
// @Param id path string true "单个菜单类型id"
// @Produce json
// @Success 200 {object} deskCateShow "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/desk/category/{id} [get]
func (rest CategoryController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	category := model.DeskCategory{}

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")

	query = append(query, "id = ? AND mid = ?")
	queryArgs = append(queryArgs, rewrite.Id,mid)

     data,err := category.Show(query,queryArgs)
	if err != nil {
		if errors.Is(err,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,"该分类不存在！",nil)
			return
		}
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 修改单个菜单类型
 * @Date 2020/10/30 00:03:20
 * @Param
 * @return
 **/

// @Summary 提交修改单个菜单类型
// @Description 提交修改单个菜单类型
// @Tags restaurant 菜单类型
// @Accept mpfd
// @Param id formData string true "单个菜单类型id"
// @Produce json
// @Success 200 {object} deskCateEdit "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/desk/category/{id} [post]
func (rest CategoryController) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	mid, _ := c.Get("mid")

	categoryName := c.PostForm("category_name")
	if categoryName == "" {
		rest.rc.Error(c,"分类名称不能为空！",nil)
		return
	}

	leastSeats := c.PostForm("least_seats")
	leastSeatsInt, _ := strconv.Atoi(leastSeats)
	MaximumSeats := c.PostForm("maximum_seats")
	maximumSeats, _ := strconv.Atoi(MaximumSeats)
	category := model.DeskCategory{
		Id: rewrite.Id,
		Mid: mid.(int),
		CategoryName: categoryName,
		LeastSeats:   leastSeatsInt,
		MaximumSeats: maximumSeats,
	}

	data,err := category.Update()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交新增单个菜单类型
 * @Date 2020/10/30 00:07:18
 * @Param
 * @return
 **/

// @Summary 提交新增单个菜单类型
// @Description 提交新增单个菜单类型
// @Tags restaurant 菜单类型
// @Accept mpfd
// @Produce json
// @Success 200 {object} deskCateStore "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/desk/category [post]
func (rest CategoryController) Store(c *gin.Context) {

	mid, _ := c.Get("mid")

	categoryName := c.PostForm("category_name")
	if categoryName == "" {
		 rest.rc.Error(c,"分类名称不能为空！",nil)
		return
	}

	leastSeats := c.PostForm("least_seats")
	leastSeatsInt, _ := strconv.Atoi(leastSeats)
	MaximumSeats := c.PostForm("maximum_seats")
	maximumSeats, _ := strconv.Atoi(MaximumSeats)
	category := model.DeskCategory{
		Mid: mid.(int),
		CategoryName: categoryName,
		LeastSeats:   leastSeatsInt,
		MaximumSeats: maximumSeats,
	}

	result,err :=  category.Store()
	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	rest.rc.Success(c, "添加成功！", result)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个菜单类型
 * @Date 2020/10/30 00:08:18
 * @Param
 * @return
 **/

// @Summary 提交删除菜单类型
// @Description 提交删除单个菜单类型
// @Tags restaurant 菜单类型
// @Accept mpfd
// @Param id path string true "单个菜单类型id"
// @Produce json
// @Success 200 {object} deskCateDel "code:1 => 删除成功，code:0 => 删除失败"
// @Router /admin/desk/category/{id} [delete]
func (rest CategoryController) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)
	category := model.DeskCategory{}
	cmf.NewDb().Where("mid = ? AND id = ?",midInt,rewrite.Id).Delete(&category)

	rest.rc.Success(c, "删除成功！", nil)
}
