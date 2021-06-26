/**
** @创建时间: 2021/2/25 7:28 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"strings"
)

type PrinterFormat struct {
	Brand           string `json:"brand"`            //打印机类型
	OrderType       int    `json:"order_type"`       // 订单类型 （1，2：堂食，3：打包，4：外卖）
	StoreName       string `json:"store_name"`       // 门店名称
	PayType         string `json:"pay_type"`         // 支付类型
	DeskName        string `json:"desk_name"`        // 桌号名称
	QueueNo         string `json:"queue_no"`         // 取餐号
	OrderDetail     string `json:"order_detail"`     // 订单详情
	CouponFee       string `json:"coupon_detail"`    // 优化详情
	OriginalFee     string `json:"original_fee"`     // 原价
	Fee             string `json:"fee"`              // 实付
	BoxFee          string `json:"box_fee"`          // 餐盒费
	DeliveryFee     string `json:"delivery_fee"`     // 配送费
	Address         string `json:"address"`          // 外送地址
	Name            string `json:"name"`             // 收件人名称
	Mobile          string `json:"mobile"`           // 联系电话
	AppointmentTime string `json:"appointment_time"` // 预约时间
	Remark          string `json:"remark"`           //增加备注
	OutTradeNo      string `json:"out_trade_no"`     // 外部订单编号
	TradeNo         string `json:"trade_no"`         // 支付宝交易号
	Pattern         int    `json:"pattern"`          // 一菜一单（pattern = 1）
	Complete        bool   `json:"complete"`         // 一菜一单全部完成
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 格式化打印数据
 * @Date 2021/2/25 19:28:50
 * @Param
 * @return
 **/
func (model *PrinterFormat) Format(t string) string {

	// 分隔符
	sep := ""

	len := 32
	if t == "80mm" {
		len = 48
	}

	for i := 0; i < len; i++ {
		sep += "-"
	}

	sep += "<BR>"

	var content string
	orderType := ""
	appointLabel := ""
	switch model.OrderType {
	case 1:
		fallthrough
	case 2:
		appointLabel = "就餐时间"
		orderType = "堂食"
	case 3:
		appointLabel = "预约时间"
		orderType = "自取"
	case 4:
		appointLabel = "预约时间"
		orderType = "外卖"
	}

	// 支付类型
	payType := ""
	switch model.PayType {
	case "balance":
		payType = "余额支付"
	case "alipay":
		payType = "支付宝"
	case "wxpay":
		payType = "微信支付"
	}

	var number string

	// 整单打印
	if model.Pattern == 0 {
		content = "<CB>" + orderType + "</CB><BR>"
		content += "<C>**" + model.StoreName + "**</C><BR>"

		content += "<C>" + appointLabel + "：" + model.AppointmentTime + "</C><BR>"

		// 订单备注
		if model.Remark != "" {
			content += "<CB>" + model.Remark + "</CB><BR>"
		}

		content += "<CB>--" + payType + "--</CB><BR>"

		if model.QueueNo != "" {
			number = model.QueueNo
			content += "<CB>取餐号：" + model.QueueNo + "</CB><BR>"
		}

		if model.DeskName != "" {
			number = model.DeskName
			content += "<CB>桌号：" + model.DeskName + "</CB><BR>"
		}

		// 处理订单信息
		content += sep
		if model.OrderDetail != "" {
			content += model.OrderDetail
		}
		content += sep

		// 处理优惠券
		content += "<RIGHT><BOLD>优惠券：-￥" + model.CouponFee + "</BOLD></RIGHT>"

		if model.OrderType > 2 && model.BoxFee != "0" {
			content += "<RIGHT>餐盒费：￥" + model.BoxFee + "</RIGHT>"
		}

		if model.DeliveryFee != "0" {
			content += "<RIGHT>配送费：￥" + model.DeliveryFee + "</RIGHT>"
		}

		// 总价
		content += "<RIGHT>原价：￥" + model.OriginalFee + "</RIGHT>"
		content += "<RIGHT>实付金额：<B>￥" + model.Fee + "</B></RIGHT>"

		if model.OutTradeNo != "" {
			content += sep
			content += "订单编号：" + model.OutTradeNo + "<BR>"

			if model.TradeNo != "" {

				content += payType

				content += "流水号：<BR>"
				content += model.TradeNo + "<BR>"
			}

		}

		// 如果是外卖，加入外卖地址
		if model.OrderType == 4 {
			content += sep
			content += "<B>" + model.Address + "</B><BR>"
			content += "<B>[" + model.Name + "**]</B><BR>"
			content += "<B>" + model.Mobile + "</B><BR>"
		}

		// 版权信息
		content += sep
		content += "系统支持：码上点<BR>"
		content += "码上点官网：www.mashangdian.cn<BR>"
		content += "服务热线：171-777-23588<BR>"

		content += "<CB>**" + number + "完**</CB><BR>"

	}

	// 一菜一单
	if model.Pattern == 1 {
		content = ""
		if model.QueueNo != "" {
			number = model.QueueNo
			content += "<CB>取餐号：" + model.QueueNo + "</CB><BR>"
		}

		if model.DeskName != "" {
			number = model.DeskName
			content += "<CB>桌号：" + model.DeskName + "</CB><BR>"
		}

		content += "<CB>" + orderType + "</CB><BR>"
		content += "<C>**" + model.StoreName + "**</C><BR>"
		content += "<C>" + appointLabel + "：" + model.AppointmentTime + "</C><BR>"

		// 订单备注
		if model.Remark != "" {
			content += "<CB>" + model.Remark + "</CB><BR>"
		}

		if model.OutTradeNo != "" {
			content += sep
			content += "订单编号：" + model.OutTradeNo + "<BR>"
		}

		content += sep
		if model.OrderDetail != "" {
			content += model.OrderDetail
		}
		content += sep

		if model.Complete {
			content += "<CB>**" + number + "完**</CB><BR>"
		}

	}

	if model.Brand == "xprinter" {
		content = strings.ReplaceAll(content, "<L>", "<HB>")
		content = strings.ReplaceAll(content, "<W>", "<WB>")
		content = strings.ReplaceAll(content, "<RIGHT>", "<R>")
		content = strings.ReplaceAll(content, "</RIGHT>", "<BR></R>")
	}

	return content

}
