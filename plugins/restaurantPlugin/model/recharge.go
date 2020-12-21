/**
** @创建时间: 2020/12/18 8:58 下午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

// 充值订单支付状态
type RechargeOrder struct {
	Id           int     `json:"id"`
	OrderId      string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo      string  `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	UserId       int     `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	PayType      string  `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee          float64 `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	CreateAt     int64   `gorm:"type:int(11)" json:"create_at"`
	FinishedAt   int64   `gorm:"type:int(11)" json:"finished_at"`
	CreateTime   string  `gorm:"-" json:"create_time"`
	FinishedTime string  `gorm:"-" json:"finished_time"`
	OrderStatus  string  `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
}

func (model *RechargeOrder) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}
