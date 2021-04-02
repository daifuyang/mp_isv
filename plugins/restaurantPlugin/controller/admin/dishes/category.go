/**
** @创建时间: 2020/10/29 11:16 下午
** @作者　　: return
** @描述　　: 菜单分类管理
 */
package dishes

import (
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type CategoryController struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部菜品分类列表
 * @Date 2020/10/30 00:02:36
 * @Param
 * @return
 **/

// @Summary 菜单分类管理
// @Description 查看全部菜品分类列表
// @Tags restaurant 菜单分类
// @Accept mpfd
// @Param store_id query string true "门店id"
// @Param mid query string true "小程序唯一编号"
// @Param name formData string true "菜单名称"
// @Param type formData int false "菜单类型（0=>全部，1=>到店，2=>外卖）" Enums(0, 1, 2)
// @Param is_required formData int false "是否必选（0=>否，1=>是）" Enums(0, 1)
// @Param status formData int false "状态（0=>停用，1=>启用）" Enums(0, 1)
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.FoodCategory} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/category [get]
func (rest *CategoryController) Get(c *gin.Context) {

	// 所在门店
	storeId := c.Query("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	mid, _ := c.Get("mid")
	query := []string{"mid = ? AND  store_id = ? AND delete_at = ?"}
	queryArgs := []interface{}{mid, storeId, "0"}

	foodCategory := model.FoodCategory{}
	data, err := foodCategory.Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单个菜品分类
 * @Date 2020/10/30 00:03:07
 * @Param
 * @return
 **/

// @Summary 查看单个菜品分类
// @Description 查看单个菜品分类
// @Tags restaurant 菜单分类
// @Accept mpfd
// @Param id path string true "单个菜单分类id"
// @Param mid query string true "小程序唯一编号"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.FoodCategory} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/category/{id} [get]
func (rest *CategoryController) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	food := model.FoodCategory{}

	mid, _ := c.Get("mid")
	query := []string{"mid = ? AND id = ?"}
	queryArgs := []interface{}{mid, rewrite.Id}

	data, err := food.Show(query, queryArgs)

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
 * @Description 修改单个菜品分类
 * @Date 2020/10/30 00:03:20
 * @Param
 * @return
 **/

// @Summary 提交修改单个菜品分类
// @Description 提交修改单个菜品分类
// @Tags restaurant 菜单分类
// @Accept mpfd
// @Param id formData string true "单个菜单分类id"
// @Param mid query string true "小程序唯一编号"
// @Param name formData string true "菜品名称"
// @Param name formData string true "菜品图片"
// @Param type formData int false "菜单类型（0=>全部，1=>到店，2=>外卖）" Enums(0, 1, 2)
// @Param is_required formData int false "是否必选（0=>否，1=>是）" Enums(0, 1)
// @Param status formData int false "状态（0=>停用，1=>启用）" Enums(0, 1)
// @Produce mpfd
// @Success 200 {object} model.ReturnData "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/category/{id} [post]
func (rest CategoryController) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 获取菜品名称

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品分类名称不能为空！", nil)
		return
	}

	// 获取菜品图标
	icon := c.PostForm("icon")
	fmt.Println("icon", icon)

	// 必选品
	isRequired := c.DefaultPostForm("is_required", "0")
	isRequiredInt, err := strconv.Atoi(isRequired)
	if err != nil {
		rest.rc.Error(c, "必选品参数不正确！", nil)
		return
	}

	fmt.Println("is_required", isRequired)

	// 场景（默认支持全部）
	scene := c.DefaultPostForm("scene", "0")
	sceneInt, err := strconv.Atoi(scene)

	if err != nil {
		rest.rc.Error(c, "场景参数不正确！", nil)
		return
	}

	// 状态
	status := c.DefaultPostForm("status", "1")

	if status == "0" {
		status = "0"
	} else {
		status = "1"
	}

	statusInt, _ := strconv.Atoi(status)
	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店参数非法！", err.Error())
		return
	}

	var data model.FoodCategory

	txErr := cmf.NewDb().Transaction(func(tx *gorm.DB) error {

		foodCategory := model.FoodCategory{
			StoreId: storeIdInt,
			FoodCategoryStoreHouse: model.FoodCategoryStoreHouse{
				Id:         rewrite.Id,
				Mid:        midInt,
				Name:       name,
				Icon:       icon,
				IsRequired: isRequiredInt,
				Scene:      sceneInt,
				CreateAt:   time.Now().Unix(),
				UpdateAt:   time.Now().Unix(),
				Status:     statusInt,
			},
			Db: tx,
		}

		data, err = foodCategory.Update()

		if err != nil {
			return errors.New("更新失败！" + err.Error())
		}

		return nil
	})

	if txErr != nil {
		rest.rc.Error(c, txErr.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交新增单个菜品分类
 * @Date 2020/10/30 00:07:18
 * @Param
 * @return
 **/

// @Summary 提交新增单个菜品分类
// @Description 提交新增单个菜品分类
// @Tags restaurant 菜单分类
// @Accept mpfd
// @Param mid formData string true "小程序id"
// @Param name formData string true "菜品名称"
// @Param name formData string true "菜品图片"
// @Param type formData int false "菜单类型（0=>全部，1=>到店，2=>外卖）" Enums(0, 1, 2)
// @Param is_required formData int false "是否必选（0=>否，1=>是）" Enums(0, 1)
// @Param status formData int false "状态（0=>停用，1=>启用）" Enums(0, 1)
// @Produce json
// @Success 200 {object} model.ReturnData{data=model.FoodCategory} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/category [post]
func (rest CategoryController) Store(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 获取菜品分类名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品分类名称不能为空！", nil)
		return
	}

	// 获取菜品图标
	icon := c.PostForm("icon")
	fmt.Println("icon", icon)

	// 必选品
	isRequired := c.DefaultPostForm("is_required", "0")
	isRequiredInt, _ := strconv.Atoi(isRequired)

	fmt.Println("is_required", isRequired)

	// 场景（默认支持全部）
	// 场景（默认支持全部）
	scene := c.DefaultPostForm("scene", "0")
	sceneInt, err := strconv.Atoi(scene)

	if err != nil {
		rest.rc.Error(c, "场景参数不正确！", nil)
		return
	}

	// 状态
	status := c.DefaultPostForm("status", "1")

	if status == "0" {
		status = "0"
	} else {
		status = "1"
	}

	statusInt, _ := strconv.Atoi(status)
	// 所在门店
	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店参数非法！", err.Error())
		return
	}

	var data model.FoodCategory

	txErr := cmf.NewDb().Transaction(func(tx *gorm.DB) error {

		foodCategory := model.FoodCategory{
			StoreId: storeIdInt,
			FoodCategoryStoreHouse: model.FoodCategoryStoreHouse{
				Mid:        midInt,
				Name:       name,
				Icon:       icon,
				IsRequired: isRequiredInt,
				Scene:      sceneInt,
				CreateAt:   time.Now().Unix(),
				UpdateAt:   time.Now().Unix(),
				Status:     statusInt,
			},
			Db: tx,
		}

		data, err = foodCategory.Store()

		if err != nil {
			return errors.New("添加失败！" + err.Error())
		}

		return nil
	})

	if txErr != nil {
		rest.rc.Error(c, txErr.Error(), nil)
		return
	}

	rest.rc.Success(c, "添加成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个菜单分类
 * @Date 2020/10/30 00:08:18
 * @Param
 * @return
 **/

// @Summary 提交删除菜品分类
// @Description 提交删除单个菜品分类
// @Tags restaurant 菜单分类
// @Accept mpfd
// @Param id path string true "单个菜单分类id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/category/{id} [delete]
func (rest CategoryController) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 所在门店
	storeId := c.Query("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	mid, _ := c.Get("mid")

	result := cmf.NewDb().Model(&model.FoodCategory{}).Where("id = ? AND store_id = ? AND mid = ?", rewrite.Id, storeId, mid).Update("delete_at", time.Now().Unix())

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "删除成功！", nil)
}
