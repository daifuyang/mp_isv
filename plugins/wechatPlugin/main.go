/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package wechatPlugin

import (
	"fmt"
	"gincmf/plugins/wechatPlugin/router"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/wechatEasySdk"
)

func Init() {
	router.ApiListenRouter()

	redis := cmf.NewRedisDb()
	if cmf.Conf().App.Evn != "release" {
		redis, _ = cmf.RedisDb("52.130.144.34", "codecloud2020")
	}

	ticket, err := redis.Get("componentVerifyTicket").Result()

	fmt.Println("ticket",ticket)

	host := cmf.Conf().App.Domain

	op := map[string]string{
		"spAppid":         "wx842f10c69bb48e5b",
		"spMchid":         "1605269485",
		"appId":           "wxa95825ecf5e840e6",
		"appSecret":       "c733bbd5643a248fe19e7af3a837fcf1",
		"aesKey":          "***REMOVED***oud20212021=",
		"v3Key":           "***REMOVED***",
		"redirectUrl":     host + "/api/v1/wechat/auth_redirect",
		"gatewayHost":     "https://api.mch.weixin.qq.com",
		"appCertPath":     "./data/wechatPem",
		"wechatpaySerial": "2259A28AEB2228F27053BE552835A1B6F2D6681F",
	}

	if err == nil {
		op["componentVerifyTicket"] = ticket
	}

	wechatEasySdk.NewOpenOptions(op)

}
