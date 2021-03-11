/**
** @创建时间: 2021/2/25 7:28 下午
** @作者　　: return
** @描述　　:
 */
package model

type PrinterFormat struct {
	OrderType   int    `json:"order_type"`    // 订单类型 （1，2：堂食，3：打包，4：外卖）
	StoreName   string `json:"store_name"`    // 门店名称
	PayType     string `json:"pay_type"`      // 支付类型
	QueueNo     string `json:"queue_no"`      // 取餐号
	OrderDetail string `json:"order_detail"`  // 订单详情
	CouponFee   string `json:"coupon_detail"` // 优化详情
	OriginalFee string `json:"original_fee"`  // 原价
	Fee         string `json:"fee"`           // 实付
	BoxFee      string `json:"box_fee"`       // 餐盒费
	Address     string `json:"address"`       // 外送地址
	Name        string `json:"name"`          // 收件人名称
	Mobile      string `json:"mobile"`        // 联系电话
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

	orderType := ""
	switch model.OrderType {
	case 1:
		fallthrough
	case 2:
		orderType = "堂食"
	case 3:
		orderType = "自取"
	case 4:
		orderType = "外卖"
	}

	content := "<CB>" + orderType + "</CB><BR>"
	content += "<C>**" + model.StoreName + "**</C><BR>"

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

	content += "<CB>--" + payType + "--</CB><BR>"

	if model.OrderType > 1 {
		content += "<CB>取餐号：" + model.QueueNo + "</CB><BR>"
	}

	// 处理订单信息
	content += sep
	if model.OrderDetail != "" {
		content += model.OrderDetail
	}
	content += sep

	// 处理优惠券

	content += "<RIGHT><BOLD>优惠券：-￥" + model.CouponFee + "</BOLD></RIGHT>"


	if model.OrderType > 2 && model.BoxFee != "" {
		content += "<RIGHT>餐盒费：￥" + model.BoxFee + "</RIGHT>"
	}

	// 总价
	content += "<RIGHT>原价：￥" + model.OriginalFee + "</RIGHT>"
	content += "<RIGHT>实付金额：<B>￥" + model.Fee + "</B></RIGHT>"

	// 如果是外卖，加入外卖地址
	if model.OrderType == 4 {
		content += sep
		content += "<B>" + model.Address + "</B><BR>"
		content += "<B>[" + model.Name + "**]</B><BR>"
		content += "<B>" + model.Mobile + "</B><BR>"
	}

	return content

}
