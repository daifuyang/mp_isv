/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"fmt"
	"gincmf/app/middleware"
	AliMiddle "gincmf/plugins/alipayPlugin/middleware"
	"gincmf/plugins/restaurantPlugin/controller/admin/card"
	"gincmf/plugins/restaurantPlugin/controller/admin/desk"
	"gincmf/plugins/restaurantPlugin/controller/admin/dishes"
	"gincmf/plugins/restaurantPlugin/controller/admin/member"
	"gincmf/plugins/restaurantPlugin/controller/admin/order"
	"gincmf/plugins/restaurantPlugin/controller/admin/printer"
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
	"gincmf/plugins/restaurantPlugin/controller/admin/store"
	"gincmf/plugins/restaurantPlugin/controller/admin/voucher"
	"gincmf/plugins/restaurantPlugin/controller/app/address"
	rtCard "gincmf/plugins/restaurantPlugin/controller/app/card"
	"gincmf/plugins/restaurantPlugin/controller/app/common"
	rtDishes "gincmf/plugins/restaurantPlugin/controller/app/dishes"
	rtOrder "gincmf/plugins/restaurantPlugin/controller/app/order"
	rtRecharge "gincmf/plugins/restaurantPlugin/controller/app/recharge"
	rtScore "gincmf/plugins/restaurantPlugin/controller/app/score"
	rtStore "gincmf/plugins/restaurantPlugin/controller/app/store"
	rtUser "gincmf/plugins/restaurantPlugin/controller/app/user"
	rtVoucher "gincmf/plugins/restaurantPlugin/controller/app/voucher"
	rtMiddle "gincmf/plugins/restaurantPlugin/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gorilla/websocket"
	"log"
	"net/http"
	"strconv"
	"time"
)

func ApiListenRouter() {
	// 注册后台菜单路由
	adminGroup := cmf.Group("api/v1/admin", middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.TenantDb, middleware.AllowCors, middleware.ValidationMerchant, middleware.ApiBaseController, middleware.Rbac)
	{
		// 菜单管理
		adminGroup.Get("/dishes/store", new(store.IndexController).IndexWithFoodCount)
		adminGroup.Rest("/dishes/food", new(dishes.Food))
		adminGroup.Rest("/dishes/category", new(dishes.CategoryController))

		adminGroup.Get("/dishes/dish_type", new(dishes.Food).DishType)
		adminGroup.Get("/dishes/flavor", new(dishes.Food).Flavor)
		adminGroup.Get("/dishes/cooking_method", new(dishes.Food).CookingMethod)

		// 规格管理
		adminGroup.Post("/dishes/spec/add_key", new(dishes.SpecController).AddKey)
		adminGroup.Post("/dishes/spec/add_val", new(dishes.SpecController).AddValue)

		// 桌位管理
		adminGroup.Rest("/desk/index", new(desk.IndexController))
		adminGroup.Rest("/desk/category", new(desk.CategoryController))

		// 门店管理
		adminGroup.Get("/store/list", new(store.IndexController).List)
		adminGroup.Rest("/store/index", new(store.IndexController))

		// 订单管理
		adminGroup.Get("/order/index", new(order.Index).Index)
		// 确认订单
		adminGroup.Post("/order/confirm", new(order.Index).Confirm)

		// 用户申请取消订单
		adminGroup.Post("/order/cancel", AliMiddle.AppAuthToken, new(order.Index).Cancel)

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
		adminGroup.Post("/settings/business_info", AliMiddle.AppAuthToken, new(settings.Common).Edit)

		// 优惠券
		adminGroup.Rest("/voucher", new(voucher.Index), AliMiddle.AppAuthToken)

		// 优惠券列表，无需分页

		// 会员卡
		adminGroup.Get("/card", AliMiddle.AppAuthToken, new(card.Index).Show)
		adminGroup.Post("/card", AliMiddle.AppAuthToken, new(card.Index).Edit)
		adminGroup.Get("/card/level", AliMiddle.AppAuthToken, new(card.Level).Show)
		adminGroup.Post("/card/level", AliMiddle.AppAuthToken, new(card.Level).Edit)

		// 会员
		adminGroup.Rest("/member", new(member.Index), AliMiddle.AppAuthToken)

		// 发券
		adminGroup.Post("/voucher_send", AliMiddle.AppAuthToken, new(voucher.Index).Send)

		// 打印机
		adminGroup.Rest("/printer", new(printer.Printer))
	}

	// 小程序路由注册
	appGroup := cmf.Group("api/v1/app", middleware.ValidationMp, middleware.ApiBaseController)
	{
		// 获取小程序用户
		appGroup.Get("/user/detail", middleware.ValidationUserId, new(rtUser.User).Show)
		appGroup.Post("/user/save", middleware.ValidationUserId, new(rtUser.User).Save)

		// 门店列表
		appGroup.Get("/store", new(rtStore.Index).List)
		appGroup.Get("/store/:id", new(rtStore.Index).Show)

		// 菜品分类
		appGroup.Get("/dishes/category", rtMiddle.ValidationStore, new(rtDishes.Category).List)

		// 菜品列表
		appGroup.Get("/dishes/food", rtMiddle.ValidationStore, new(rtDishes.Food).List)
		appGroup.Get("/dishes/food/:id", rtMiddle.ValidationStore, new(rtDishes.Food).Detail)
		appGroup.Get("/dishes/food/:id/sku", rtMiddle.ValidationStore, new(rtDishes.Food).Sku)

		// 获取订单列表
		appGroup.Get("/order/list", middleware.ValidationUserId, new(rtOrder.Order).Get)
		// 创建订单
		appGroup.Post("/order/pre_create", middleware.ValidationUserId, AliMiddle.AppAuthToken, rtMiddle.ValidationStore, new(rtOrder.Order).PreCreate)
		// 支付宝订单支付完成回调url
		appGroup.Post("/alipay/receive_notify", AliMiddle.AppAuthToken, new(rtOrder.Order).ReceiveNotify)
		appGroup.Rest("/address", new(address.Address))

		// 获取开卡连接
		appGroup.Get("/card/apply", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtCard.Card).Apply)
		// 申请开通会员卡
		appGroup.Get("/card/detail", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtCard.Card).VipDetail)
		appGroup.Post("/card/send", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtCard.Card).Send)

		// 同步卡券到支付宝卡包
		appGroup.Post("/card/sync/alipay", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtCard.Card).SyncCardToAlipay)

		// 优惠券
		appGroup.Get("/voucher", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtVoucher.Voucher).Get)

		// 充值
		appGroup.Get("/recharge/detail", middleware.ValidationUserId, new(rtRecharge.Recharge).Show)
		appGroup.Post("/recharge/pay", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(rtRecharge.Recharge).Pay)
		appGroup.Get("/recharge/order", middleware.ValidationUserId, new(rtRecharge.Recharge).Order)

		// 积分明细
		appGroup.Get("/score/log", middleware.ValidationUserId, new(rtScore.Score).Score)

		// 获取堂食预约
		appGroup.Get("/appointment", rtMiddle.ValidationStore, new(common.Appointment).Show)

	}

	// 注册webSocket
	cmf.Socket("/socket/v1/admin/order", new(order.Index).Order)

	cmf.Socket("/test", func(w http.ResponseWriter, r *http.Request) {

		var upgrader = websocket.Upgrader{
			// 允许跨域
			CheckOrigin: func(r *http.Request) bool {
				return true
			},
		} // use default options

		c, err := upgrader.Upgrade(w, r, nil)
		if err != nil {
			log.Print("upgrade:", err)
			return
		}

		defer c.Close()

		mt, message, err := c.ReadMessage()
		if err != nil {
			log.Println("read:", err)
		}

		fmt.Println("accept", string(message))

		for {
			err = c.WriteMessage(mt, []byte(strconv.Itoa(mt)+"hello world"))
			if err != nil {
				log.Println("write:", err)
				return
			}

			time.Sleep(1 * time.Second)
		}
	})
}
