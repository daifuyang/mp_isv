/**
** @创建时间: 2020/12/1 10:43 上午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

type PayLog struct {
	Id             int     `json:"id"`
	OrderId        string  `gorm:"type:varchar(40);comment:系统订单号;not null" json:"order_id"`
	TradeNo        string  `gorm:"type:varchar(64);comment:第三方订单号;not null" json:"trade_no"`
	Type           string  `gorm:"type:varchar(40);comment:支付类型;not null" json:"type"`
	AppId          string  `gorm:"type:varchar(32);comment:小程序appId;not null" json:"app_id"`
	UserId         int     `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	BuyerId        string  `gorm:"type:varchar(16);comment:支付宝付款人id" json:"buyer_id"`
	TotalAmount    float64 `gorm:"type:decimal(9,2);comment:本次交易支付的订单金额，单位为人民币（元）;not null" json:"total_amount"`
	ReceiptAmount  float64 `gorm:"type:decimal(9,2);comment:商家在交易中实际收到的款项，单位为人民币（元）" json:"receipt_amount"`
	InvoiceAmount  float64 `gorm:"type:decimal(9,2);comment:用户在交易中支付的可开发票的金额" json:"invoice_amount"`
	BuyerPayAmount float64 `gorm:"type:decimal(9,2);comment:用户在交易中支付的金额" json:"buyer_pay_amount"`
	PointAmount    float64 `gorm:"type:decimal(9,2);comment:使用集分宝支付的金额" json:"point_amount"`
	RefundFee      float64 `gorm:"type:decimal(9,2);comment:退款通知中，返回总退款金额，单位为元，支持两位小数" json:"refund_fee"`
	SendBackFee    float64 `gorm:"type:decimal(9,2);comment:商户实际退款给用户的金额，单位为元，支持两位小数" json:"send_back_fee"`
	Subject        string  `gorm:"type:varchar(256);comment:商品的标题/交易标题/订单标题/订单关键字等，是请求时对应的参数，原样通知回来。" json:"subject"`
	Body           string  `gorm:"type:varchar(400);comment:该订单的备注、描述、明细等。对应请求时的 body 参数，原样通知回来。" json:"body"`
	FundBillList   string  `gorm:"type:json;comment:支付成功的各个渠道金额信息" json:"fund_bill_list"`
	GmtPayment     int64   `gorm:"type:int(11);comment:交易付款时间" json:"gmt_payment"`
	GmtRefund      int64   `gorm:"type:int(11);comment:交易退款时间" json:"gmt_refund"`
	GmtClose       int64   `gorm:"type:int(11);comment:交易结束时间" json:"gmt_close"`
	TradeStatus    string  `gorm:"type:varchar(32);comment:交易状态;not null" json:"trade_status"`
}

func (model PayLog) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}
