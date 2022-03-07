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

	cmf.Get("api/v1/getway", new(controller.GetWay).GetWay, middleware.UseMp)
	cmf.Post("api/v1/getway", new(controller.GetWay).GetWay, middleware.UseMp)

	adminGroup := cmf.Group("api/v1/admin/alipay", middleware.ValidationBearerToken, middleware.TenantDb, middleware.Rbac)
	{
		adminGroup.Get("/auth/:id", new(admin.MpIsvAuth).Show, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 版本上传
		adminGroup.Post("/upload", new(mini.Version).Upload, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 版本审核
		adminGroup.Get("/audit", new(mini.Version).Audit, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 版本状态
		adminGroup.Get("/audit/detail", new(mini.Version).DetailQuery, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 查询版本详情
		adminGroup.Get("/detail", new(mini.Version).Detail, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 查询支付宝小程序详情
		adminGroup.Get("/baseinfo", new(mini.BaseInfo).Detail, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 成员管理
		adminGroup.Get("/members", new(mini.Members).Get, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)
		adminGroup.Post("/members", new(mini.Members).Store, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)
		adminGroup.Delete("/members", new(mini.Members).Delete, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 设置小程序为体验版
		adminGroup.Post("/experience/create", new(mini.Version).ExperienceCreate, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)
		adminGroup.Get("/experience/query", new(mini.Version).ExperienceQuery, middleware.ValidationMerchant, aliMidd.ValidationAlipay, aliMidd.AppAuthToken)

		// 智能云客服配置
		adminGroup.Get("/contact/button", new(admin.ContactButton).Get, middleware.ValidationMerchant)
		adminGroup.Post("/contact/button", new(admin.ContactButton).Edit, middleware.ValidationMerchant)

		// 开通支付宝同城配送接口
		adminGroup.Post("/delivery/:id", new(admin.InstantDelivery).OpenDelivery, middleware.ValidationMerchant)

	}

	alipayGroup := cmf.Group("api/v1/alipay", middleware.AllowCors)
	{
		alipayGroup.Get("/auth_redirect", new(controller.Auth).Redirect)
		alipayGroup.Get("/auth_qrcode", new(controller.Auth).OutAuthQrcode, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, middleware.ValidationAdmin)
		alipayGroup.Get("/oauth_token", new(controller.Auth).Token, middleware.ValidationMp, aliMidd.AppAuthToken)
	}

	spiGroup := cmf.Group("api/v1/spi", middleware.AllowCors)
	{
		spiGroup.Get("/test", new(merchant.Order).Test)
		spiGroup.Post("/test", new(merchant.Order).Test)
		spiGroup.Post("/pay", new(merchant.Order).Pay, aliMidd.SpiLot)
		spiGroup.Post("/query", new(merchant.Order).Query, aliMidd.SpiLot)
		spiGroup.Post("/cashier/batch_query", new(commerce.Cashier).BatchQuery, aliMidd.SpiLot)
		spiGroup.Post("/cashier/query", new(commerce.Cashier).Query, aliMidd.SpiLot)
	}
}
