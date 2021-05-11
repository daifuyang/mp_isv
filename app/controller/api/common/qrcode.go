/**
** @创建时间: 2021/4/2 5:41 下午
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

type Qrcode struct {
	rc controller.Rest
}

// 用户小程序解析二维码
func (rest *Qrcode) Get(c *gin.Context) {

	// 完成业务
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	qrcode := model.Qrcode{}
	tx := cmf.Db().Where("code = ? AND  status = 1", rewrite.Id).First(&qrcode)
	if tx.Error != nil {
		rest.rc.Error(c,"该二维码不存在或已停用！",nil)
		return
	}

	rest.rc.Success(c,"获取成功！","?"+qrcode.Query)

}