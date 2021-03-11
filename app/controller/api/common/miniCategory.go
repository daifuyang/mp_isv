/**
** @创建时间: 2021/3/2 9:50 上午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/mini"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
)

type MiniCategory struct {
	rc controller.RestController
}

func (rest *MiniCategory) Get(c *gin.Context) {
	result := new(model.MiniCategory).AllCategory()
	rest.rc.Success(c, "获取成功！", result)
}

// 根据shop_category_id获取下级数据
func (rest *MiniCategory) List(c *gin.Context) {
	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	categoryId := rewrite.Id
	result := new(model.MiniCategory).GetChildrenById(categoryId)
	rest.rc.Success(c, "获取成功！", result)
}

// 根据top_level获取三级数据
func (rest *MiniCategory) Last(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	categoryId := rewrite.Id
	result := new(model.MiniCategory).GetChildrenByTopId(categoryId)
	rest.rc.Success(c, "获取成功！", result)

}

// 根据id获取单项
func (rest *MiniCategory) One(c *gin.Context) {
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

/**
 * @Author return <1140444693@qq.com>
 * @Description // 同步
 * @Date 2021/3/2 22:26:38
 * @Param
 * @return
 **/
func (rest *MiniCategory) Sync(c *gin.Context) {

	bizContent := make(map[string]interface{}, 0)
	bizContent["is_filter"] = "true"
	result := new(mini.Category).Query(bizContent)

	if result.Response.Code == "10000" {
		rest.RecursionCategory(result.Response.CategoryList, "0", 0)
		rest.rc.Success(c, "同步成功！", nil)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result)
	}

}

func (rest *MiniCategory) RecursionCategory(data []mini.CategoryList, parentId string, dbId int) {

	for _, v := range data {

		flag := false

		if parentId == "0" {
			if v.CategoryName == "购物" || v.CategoryName == "餐饮" {
				flag = true
			}
		} else {
			flag = true
		}

		if v.ParentCategoryId == parentId && flag {

			mc := model.MiniCategory{
				ParentId:           dbId,
				CategoryName:       v.CategoryName,
				AlipayCategoryId:   v.CategoryId,
				AlipayCategoryName: v.CategoryName,
				AlipayParentId:     v.ParentCategoryId,
			}

			cmf.Db().Where("alipay_category_id = ?", v.CategoryId).FirstOrCreate(&mc)

			rest.RecursionCategory(data, v.CategoryId, mc.Id)
		}

	}

}
