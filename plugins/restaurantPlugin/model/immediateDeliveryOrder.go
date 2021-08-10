/**
** @创建时间: 2021/6/15 4:42 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"gorm.io/gorm"
)

type ImmediateDeliveryOrder struct {
	Id             int      `json:"id"`
	Mid            int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId        string   `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	ShopOrderId    string   `gorm:"type:varchar(40);comment:物流外部订单号;not null" json:"shop_order_id"`
	WaybillId      string   `gorm:"type:varchar(40);comment:物流运单编号;not null" json:"waybill_id"`
	DeliveryToken  string   `gorm:"type:varchar(40);comment:预下单接口token" json:"delivery_token"`
	DeliveryId     string   `gorm:"type:varchar(40);comment:即时配送物流公司代码" json:"delivery_id"`
	DeliveryName   string   `gorm:"type:varchar(40);comment:即时配送物流公司名称" json:"delivery_name"`
	DeliveryFee    float64  `gorm:"type:decimal(7,2);comment:即时配送总费用" json:"delivery_fee"`
	DeliveryFree   float64  `gorm:"type:decimal(7,2);comment:即时配送优惠费用" json:"delivery_free"`
	BuyerPayAmount float64  `gorm:"type:decimal(7,2);comment:即时配送用户在交易中支付的金额" json:"buyer_pay_amount"`
	CreateAt       int64    `gorm:"type:bigint(20)" json:"create_at"`
	OrderStatus    int      `gorm:"type:int(11);comment:运输状态" json:"order_status"`
	FinishedAt     int64    `gorm:"type:int(11)" json:"finished_at"`
	CreateTime     string   `gorm:"-" json:"create_time"`
	FinishedTime   string   `gorm:"-" json:"finished_time"`
	Db             *gorm.DB `gorm:"-" json:"-"`
}

type DeliveryMap struct {
	ShopOrderId   string  `json:"shop_order_id"`
	DeliveryToken string  `json:"delivery_token"`
	DeliveryId    string  `json:"delivery_id"`
	DeliveryName  string  `json:"delivery_name"`
	TotalAmount   float64 `json:"total_amount"`
	DeliveryFee   float64 `json:"delivery_fee"`
	DeliveryFree  float64 `json:"delivery_free"`
}

func (model *ImmediateDeliveryOrder) AutoMigrate() {
	model.Db.AutoMigrate(&ImmediateDeliveryOrder{})
}
