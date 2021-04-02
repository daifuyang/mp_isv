/**
** @创建时间: 2020/11/5 4:36 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type RegionController struct {
	rc controller.Rest
}

func (rest *RegionController) Get(c *gin.Context) {
	region := model.Region{}
	result := region.Region()
	rest.rc.Success(c, "获取成功！", result)
}

// 根据area_id获取下级数据
func (rest *RegionController) List(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	region := model.Region{}
	areaId := rewrite.Id
	result := region.GetChildrenById(areaId)
	rest.rc.Success(c, "获取成功！", result)

}

// 根据id获取单项
func (rest *RegionController) One(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	region := model.Region{}
	areaId := rewrite.Id
	result := region.GetOneById(areaId)
	rest.rc.Success(c, "获取成功！", result)

}
