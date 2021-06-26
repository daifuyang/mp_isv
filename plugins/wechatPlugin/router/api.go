/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	rtOrder "gincmf/plugins/restaurantPlugin/controller/app/order"
	"gincmf/plugins/wechatPlugin/controller/admin"
	"gincmf/plugins/wechatPlugin/controller/open"
	"gincmf/plugins/wechatPlugin/controller/partner"
	wechatMiddle "gincmf/plugins/wechatPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {

	adminGroup := cmf.Group("api/v1/admin", middleware.ValidationBearerToken, middleware.TenantDb, middleware.Rbac, middleware.ValidationMerchant)
	{
		adminGroup.Get("/wechat/auth/:id", new(admin.MpIsvAuth).Show, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
		adminGroup.Post("/wechat/upload", new(open.Version).Upload, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
		adminGroup.Get("/wechat/detail", new(open.Version).Detail, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
		adminGroup.Get("/wechat/members", new(open.Member).Members, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
		adminGroup.Post("/wechat/audit", new(open.Version).Audit, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
		adminGroup.Get("/wechat/latest/audit_status", new(open.Version).LatestAuditStatus, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)
	}

	wechatGroup := cmf.Group("api/v1/wechat")
	{
		wechatGroup.Post("/receive_notify", new(open.ReceiveNotify).Notify)          // 验证票据回调等
		wechatGroup.Post("/receive_notify/:id", new(open.ReceiveNotify).AppIdNotify) // 消息事件通知
		wechatGroup.Get("/pre_auth_code", new(open.Auth).PreAuthCode, middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.TenantDb, middleware.ValidationMerchant, wechatMiddle.AccessToken)
		wechatGroup.Get("/auth_redirect", new(open.Auth).Redirect, wechatMiddle.AccessToken) // 授权回调
		wechatGroup.Get("/login", new(open.Login).Login, middleware.ValidationMp, wechatMiddle.AccessToken)
		wechatGroup.Post("/applyment", new(partner.Applyment).Store, middleware.ValidationBearerToken, middleware.TenantDb)
		wechatGroup.Get("/applyment", new(partner.Applyment).Get, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant)
		wechatGroup.Get("/applyment/:id", new(partner.Applyment).Show, middleware.ValidationBearerToken, middleware.TenantDb)
		wechatGroup.Post("/applyment/:id", new(partner.Applyment).Edit, middleware.ValidationBearerToken, middleware.TenantDb)
		wechatGroup.Get("/applyment_state/:id", new(partner.Applyment).State, middleware.ValidationBearerToken, middleware.TenantDb)
		wechatGroup.Post("/pay/bind", new(partner.Applyment).BindSubMchid, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant)
		wechatGroup.Post("/pay_notify", new(rtOrder.Order).PayNotify, wechatMiddle.AccessToken)
		// 测试token
		wechatGroup.Get("/authorizer_access_token", new(open.Wxa).AccessToken, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken) // 授权回调
		wechatGroup.Get("template/sync", new(admin.Sync).Template, middleware.MainDb, wechatMiddle.AccessToken)
		wechatGroup.Get("mini_category/sync", new(admin.Sync).MiniCategory, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)

		wechatGroup.Post("/register_weapp", new(open.Wxa).FastRegisterWeApp, wechatMiddle.AccessToken)

		// 绑定模板消息通知
		wechatGroup.Get("/add_template", new(open.Wxa).AddTemplate, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken) // 授权回调

		wechatGroup.Get("/template_list", new(open.Wxa).GetTemplates, middleware.ValidationMp) // 授权回调

		// 开通及时配送权限
		wechatGroup.Post("/delivery/:id", new(open.Wxa).OpenDelivery, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken) // 授权回调

	}

}
