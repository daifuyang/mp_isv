/**
** @创建时间: 2020/12/13 10:40 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	saasModel "gincmf/plugins/saasPlugin/model"
)

type Level struct {
}

// 优惠券详情
type voucher struct {
	Once  []VoucherItem `json:"once"`
	Month []VoucherItem `json:"month"`
}

type VoucherItem struct {
	SendType              string   `json:"send_type"` //发放方式：once：发放1次 month：每月发放
	Count                 int      `json:"count"`
	VoucherName           string   `json:"voucher_name"`
	VoucherDescription    string   `json:"voucher_description"`
	VoucherDescriptionMap []string `json:"voucher_description_map"`
	VoucherId             int      `json:"voucher_id"`
	TemplateId            string   `json:"template_id"`
}

// 等级权益
type Benefit struct {
	EnabledDiscount int     `json:"enabled_discount"`
	Discount        float64 `json:"discount"`
	EnabledPoint    int     `json:"enabled_point"`
	Point           int     `json:"point"`
	EnabledVoucher  int     `json:"enabled_voucher"`
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
	EnabledRecharge int      `json:"enabled_recharge"` // 启用充值送
	RechargePoint   int      `json:"recharge_point"`   // 经验值
	EnabledConsume  int      `json:"enabled_consume"`  // 启用消费送
	ConsumePoint    int      `json:"consume_point"`    // 经验值
	ExpValidPeriod  int      `json:"exp_valid_period"`
	Level           []SLevel `json:"level"`
}

func (model *Level) LevelDetail(vipLevel string, mid int) SLevel {

	var vipInfo VipInfo
	str := saasModel.Options("vip_info", mid)

	_ = json.Unmarshal([]byte(str), &vipInfo)

	for _, v := range vipInfo.Level {
		if v.LevelId == vipLevel {
			return v
		}
	}

	return SLevel{}

}
