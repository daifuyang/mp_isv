/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/plugins/alipayPlugin/controller"
	"gincmf/plugins/alipayPlugin/controller/admin"
	"gincmf/plugins/alipayPlugin/controller/mini"
	"gincmf/plugins/alipayPlugin/controller/spi/commerce"
	"gincmf/plugins/alipayPlugin/controller/spi/merchant"
	aliMidd "gincmf/plugins/alipayPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {
	// 支付宝授权回调url

	cmf.Get("api/v1/getway", middleware.UseMp, new(controller.GetWay).GetWay)
	cmf.Post("api/v1/getway", middleware.UseMp, new(controller.GetWay).GetWay)

	adminGroup := cmf.Group("api/v1/admin", middleware.ValidationBearerToken, middleware.TenantDb)
	{
		adminGroup.Get("/alipay/auth/:id", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(admin.MpIsvAuth).Show)

		// 版本上传
		adminGroup.Get("/alipay/upload", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).Upload)

		// 版本审核
		adminGroup.Get("/alipay/audit", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).Audit)

		// 版本状态
		adminGroup.Get("/alipay/audit/detail", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).DetailQuery)

		// 查询版本详情
		adminGroup.Get("/alipay/detail", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).Detail)

		// 查询支付宝小程序详情
		adminGroup.Get("/alipay/baseinfo", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.BaseInfo).Detail)

		// 成员管理
		adminGroup.Get("/alipay/members", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Members).Get)
		adminGroup.Post("/alipay/members", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Members).Store)
		adminGroup.Delete("/alipay/members", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Members).Delete)

		// 设置小程序为体验版
		adminGroup.Post("/alipay/experience/create", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).ExperienceCreate)
		adminGroup.Get("/alipay/experience/query", middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken, new(mini.Version).ExperienceQuery)

	}

	alipayGroup := cmf.Group("api/v1/alipay", middleware.AllowCors)
	{
		alipayGroup.Get("/auth_redirect", new(controller.Auth).Redirect)
		alipayGroup.Get("/auth_qrcode", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, middleware.ValidationAdmin, new(controller.Auth).OutAuthQrcode)
		alipayGroup.Get("/oauth_token", middleware.ValidationMp, aliMidd.AppAuthToken, new(controller.Auth).Token)
	}

	spiGroup := cmf.Group("api/v1/spi", middleware.AllowCors)
	{
		spiGroup.Get("/test", new(merchant.Order).Test)
		spiGroup.Post("/test", new(merchant.Order).Test)
		spiGroup.Post("/pay", aliMidd.SpiLot, new(merchant.Order).Pay)
		spiGroup.Post("/query", aliMidd.SpiLot, new(merchant.Order).Query)
		spiGroup.Post("/cashier/batch_query", aliMidd.SpiLot, new(commerce.Cashier).BatchQuery)
		spiGroup.Post("/cashier/query", aliMidd.SpiLot, new(commerce.Cashier).Query)
	}
}
