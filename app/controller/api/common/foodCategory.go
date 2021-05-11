/**
** @创建时间: 2020/12/20 2:22 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type FoodCategory struct {
	rc controller.Rest
}

func (rest *FoodCategory) Get(c *gin.Context) {
	result := new(model.TakeoutCategory).FoodCategory()
	rest.rc.Success(c, "获取成功！", result)
}

// 根据shop_category_id获取下级数据
func (rest *FoodCategory) List(c *gin.Context) {
	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	foodCategoryId := rewrite.Id
	result := new(model.TakeoutCategory).GetChildrenById(foodCategoryId)
	rest.rc.Success(c, "获取成功！", result)
}

// 根据id获取单项
func (rest *FoodCategory) One(c *gin.Context) {
	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	foodCategoryId := rewrite.Id
	result := new(model.ShopCategory).GetOneById(foodCategoryId)
	rest.rc.Success(c, "获取成功！", result)
}
