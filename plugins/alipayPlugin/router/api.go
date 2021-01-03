/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/plugins/alipayPlugin/controller"
	"gincmf/plugins/alipayPlugin/controller/spi/commerce"
	"gincmf/plugins/alipayPlugin/controller/spi/merchant"
	aliMidd "gincmf/plugins/alipayPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {
	// 支付宝授权回调url

	cmf.Get("api/v1/getway",middleware.ValidationMp, aliMidd.AppAuthToken,middleware.AllowCors,new(controller.GetWay).GetWay)

	adminGroup := cmf.Group("api/v1/alipay",middleware.AllowCors)
	{
		adminGroup.Get("/auth_redirect", new(controller.Auth).Redirect)

		adminGroup.Get("/auth_qrcode", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, middleware.ValidationAdmin, new(controller.Auth).OutAuthQrcode)

		adminGroup.Get("/oauth_token", middleware.ValidationMp, aliMidd.AppAuthToken, new(controller.Auth).Token)
	}

	spiGroup := cmf.Group("api/v1/spi",middleware.AllowCors)
	{
		spiGroup.Get("/test",new(merchant.Order).Test)
		spiGroup.Post("/test",new(merchant.Order).Test)
		spiGroup.Post("/pay",aliMidd.SpiLot,new(merchant.Order).Pay)
		spiGroup.Post("/query",aliMidd.SpiLot,new(merchant.Order).Query)
		spiGroup.Post("/cashier/batch_query",aliMidd.SpiLot,new(commerce.Cashier).BatchQuery)
		spiGroup.Post("/cashier/query",aliMidd.SpiLot,new(commerce.Cashier).Query)
	}
}
