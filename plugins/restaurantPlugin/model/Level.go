/**
** @创建时间: 2020/12/13 10:40 上午
** @作者　　: return
** @描述　　:
 */
package model

type Level struct {
}

// 优惠券详情
type voucher struct {
	Once  []voucherItem `json:"once"`
	Month []voucherItem `json:"month"`
}

type voucherItem struct {
	SendType    string `json:"send_type"` //发放方式：once：发放1次 month：每月发放
	VoucherName string `json:"voucher_name"`
	VoucherId   int    `json:"voucher_id"`
	TemplateId  string `json:"template_id"`
}

// 等级权益
type Benefit struct {
	DiscountEnabled int     `json:"discount_enabled"`
	Discount        float64 `json:"discount"`
	PointsEnabled   int     `json:"points_enabled"`
	Points          int     `json:"points"`
	VoucherEnabled  int     `json:"voucher_enabled"`
	Voucher         voucher `json:"voucher"`
}

// 等级
type SLevel struct {
	Num           float64 `json:"num"`      //获取门槛数值
	GetType       string  `json:"get_type"` //获得方式 free:免费 pay:付费 storage:储值
	LevelId       string  `json:"level_id"`
	LevelName     string  `json:"level_name"`
	ExpRangeStart int     `json:"exp_range_start"`
	ExpRangeEnd   int     `json:"exp_range_end"`
	Benefit       Benefit `json:"benefit"`
}

type VipInfo struct {
	RechargePoint  int      `json:"recharge_point"`
	ConsumePoint   int      `json:"consume_point"`
	ExpValidPeriod int      `json:"exp_valid_period"`
	Level          []SLevel `json:"level"`
}
