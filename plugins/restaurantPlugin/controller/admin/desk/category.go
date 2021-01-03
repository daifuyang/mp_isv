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

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部桌位类型列表
 * @Date 2020/10/30 00:02:36
 * @Param
 * @return
 **/

// @Summary 桌位类型管理
// @Description 查看全部桌位类型列表
// @Tags restaurant 桌位分类管理
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.DeskCategory} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
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

	storeId := c.PostForm("store_id")
	if storeId == "" {
		query = append(query, "store_id = ?")
		queryArgs = append(queryArgs, storeId)
	}

	category := model.DeskCategory{}

	data, err := category.Index(c, query, queryArgs)

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
// @Tags restaurant 桌位分类管理
// @Accept mpfd
// @Param id path string true "单个桌位菜单id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.DeskCategory} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/category/{id} [get]
func (rest CategoryController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	category := model.DeskCategory{}

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")

	query = append(query, "id = ? AND mid = ?")
	queryArgs = append(queryArgs, rewrite.Id, mid)

	data, err := category.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该分类不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
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
// @Tags restaurant 桌位分类管理
// @Accept mpfd
// @Param id path string true "单个桌位菜单id"
// @Param mid query string true "小程序唯一编号"
// @Param category_name formData string true "分类名称"
// @Param least_seats formData string true "最少座位人数"
// @Param maximum_seats formData string true "最多座位人数"
// @Produce mpfd
// @Success 200 {object}  model.ReturnData{data=model.DeskCategory} "code:1 => 更新成功，code:0 => 提交失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/category/{id} [post]
func (rest CategoryController) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	categoryName := c.PostForm("category_name")
	if categoryName == "" {
		rest.rc.Error(c, "分类名称不能为空！", nil)
		return
	}

	leastSeats := c.PostForm("least_seats")
	leastSeatsInt, _ := strconv.Atoi(leastSeats)
	MaximumSeats := c.PostForm("maximum_seats")
	maximumSeats, _ := strconv.Atoi(MaximumSeats)
	category := model.DeskCategory{
		Id:           rewrite.Id,
		Mid:          mid.(int),
		StoreId:      storeIdInt,
		CategoryName: categoryName,
		LeastSeats:   leastSeatsInt,
		MaximumSeats: maximumSeats,
	}

	data, err := category.Update()
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
// @Tags restaurant 桌位分类管理
// @Accept mpfd
// @Produce mpfd
// @Param mid query string true "小程序唯一编号"
// @Param category_name formData string true "分类名称"
// @Param least_seats formData string true "最少座位人数"
// @Param maximum_seats formData string true "最多座位人数"
// @Success 200 {object} model.ReturnData{data=model.DeskCategory} "code:1 => 新增成功！，code:0 => 新增失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/category [post]
func (rest CategoryController) Store(c *gin.Context) {

	mid, _ := c.Get("mid")

	categoryName := c.PostForm("category_name")
	if categoryName == "" {
		rest.rc.Error(c, "分类名称不能为空！", nil)
		return
	}

	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	leastSeats := c.PostForm("least_seats")
	leastSeatsInt, _ := strconv.Atoi(leastSeats)
	MaximumSeats := c.PostForm("maximum_seats")
	maximumSeats, _ := strconv.Atoi(MaximumSeats)
	category := model.DeskCategory{
		Mid:          mid.(int),
		StoreId:      storeIdInt,
		CategoryName: categoryName,
		LeastSeats:   leastSeatsInt,
		MaximumSeats: maximumSeats,
	}

	result, err := category.Store()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
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
// @Tags restaurant 桌位分类管理
// @Accept mpfd
// @Param id path string true "单个菜单类型id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.DeskCategory} "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/desk/category/{id} [delete]
func (rest CategoryController) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)
	category := model.DeskCategory{}
	cmf.NewDb().Where("mid = ? AND id = ?", midInt, rewrite.Id).Delete(&category)

	rest.rc.Success(c, "删除成功！", nil)
}
