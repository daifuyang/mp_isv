/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	AliMiddle "gincmf/plugins/alipayPlugin/middleware"
	"gincmf/plugins/restaurantPlugin/controller/admin/action"
	"gincmf/plugins/restaurantPlugin/controller/admin/card"
	"gincmf/plugins/restaurantPlugin/controller/admin/dashboard"
	"gincmf/plugins/restaurantPlugin/controller/admin/desk"
	"gincmf/plugins/restaurantPlugin/controller/admin/dishes"
	"gincmf/plugins/restaurantPlugin/controller/admin/member"
	"gincmf/plugins/restaurantPlugin/controller/admin/order"
	"gincmf/plugins/restaurantPlugin/controller/admin/printer"
	"gincmf/plugins/restaurantPlugin/controller/admin/qrocde"
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
	"gincmf/plugins/restaurantPlugin/controller/admin/store"
	"gincmf/plugins/restaurantPlugin/controller/admin/voucher"
	"gincmf/plugins/restaurantPlugin/controller/app/address"
	rtCard "gincmf/plugins/restaurantPlugin/controller/app/card"
	"gincmf/plugins/restaurantPlugin/controller/app/common"
	"gincmf/plugins/restaurantPlugin/controller/app/contact"
	rtDesk "gincmf/plugins/restaurantPlugin/controller/app/desk"
	rtDishes "gincmf/plugins/restaurantPlugin/controller/app/dishes"
	rtOrder "gincmf/plugins/restaurantPlugin/controller/app/order"
	rtRecharge "gincmf/plugins/restaurantPlugin/controller/app/recharge"
	rtScore "gincmf/plugins/restaurantPlugin/controller/app/score"
	rtStore "gincmf/plugins/restaurantPlugin/controller/app/store"
	rtUser "gincmf/plugins/restaurantPlugin/controller/app/user"
	rtVoucher "gincmf/plugins/restaurantPlugin/controller/app/voucher"
	rtMiddle "gincmf/plugins/restaurantPlugin/middleware"
	wechatMiddle "gincmf/plugins/wechatPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {
	// 注册后台菜单路由
	adminGroup := cmf.Group("api/v1/admin", middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.TenantDb, middleware.AllowCors, middleware.ValidationMerchant, middleware.ApiBaseController, middleware.Rbac)
	{
		adminGroup.Get("/dashboard/analysis", new(dashboard.Dashboard).DashboardCard)
		adminGroup.Get("/dashboard/sales_ranking", new(dashboard.Dashboard).DashboardSales)
		// 菜单管理
		adminGroup.Get("/dishes/store", new(store.Index).IndexWithFoodCount)
		adminGroup.Rest("/dishes/food", new(dishes.Food))
		adminGroup.Post("/dishes/food_list_order", new(dishes.Food).ListOrder)
		adminGroup.Post("/dishes/food_status/:id", new(dishes.Food).SetStatus)
		adminGroup.Get("/dishes/food_list", new(dishes.Food).List)
		adminGroup.Rest("/dishes/category", new(dishes.Category))
		adminGroup.Get("/dishes/category_list", new(dishes.Category).List)

		adminGroup.Get("/dishes/dish_type", new(dishes.Food).DishType)
		adminGroup.Get("/dishes/flavor", new(dishes.Food).Flavor)
		adminGroup.Get("/dishes/cooking_method", new(dishes.Food).CookingMethod)

		// 规格管理
		adminGroup.Post("/dishes/spec/add_key", new(dishes.SpecController).AddKey)
		adminGroup.Post("/dishes/spec/add_val", new(dishes.SpecController).AddValue)

		// 桌位管理
		adminGroup.Rest("/desk/index", new(desk.IndexController))
		adminGroup.Get("/desk/list", new(desk.IndexController).List)
		adminGroup.Rest("/desk/category", new(desk.CategoryController))

		// 门店管理
		adminGroup.Get("/store/list", new(store.Index).List)
		adminGroup.Rest("/store/index", new(store.Index), AliMiddle.ValidationAlipay)

		adminGroup.Get("/store/order/query/:id", new(store.Index).QueryStatus, AliMiddle.ValidationAlipay)

		// 订单管理
		adminGroup.Get("/order/index", new(order.Index).Index)

		// 订单详情
		adminGroup.Get("/order/detail/:id", new(order.Index).Show)

		// 会员订单
		adminGroup.Get("/order/vip", new(order.Vip).Get)

		// 充值订单
		adminGroup.Get("/order/recharge", new(order.Recharge).Get)

		// 确认订单
		adminGroup.Post("/order/confirm", new(order.Index).Confirm)

		// 用户申请取消订单
		adminGroup.Post("/order/cancel", new(order.Index).Cancel, AliMiddle.UseAlipay)

		// 发起退款
		adminGroup.Post("/order/refund/:id", new(order.Index).Refund, AliMiddle.UseAlipay, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)

		// 获取退款详情
		adminGroup.Get("/order/refund/:id", new(order.Index).RefundShow)

		// 接单或拒单
		adminGroup.Post("/order/received_or_refused/:id", new(order.Index).ReceivedOrRefused, AliMiddle.UseAlipay, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)

		// 设置订单为完成状态
		adminGroup.Post("/order/finished/:id", new(order.Index).Finished)

		// 重打订单
		adminGroup.Post("/order/printer/:id", new(order.Index).OrderPrinter)

		// 堂食基本设置
		adminGroup.Get("/settings/eat_in/:id", new(settings.EatIn).Show)
		adminGroup.Post("/settings/eat_in", new(settings.EatIn).Edit)

		// 外卖基本设置
		adminGroup.Get("/settings/take_out/:id", new(settings.TakeOut).Show)
		adminGroup.Post("/settings/take_out", new(settings.TakeOut).Edit)

		// 充值规则配置
		adminGroup.Get("/settings/recharge", new(settings.Recharge).Show)
		adminGroup.Post("/settings/recharge", new(settings.Recharge).Edit)

		// 积分规则配置
		adminGroup.Get("/settings/score", new(settings.Score).Show)
		adminGroup.Post("/settings/score", new(settings.Score).Edit)

		// 商户基本信息设置
		adminGroup.Get("/settings/business_info", new(settings.Common).Show)
		adminGroup.Post("/settings/business_info", new(settings.Common).Edit, AliMiddle.UseAlipay, AliMiddle.AppAuthToken)

		// 优惠券
		adminGroup.Rest("/voucher", new(voucher.Index), AliMiddle.UseAlipay)

		// 优惠券列表，无需分页

		// 会员卡
		adminGroup.Get("/card", new(card.Index).Show, AliMiddle.UseAlipay)
		adminGroup.Post("/card", new(card.Index).Edit, AliMiddle.UseAlipay)
		adminGroup.Get("/card/level", new(card.Level).Show, AliMiddle.UseAlipay)
		adminGroup.Post("/card/level", new(card.Level).Edit, AliMiddle.UseAlipay)

		// 会员
		adminGroup.Rest("/member", new(member.Index), AliMiddle.UseAlipay)

		// 发券
		adminGroup.Post("/voucher_send", new(voucher.Index).Send, AliMiddle.UseAlipay, AliMiddle.AppAuthToken)

		// 打印机
		adminGroup.Rest("/printer", new(printer.Printer))

		adminGroup.Get("/voucher_list", new(voucher.Index).List)

		// 绑定桌码
		adminGroup.Rest("/qrcode", new(qrocde.Qrcode), AliMiddle.ValidationAlipay)
	}

	// 小程序路由注册
	appGroup := cmf.Group("api/v1/app", middleware.ApiBaseController, middleware.ValidationMp)
	{
		// 获取小程序用户
		appGroup.Get("/user/detail", new(rtUser.User).Show, middleware.ValidationBindMobile)
		appGroup.Post("/user/save", new(rtUser.User).Save, middleware.ValidationOpenId)
		appGroup.Post("/user/avatar", new(rtUser.User).SaveAvatar, middleware.ValidationBindMobile)
		appGroup.Post("/user/save/mobile", middleware.ValidationOpenId, new(rtUser.User).SaveMobile)

		// 绑定手机号
		appGroup.Post("/user/mobile", new(rtUser.User).BindMpMobile, middleware.ValidationOpenId)

		// 门店列表
		appGroup.Get("/store", new(rtStore.Index).List)
		appGroup.Get("/store/:id", new(rtStore.Index).Show)

		// 桌位详情
		appGroup.Get("/desk/:id", new(rtDesk.Desk).Show)

		// 菜品分类
		appGroup.Get("/dishes/category", new(rtDishes.Category).List, rtMiddle.ValidationStore)

		// 菜品列表
		appGroup.Get("/dishes/food", new(rtDishes.Food).List, rtMiddle.ValidationStore)
		appGroup.Get("/dishes/food/:id", new(rtDishes.Food).Detail, rtMiddle.ValidationStore)
		appGroup.Get("/dishes/food/:id/sku", new(rtDishes.Food).Sku, rtMiddle.ValidationStore)

		// 获取订单列表
		appGroup.Get("/order/list", new(rtOrder.Order).Get, middleware.ValidationBindMobile)
		appGroup.Get("/order/detail/:id", new(rtOrder.Order).Show, middleware.ValidationBindMobile)

		// 	取消订单
		appGroup.Get("/order/cancel/:id", new(rtOrder.Order).Cancel, middleware.ValidationBindMobile)

		// 会员卡开通订单列表
		appGroup.Get("/order/card", new(rtCard.Order).Get, middleware.ValidationBindMobile)

		// 获取运费
		appGroup.Post("/order/delivery_fee/:id", new(rtOrder.Order).DeliveryFee, rtMiddle.ValidationStore)

		// 创建订单
		appGroup.Post("/order/pre_create", new(rtOrder.Order).PreCreate, middleware.ValidationBindMobile, AliMiddle.AppAuthToken, rtMiddle.ValidationStore, wechatMiddle.AccessToken, wechatMiddle.AuthorizerAccessToken)

		// 支付宝订单支付完成回调url
		appGroup.Post("/alipay/receive_notify", new(rtOrder.Order).ReceiveNotify, AliMiddle.AppAuthToken)
		appGroup.Rest("/address", new(address.Address), middleware.ValidationBindMobile)

		// 获取开卡连接
		appGroup.Get("/card/apply", new(rtCard.Card).Apply, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)
		// 申请开通会员卡
		appGroup.Get("/card/detail", new(rtCard.Card).VipDetail, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)
		appGroup.Post("/card/send", new(rtCard.Card).Send, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)

		// 同步卡券到支付宝卡包
		appGroup.Post("/card/sync/alipay", new(rtCard.Card).SyncCardToAlipay, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)

		// 优惠券
		appGroup.Get("/voucher", new(rtVoucher.Voucher).Get, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)

		// 优惠券列表
		appGroup.Get("/voucher/list", new(rtVoucher.Voucher).List, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)

		// 优惠券核销异步通知
		appGroup.Post("/alipay/voucher/receive_notify", new(rtVoucher.Voucher).ReceiveNotify, AliMiddle.AppAuthToken)

		// 充值
		appGroup.Get("/recharge/detail", new(rtRecharge.Recharge).Show, middleware.ValidationBindMobile)
		appGroup.Post("/recharge/pay", new(rtRecharge.Recharge).Pay, middleware.ValidationBindMobile, AliMiddle.AppAuthToken)
		appGroup.Get("/recharge/order", new(rtRecharge.Recharge).Order, middleware.ValidationBindMobile)

		// 积分明细
		appGroup.Get("/score/log", new(rtScore.Score).Score, middleware.ValidationBindMobile)

		// 储值明细
		appGroup.Get("/recharge/log", new(rtRecharge.Log).Get, middleware.ValidationBindMobile)

		// 获取堂食预约
		appGroup.Get("/appointment", new(common.Appointment).Show, rtMiddle.ValidationStore)

		appGroup.Get("/contact/alipay", new(contact.Contact).Get)

		appGroup.Get("/settings/common", new(settings.Common).Show)

	}

	cmf.Get("api/v1/admin/action/options", new(action.Page).Options, middleware.ValidationBearerToken, middleware.ValidationMerchant)
	cmf.Get("api/v1/admin/action/userinfo", new(action.USerInfo).Options, middleware.ValidationBearerToken, middleware.ValidationMerchant)

}
