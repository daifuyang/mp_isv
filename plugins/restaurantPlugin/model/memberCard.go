/**
** @创建时间: 2020/12/13 1:55 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"strings"
)

// 用户vip表
type MemberCard struct {
	Id        int    `json:"id"`
	Mid       int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	UserId    int    `gorm:"type:int(11);not null" json:"user_id"`
	VipNum    string `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	VipLevel  string `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	VipName   string `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	StartAt   int64  `gorm:"type:int(11);comment:起始时间;not null" json:"start_at"`
	EndAt     int64  `gorm:"type:int(11);comment:截止时间;not null" json:"end_at"`
	StartTime string `gorm:"-" json:"start_time"`
	EndTime   string `gorm:"-" json:"end_time"`
	CreateAt  int64  `gorm:"type:int(11);not null" json:"create_at"`
	UpdateAt  int64  `gorm:"type:int(11);not null" json:"update_at"`
	DeleteAt  int64  `gorm:"type:int(11);not null" json:"delete_at"`
	Status    int    `gorm:"type:tinyint(3);default:1;not null" json:"status"`
}

// 开卡订单
type MemberCardOrder struct {
	Id           int     `json:"id"`
	Mid          int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId      string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	VipNum       string  `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	TradeNo      string  `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	VipLevel     string  `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	UserId       int     `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	PayType      string  `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee          float64 `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	CreateAt     int64   `gorm:"type:int(11)" json:"create_at"`
	FinishedAt   int64   `gorm:"type:int(11)" json:"finished_at"`
	CreateTime   string  `gorm:"-" json:"create_time"`
	FinishedTime string  `gorm:"-" json:"finished_time"`
	OrderStatus  string  `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
}

func (model *MemberCard) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&MemberCardOrder{})
}

func (model *MemberCard) Show(query []string, queryArgs []interface{}) (MemberCard, error) {

	mc := MemberCard{}
	queryStr := strings.Join(query, " AND ")
	tx := cmf.NewDb().Where(queryStr, queryArgs...).First(&mc)

	if tx.Error != nil {
		return mc, tx.Error
	}

	return mc, nil
}
