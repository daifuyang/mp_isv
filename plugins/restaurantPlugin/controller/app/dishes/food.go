/**
** @创建时间: 2020/11/24 1:08 上午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
)

type Food struct {
	rc controller.RestController
}

type foodCate struct {
	CategoryId int          `json:"category_id"`
	Name       string       `json:"name"`
	IsRequired int          `json:"is_required"`
	Food       []model.Food `json:"food"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据分类获取菜品列表
 * @Date 2020/11/24 11:04:49
 * @Param
 * @return
 **/
func (rest *Food) List(c *gin.Context) {

	mid, _ := c.Get("mid")
	storeId, _ := c.Get("store_id")
	scene := c.DefaultQuery("scene", "1")

	if !(scene == "1" || scene == "2") {
		rest.rc.Error(c, "场景参数不正确", nil)
		return
	}

	// 获取门店参数
	category := model.FoodCategory{}

	var query []string
	var queryArgs []interface{}

	query = append(query, "mid = ? AND store_id = ? AND delete_at = ? AND status = ?")
	queryArgs = append(queryArgs, mid, storeId, 0, 1)

	query = append(query, "(scene = 0 OR scene = ?)")
	queryArgs = append(queryArgs, scene)

	categoryData, err := category.List(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, "获取失败！", nil)
		return
	}

	// 获取全部菜品
	var foodQuery []string
	var foodQueryArgs []interface{}

	foodQuery = append(foodQuery, "f.mid = ? AND fc.store_id = ? AND f.status = ? AND f.delete_at = ? AND (inventory = -1 || inventory > 0)")
	foodQueryArgs = append(foodQueryArgs, mid, storeId, 1, 0)

	foodQuery = append(foodQuery, "(f.scene = 0 OR f.scene = ?)")
	foodQueryArgs = append(foodQueryArgs, scene)

	food := model.Food{}
	foodData, err := food.ListByCategory(foodQuery, foodQueryArgs)

	if err != nil {
		rest.rc.Error(c, "获取菜品错误！", err.Error())
		return
	}

	// 最终结果项
	var foodCateMap = make([]foodCate, 0)

	for _, v := range categoryData {

		// 当前分类项
		fc := foodCate{
			CategoryId: v.FoodCategory.Id,
			Name:       v.FoodCategory.Name,
			IsRequired: v.FoodCategory.IsRequired,
		}

		// 当前菜品项
		foodArr := make([]model.Food, 0)
		for _, fv := range foodData {
			// 寻找分类,存入菜品
			if v.FoodCategory.Id == fv.CategoryId {
				foodArr = append(foodArr, fv.Food)
			}
		}

		fc.Food = foodArr
		// 存入一个分类
		foodCateMap = append(foodCateMap, fc)

	}

	rest.rc.Success(c, "获取成功！", foodCateMap)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据菜品id获取菜品详情
 * @Date 2020/11/24 11:05:08
 * @Param
 * @return
 **/
func (rest *Food) Detail(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	id := rewrite.Id

	mid, _ := c.Get("mid")

	food := model.Food{}
	query := []string{"mid = ? AND id = ? AND delete_at = ?"}
	queryArgs := []interface{}{mid, id, 0}
	data, err := food.Detail(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据规格组合id获取规格详情
 * @Date 2020/11/24 11:11:54
 * @Param
 * @return
 **/

func (rest *Food) Sku(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	sku := c.Query("sku")
	if sku == "" {
		rest.rc.Error(c, "规格唯一标识不能为空！", nil)
		return
	}

	fSku := model.FoodSku{}

	query := []string{"food_id = ? AND attr_post = ?"}
	queryArgs := []interface{}{rewrite.Id, sku}

	data, err := fSku.Show(query, queryArgs)

	if err != nil {
		if !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该内容不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if data.Inventory == 0 {
		rest.rc.Error(c, "改规格商品库存不足，请稍后再试！", nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}
