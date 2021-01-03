/**
** @创建时间: 2020/11/6 2:58 下午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"encoding/json"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/cmf/controller"
)

func AppAuthToken(c *gin.Context) {

	mpJson, _ := c.Get("mp_json")

	if mpJson == "" {
		controller.RestController{}.Error(c, "AppAuthToken获取失败，请先绑定支付宝小程序！", nil)
		c.Abort()
		return
	}

	mpJsonStr, _ := mpJson.(string)

	var mpMap model.MpIsvAuth
	json.Unmarshal([]byte(mpJsonStr), &mpMap)

	alipayEasySdk.SetOption("AppAuthToken",mpMap.AppAuthToken)

	if mpMap.AuthAppId == "" {
		controller.RestController{}.Error(c, "AuthAppId获取失败，请先绑定支付宝小程序！", nil)
		c.Abort()
		return
	}

	c.Set("app_id",mpMap.AuthAppId)
	c.Next()

}

func SpiLot(c *gin.Context)  {
	r := c.Request
	r.ParseForm()

	// 获取设备终端id
	// terminalId := strings.Join(r.Form["terminal_id"], "")

	alipayEasySdk.SetOption("AppAuthToken","202012BBc94d62297edb49e385e2136023b0dX61")


	c.Next()
	// 查询终端所属支付宝用户

}
