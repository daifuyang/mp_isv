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
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
	"gincmf/plugins/restaurantPlugin/controller/admin/store"
	"gincmf/plugins/restaurantPlugin/controller/admin/voucher"
	"gincmf/plugins/restaurantPlugin/controller/app/address"
	appCard "gincmf/plugins/restaurantPlugin/controller/app/card"
	"gincmf/plugins/restaurantPlugin/controller/app/common"
	appDishes "gincmf/plugins/restaurantPlugin/controller/app/dishes"
	appOrder "gincmf/plugins/restaurantPlugin/controller/app/order"
	appStore "gincmf/plugins/restaurantPlugin/controller/app/store"
	appUser "gincmf/plugins/restaurantPlugin/controller/app/user"
	appVoucher "gincmf/plugins/restaurantPlugin/controller/app/voucher"
	appRecharge "gincmf/plugins/restaurantPlugin/controller/app/recharge"
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

		adminGroup.Get("/dishes/dish_type",new(dishes.Food).DishType)
		adminGroup.Get("/dishes/flavor",new(dishes.Food).Flavor)
		adminGroup.Get("/dishes/cooking_method",new(dishes.Food).CookingMethod)

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
		adminGroup.Post("/settings/eat_in", new(settings.EatIn).Edit)

		// 充值规则配置
		adminGroup.Get("/settings/recharge", new(settings.Recharge).Show)
		adminGroup.Post("/settings/recharge", new(settings.Recharge).Edit)

		// 商户基本信息设置
		adminGroup.Get("/settings/business_info", new(settings.Common).Show)
		adminGroup.Post("/settings/business_info", AliMiddle.AppAuthToken, new(settings.Common).Edit)

		// 优惠券
		adminGroup.Rest("/voucher", new(voucher.Index), AliMiddle.AppAuthToken)

		// 会员卡
		adminGroup.Post("/card", AliMiddle.AppAuthToken, new(card.Index).Edit)
		adminGroup.Post("/card/level", AliMiddle.AppAuthToken, new(card.Level).Edit)

		// 会员
		adminGroup.Rest("/member",new(member.Index),AliMiddle.AppAuthToken)

		// 发券
		adminGroup.Post("/voucher_send", AliMiddle.AppAuthToken, new(voucher.Index).Send)
	}

	// 小程序路由注册
	appGroup := cmf.Group("api/v1/app", middleware.ValidationMp,middleware.ApiBaseController)
	{
		// 获取小程序用户
		appGroup.Get("/user/detail",middleware.ValidationUserId, new(appUser.User).Show)

		// 门店列表
		appGroup.Get("/store", new(appStore.Index).List)
		appGroup.Get("/store/:id", new(appStore.Index).Show)

		// 菜品分类
		appGroup.Get("/dishes/category", rtMiddle.ValidationStore, new(appDishes.Category).List)

		// 菜品列表
		appGroup.Get("/dishes/food", rtMiddle.ValidationStore, new(appDishes.Food).List)
		appGroup.Get("/dishes/food/:id", rtMiddle.ValidationStore, new(appDishes.Food).Detail)
		appGroup.Get("/dishes/food/:id/sku", rtMiddle.ValidationStore, new(appDishes.Food).Sku)

		// 获取订单列表
		appGroup.Get("/order/list", middleware.ValidationUserId, new(appOrder.Order).Get)
		// 创建订单
		appGroup.Post("/order/pre_create", middleware.ValidationUserId, AliMiddle.AppAuthToken, rtMiddle.ValidationStore, new(appOrder.Order).PreCreate)
		// 支付宝订单支付完成回调url
		appGroup.Post("/alipay/receive_notify", new(appOrder.Order).ReceiveNotify)
		appGroup.Rest("/address", new(address.Address))

		// 获取开卡连接
		appGroup.Get("/card/apply", middleware.ValidationUserId, AliMiddle.AppAuthToken, new(appCard.Card).Apply)
		// 申请开通会员卡
		appGroup.Get("/card/detail",middleware.ValidationUserId,  AliMiddle.AppAuthToken,new(appCard.Card).VipDetail)
		appGroup.Post("/card/send",middleware.ValidationUserId,  AliMiddle.AppAuthToken,new(appCard.Card).Send)

		// 优惠券
		appGroup.Get("/voucher",middleware.ValidationUserId,AliMiddle.AppAuthToken,new(appVoucher.Voucher).Get)
		appGroup.Get("/recharge/detail",middleware.ValidationUserId,new(appRecharge.Recharge).Show)

		// 充值
		appGroup.Post("/recharge/pay",middleware.ValidationUserId,AliMiddle.AppAuthToken,new(appRecharge.Recharge).Pay)

		// 获取堂食预约
		appGroup.Get("/appointment",rtMiddle.ValidationStore,new(common.Appointment).Show)


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
