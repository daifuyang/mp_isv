/**
** @创建时间: 2020/12/20 2:22 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
)

type ShopCategory struct {
	rc controller.Rest
}

func (rest *ShopCategory) Get(c *gin.Context) {
	result := new(model.ShopCategory).ShopCategory()
	rest.rc.Success(c, "获取成功！", result)
}

// 根据shop_category_id获取下级数据
func (rest *ShopCategory) List(c *gin.Context) {
	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	shopCategoryId := rewrite.Id
	result := new(model.ShopCategory).GetChildrenById(shopCategoryId)
	rest.rc.Success(c, "获取成功！", result)
}

// 根据top_level获取三级数据
func (rest *ShopCategory) Last(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	shopCategoryId := rewrite.Id
	var shopCategory = make([]model.ShopCategory,0)
	cmf.Db().Debug().Where("top_id = ? AND  category_type = 2", shopCategoryId).Find(&shopCategory)
	rest.rc.Success(c, "获取成功！", shopCategory)

}

// 根据id获取单项
func (rest *ShopCategory) One(c *gin.Context) {
	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	shopCategoryId := rewrite.Id
	result := new(model.ShopCategory).GetOneById(shopCategoryId)
	rest.rc.Success(c, "获取成功！", result)
}
