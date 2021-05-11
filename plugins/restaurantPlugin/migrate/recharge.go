/**
** @创建时间: 2021/4/24 7:21 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import cmf "github.com/gincmf/cmf/bootstrap"

// 充值订单支付状态
type RechargeOrder struct {
	Id          int     `json:"id"`
	Mid         int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId     string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo     string  `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	UserId      int     `gorm:"type:bigint(20);comment:用户所属id;not null" json:"user_id"`
	PayType     string  `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee         float64 `gorm:"type:decimal(7,2);comment:支付金额;default:0;not null" json:"fee"`
	ActualFee   float64 `gorm:"type:decimal(7,2);comment:实际金额;default:0;not null" json:"actual_fee"`
	SendFee     float64 `gorm:"type:decimal(7,2);comment:赠送金额;default:0;not null" json:"send_fee"`
	CreateAt    int64   `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt  int64   `gorm:"type:int(11)" json:"finished_at"`
	OrderStatus string  `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
}

func (model *RechargeOrder) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&RechargeOrder{})

	prefix := cmf.Conf().Database.Prefix

	// 设置会员订单为超时已关闭
	cmf.NewDb().Exec("drop event if exists rechargeOrderCloseStatus")
	sql := "CREATE EVENT rechargeOrderCloseStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "recharge_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600;"
	cmf.NewDb().Exec(sql)

}
