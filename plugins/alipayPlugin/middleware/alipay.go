/**
** @创建时间: 2020/11/6 2:58 下午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"encoding/json"
	"gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"net/http"
)

func AppAuthToken(c *gin.Context) {

	alipayJson, _ := c.Get("alipay_json")

	if alipayJson == "" {
		controller.Rest{}.Error(c, "AppAuthToken获取失败，请先绑定支付宝小程序！", nil)
		c.Abort()
		return
	}

	alipayJsonStr, _ := alipayJson.(string)

	var mpMap model.MpIsvAuth
	json.Unmarshal([]byte(alipayJsonStr), &mpMap)

	alipayEasySdk.SetOption("AppAuthToken", mpMap.AppAuthToken)

	if mpMap.AuthAppId == "" {
		controller.Rest{}.Error(c, "AuthAppId获取失败，请先绑定支付宝小程序！", nil)
		c.Abort()
		return
	}

	c.Set("app_id", mpMap.AuthAppId)
	c.Next()

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 验证支付宝
 * @Date 2021/2/20 21:55:49
 * @Param
 * @return
 **/

func ValidationAlipay(c *gin.Context) {

	mid, exist := c.Get("mid")
	if !exist {
		c.JSON(http.StatusOK, gin.H{"code": 0, "msg": "小程序商户id不能为空"})
		c.Abort()
		return
	}

	mpIsv := model.MpIsvAuth{}
	tx := cmf.Db().Where("mp_id = ? AND type = ?", mid, "alipay").Order("id desc").First(&mpIsv)

	if tx.RowsAffected == 0 {
		controller.Rest{}.ErrorCode(c, 20001, "请先绑定支付宝小程序！", nil)
		c.Abort()
		return
	}

	mpJson, _ := json.Marshal(&mpIsv)
	c.Set("alipay_json", string(mpJson))
	c.Set("alipay_user_id", mpIsv.UserId)
	c.Set("app_id", mpIsv.AuthAppId)

	c.Next()

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取支付宝
 * @Date 2021/2/22 16:45:0
 * @Param
 * @return
 **/

func UseAlipay(c *gin.Context) {

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
	tx := cmf.Db().Where("mp_id = ? AND type = ?", mid, "alipay").Order("id desc").First(&mpIsv)

	if tx.RowsAffected > 0 {

		mpJson, _ := json.Marshal(&mpIsv)

		if mpIsv.AuthAppId == "" {
			controller.Rest{}.Error(c, "AuthAppId获取失败，请先绑定支付宝小程序！", nil)
			c.Abort()
			return
		}

		c.Set("alipay_json", string(mpJson))
		c.Set("alipay_user_id", mpIsv.UserId)
		c.Set("app_id", mpIsv.AuthAppId)

		alipayEasySdk.SetOption("AppAuthToken", mpIsv.AppAuthToken)

	}

	c.Next()

}

func SpiLot(c *gin.Context) {
	r := c.Request
	r.ParseForm()

	// 获取设备终端id
	// terminalId := strings.Join(r.Form["terminal_id"], "")

	alipayEasySdk.SetOption("AppAuthToken", "202012BBc94d62297edb49e385e2136023b0dX61")

	c.Next()
	// 查询终端所属支付宝用户

}
