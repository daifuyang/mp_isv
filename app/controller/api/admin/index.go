package admin

import (
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
// @Produce json
// @Success 200 {object} model.ReturnData "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 404 {object} model.ReturnData "接口异常！"
// @Router / [get]
func (rest *IndexController) Get(c *gin.Context) {
	rest.rc.Success(c, "hello Api", nil)
}

func (rest *IndexController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
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
