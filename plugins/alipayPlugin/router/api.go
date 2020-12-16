/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/plugins/alipayPlugin/controller"
	aliMidd "gincmf/plugins/alipayPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {
	// 支付宝授权回调url

	adminGroup := cmf.Group("api/v1/alipay",middleware.AllowCors)
	{
		adminGroup.Get("/auth_redirect", new(controller.Auth).Redirect)

		adminGroup.Get("/auth_qrcode", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, middleware.ValidationAdmin, new(controller.Auth).OutAuthQrcode)

		adminGroup.Get("/oauth_token", middleware.ValidationMp, aliMidd.AppAuthToken, new(controller.Auth).Token)
	}
}
