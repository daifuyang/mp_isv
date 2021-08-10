/**
** @创建时间: 2021/3/14 9:41 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

// 开卡订单
type memberCardOrder struct {
	Id          int      `json:"id"`
	Mid         int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId     string   `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	VipNum      string   `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	TradeNo     string   `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	VipName     string   `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	VipLevel    string   `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	PayType     string   `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee         float64  `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	CreateAt    int64    `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt  int64    `gorm:"type:int(11)" json:"finished_at"`
	UserId      int      `gorm:"type:bigint(20);not null" json:"user_id"`
	OrderStatus string   `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	Db          *gorm.DB `gorm:"-" json:"-"`
}

func (migrate *memberCardOrder) AutoMigrate() {
	
	db := migrate.Db
	db.AutoMigrate(&model.MemberCard{})
	db.AutoMigrate(&memberCardOrder{})

	prefix := cmf.Conf().Database.Prefix

	db.Exec("drop event if exists memberStatus")

	// 设置会员状态已过期
	db.Exec("CREATE EVENT memberStatus ON SCHEDULE EVERY 1 SECOND DO UPDATE " + prefix + "member_card SET status = -1 WHERE end_at between 0 AND UNIX_TIMESTAMP(NOW())")

	// 设置会员订单为超时已关闭
	db.Exec("drop event if exists memberOrderCloseStatus")
	sql := "CREATE EVENT memberOrderCloseStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "member_card_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600;"
	db.Exec(sql)
}
