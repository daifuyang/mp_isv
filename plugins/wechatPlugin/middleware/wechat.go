/**
** @创建时间: 2021/5/9 5:26 下午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"net/http"
)

func UseWechat(c *gin.Context) {
	mid, exist := c.Get("mid")
	if !exist {
		c.JSON(http.StatusOK, gin.H{"code": 0, "msg": "小程序商户id不能为空"})
		c.Abort()
		return
	}

	// 验证当前小程序是否存在
	result := cmf.NewDb().Where("mid = ?", mid).First(&saasModel.MpTheme{})

	if result.RowsAffected == 0 {
		controller.Rest{}.ErrorCode(c, 20001, "小程序编号不正确！", nil)
		c.Abort()
		return
	}

	mpIsv := model.MpIsvAuth{}
	tx := cmf.Db().Where("mp_id = ? AND type = ?", mid, "wechat").Order("id desc").First(&mpIsv)

	if tx.RowsAffected > 0 {

		if mpIsv.AuthAppId == "" {
			controller.Rest{}.Error(c, "AuthAppId获取失败，请先绑定微信小程序！", nil)
			c.Abort()
			return
		}

		c.Set("app_id", mpIsv.AuthAppId)

	}

	c.Next()
}
