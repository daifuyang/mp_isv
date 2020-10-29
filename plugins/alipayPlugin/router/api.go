/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/plugins/alipayPlugin/controller"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {
	// 支付宝回调url
	cmf.Get("/alipay/auth_redirect", new(controller.AuthRedirectController).Get)
}
