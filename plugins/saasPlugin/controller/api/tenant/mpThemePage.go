/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序单页面
 */
package tenant

import (
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
)

type MpThemePageController struct {
	rc controller.RestController
}

func (rest *MpThemePageController) Get(c *gin.Context) {
	rest.rc.Success(c, "获取成功！", nil)
}

func (rest *MpThemePageController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	id := rewrite.Id

	origId := util.DecodeId(uint64(id))

	fmt.Println("origId", origId)

	mpThemePage := model.MpThemePage{}
	// 获取当前页面的数据
	result := cmf.NewDb().Where("id = ?", origId).First(&mpThemePage)

	if result.RowsAffected == 0 {
		rest.rc.Error(c, "获取失败", result.Error.Error())
		return
	}

	rest.rc.Success(c, "获取成功！", mpThemePage)
}

func (rest *MpThemePageController) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	more := c.PostForm("more")
	wJson := json.Valid([]byte(more))

	if !wJson {
		rest.rc.Error(c, "提交参数错误！", nil)
		return
	}

	id := rewrite.Id
	origId := util.DecodeId(uint64(id))
	mpThemePage := model.MpThemePage{}

	result := cmf.NewDb().Debug().Where("id = ?", origId).First(&mpThemePage)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "该数据不存在！", nil)
		return
	}

	mpThemePage.More = more
	cmf.NewDb().Debug().Save(&mpThemePage)

	rest.rc.Success(c, "保存成功！", nil)
}

func (rest *MpThemePageController) Store(c *gin.Context) {
	rest.rc.Forbidden(c)
}

func (rest *MpThemePageController) Delete(c *gin.Context) {
	rest.rc.Forbidden(c)
}
