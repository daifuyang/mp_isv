/**
** @创建时间: 2020/11/24 1:08 上午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Food struct {
	rc controller.RestController
}

type foodCate struct {
	CategoryId int `json:"category_id"`
	Name string `json:"name"`
	Food []model.Food `json:"food"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据分类获取菜品列表
 * @Date 2020/11/24 11:04:49
 * @Param
 * @return
 **/
func (rest *Food) List (c *gin.Context) {

	storeId,_ := c.Get("store_id")
	// 获取门店参数
	category := model.FoodCategory{}

	var query []string
	var queryArgs []interface{}

	query = append(query,"store_id = ? AND delete_at = ? AND status = 1")
	queryArgs = append(queryArgs,storeId,0,1)

	categoryData ,err :=  category.List(query,queryArgs)
	if err != nil {
		rest.rc.Error(c,"获取失败！",nil)
		return
	}

	// 获取全部菜品
	food := model.Food{}
	foodData,err := food.ListByCategory([]string{"fc.store_id = ? AND f.status = ? AND f.delete_at = ?"},[]interface{}{storeId,1,0})

	if err != nil {
		rest.rc.Error(c,"获取菜品错误！",err.Error())
		return
	}

	// 最终结果项
	var foodCateMap = make([]foodCate,0)

	for _,v := range categoryData{

		// 当前分类项
		fc := foodCate{
			CategoryId: v.FoodCategory.Id,
			Name: v.FoodCategory.Name,
		}

		// 当前菜品项
		foodArr := make([]model.Food,0)
		for _,fv := range foodData{

			fmt.Println(v.FoodCategory.Id ,fv.CategoryId)

			// 寻找分类,存入菜品
			if v.FoodCategory.Id == fv.CategoryId {
				foodArr = append(foodArr,fv.Food)
			}
		}

		fc.Food = foodArr
		// 存入一个分类
		foodCateMap = append(foodCateMap,fc)

	}

	rest.rc.Success(c,"获取成功！",foodCateMap)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据菜品id获取菜品详情
 * @Date 2020/11/24 11:05:08
 * @Param
 * @return
 **/
func (rest *Food) Detail (c *gin.Context)   {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	id := rewrite.Id

	food := model.Food{}
	query := []string{"id = ? AND delete_at = ?"}
	queryArgs := []interface{}{id,0}
	data,err := food.Detail(query,queryArgs)
	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}
	rest.rc.Success(c,"获取成功！",data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据规格组合id获取规格详情
 * @Date 2020/11/24 11:11:54
 * @Param
 * @return
 **/

func (rest *Food) Sku (c *gin.Context)   {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	sku := c.Query("sku")
	if sku == "" {
		rest.rc.Error(c,"规格唯一标识不能为空！",nil)
		return
	}

    fSku :=	model.FoodSku{}

    query := []string{"food_id = ? AND attr_post = ?"}
    queryArgs := []interface{}{rewrite.Id,sku}

	data,err := fSku.Show(query,queryArgs)

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}
	rest.rc.Success(c,"获取成功！",data)
}
