package admin

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type IndexController struct {
	rc controller.RestController
}

// @Summary 入口文件
// @Description 预览接口可访问
// @Tags index
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData "获取成功！"
// @Router / [get]
func (rest *IndexController) Get(c *gin.Context) {
	rest.rc.Success(c, "hello Api", model.ReturnData{
		Data: c.ClientIP(),
	})
}

func (rest *IndexController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

func (rest *IndexController) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

func (rest *IndexController) Store(c *gin.Context) {
	rest.rc.Success(c, "操作成功Store", nil)
}

func (rest *IndexController) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
