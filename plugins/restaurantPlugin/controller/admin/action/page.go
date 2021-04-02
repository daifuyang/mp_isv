/**
** @创建时间: 2021/1/20 11:52 上午
** @作者　　: return
** @描述　　:
 */
package action

import (
	"gincmf/plugins/portalPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Page struct {
	rc controller.Rest
}

func (rest Page) Options(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt := mid.(int)

	t := c.Query("type")

	if t == "" {
		rest.rc.Error(c, "类型不能为空！", nil)
		return
	}

	var options []map[string]string

	if t == "func" {
		options = []map[string]string{{
			"label":  "到店取餐",
			"value":  "pages/store/index?scene=pack",
			"method": "switchTab",
		}, {
			"label":  "外卖送餐",
			"value":  "pages/store/index?scene=takeout",
			"method": "switchTab",
		}, {
			"label":  "扫码点餐",
			"value":  "func/scan",
			"method": "func/scan",
		}, {
			"label":  "我的",
			"value":  "pages/mine/index",
			"method": "switchTab",
		}, {
			"label": "开通会员",
			"value": "pages/order/vip/index",
		}, {
			"label": "积分",
			"value": "pages/mine/score/index",
		}, {
			"label": "优惠券",
			"value": "pages/mine/coupon/index",
		}, {
			"label": "余额储值",
			"value": "pages/mine/money/index",
		}, {
			"label":  "堂食/外卖订单",
			"value":  "pages/order/index",
			"method": "switchTab",
		}, {
			"label": "会员开卡订单",
			"value": "pages/order/vip/index",
		}, {
			"label": "余额储值订单",
			"value": "pages/order/recharge/index",
		}, {
			"label": "地址管理",
			"value": "pages/mine/address/index",
		}}
	}

	if t == "page" {
		options = []map[string]string{{
			"label":  "首页",
			"value":  "page/index/index",
			"method": "switchTab",
		}}
	}

	if t == "list" {

		category := model.PortalCategory{
			Mid: midInt,
		}

		data, err := category.ListWithTree()
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		rest.rc.Success(c, "获取成功！", data)
		return

	}

	rest.rc.Success(c, "获取成功！", options)
}
