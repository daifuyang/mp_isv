/**
** @创建时间: 2021/1/20 11:52 上午
** @作者　　: return
** @描述　　:
 */
package action

import (
	"gincmf/plugins/portalPlugin/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Page struct {
	rc controller.Rest
}

type option struct {
	Label  string      `json:"label"`
	Value  string      `json:"value"`
	Method string      `json:"method"`
	Extra  interface{} `json:"extra"`
}

func (rest Page) Options(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt := mid.(int)

	t := c.Query("type")

	if t == "" {
		rest.rc.Error(c, "类型不能为空！", nil)
		return
	}

	var options []option

	scan := resModel.Scan{}
	data, err := scan.Show(midInt)

	var couponExtra struct {
		AppId string `json:"app_id"`
		Path  string `json:"path"`
	}

	couponExtra.AppId = data.AppId
	couponExtra.Path = data.Path

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if t == "func" {
		options = []option{{
			Label:  "堂食就餐",
			Value:  "pages/store/index?scene=eatin",
			Method: "switchTab",
		}, {
			Label:  "到店取餐",
			Value:  "pages/store/index?scene=pack",
			Method: "switchTab",
		}, {
			Label:  "外卖送餐",
			Value:  "pages/store/index?scene=takeout",
			Method: "switchTab",
		}, {
			Label:  "扫码点餐",
			Value:  "func/scan",
			Method: "func/scan",
		}, {
			Label:  "领券中心",
			Value:  "pages/coupon/coupon",
			Method: "miniProgram",
			Extra:  couponExtra,
		}, {
			Label:  "我的",
			Value:  "pages/mine/index",
			Method: "switchTab",
		}, {
			Label: "开通会员",
			Value: "pages/order/vip/index",
		}, {
			Label: "积分",
			Value: "pages/mine/score/index",
		}, {
			Label: "优惠券",
			Value: "pages/mine/coupon/index",
		}, {
			Label: "余额储值",
			Value: "pages/mine/money/index",
		}, {
			Label:  "堂食/外卖订单",
			Value:  "pages/order/index",
			Method: "switchTab",
		}, {
			Label: "会员开卡订单",
			Value: "pages/order/vip/index",
		}, {
			Label: "余额储值订单",
			Value: "pages/order/recharge/index",
		}, {
			Label: "地址管理",
			Value: "pages/mine/address/index",
		}}
	}

	if t == "page" {
		options = []option{{
			Label:  "首页",
			Value:  "page/index/index",
			Method: "switchTab",
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
