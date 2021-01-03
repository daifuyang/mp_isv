/**
** @创建时间: 2020/11/23 10:08 上午
** @作者　　: return
** @描述　　:
 */
package alipayPlugin

import (
	"gincmf/plugins/alipayPlugin/router"
	"github.com/gincmf/alipayEasySdk"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description 初始化支付宝配置
 * @Date 2020/11/23 10:09:39
 * @Param
 * @return
 **/

func Init() {
	regRouter()
	op := map[string]string{
		"protocol":    "https",
		"gatewayHost": "openapi.alipay.com/gateway.do",
		"signType":    "RSA2",
		"appId":       "2021001192664075",
		"version":     "1.0",
		"charset":     "utf-8",
		"notifyUrl":   "https://www.codecloud.ltd/api/v1/app/alipay/receive_notify",
		"AppCertPath": "./data/pem",
		"AliCertPath": "./data/pem",
	}
	alipayEasySdk.NewOptions(op)
}

func regRouter() {
	router.ApiListenRouter()
}
