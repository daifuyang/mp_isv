/**
** @创建时间: 2020/12/7 10:07 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type Option struct {
	model.Option
	StoreId int `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
}

func (m *Option) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&m)
}

type EatIn struct {
	Status             int     `json:"status"`
	EnabledSellClear   int     `json:"enabled_sell_clear"` // 启用自动沽清
	EatType            int     `json:"eat_type"`
	SurchargeType      int     `json:"surcharge_type"` // 附件费类型
	Surcharge          float64 `json:"surcharge"`      // 附件费
	CustomEnabled      int     `json:"custom_enabled"`
	CustomName         string  `json:"custom_name"`
	PayType            int     `json:"pay_type"`
	BusinessStartHours string  `json:"business_start_hours"` // 起售时间
	BusinessEndHours   string  `json:"business_end_hours"`   // 截止时间
	PickUpStartTime    string  `json:"pick_up_start_time"`   // 自提时间
	PickUpEndTime      string  `json:"pick_up_end_time"`     // 自提时间
	EnabledAppointment int     `json:"enabled_appointment"`  // 启用预约
	Day                int     `json:"day"`
}

type takeOut struct {
	Status             int `json:"status"`
	BusinessHours      int `json:"business_hours"`
	PickUpTime         int `json:"pick_up_time"`        // 自提时间
	Immediate          int `json:"immediate"`           // 立即配送
	EnabledAppointment int `json:"enabled_appointment"` // 启用预约
	Appointment        int `json:"appointment"`
	AutoTakingOrder    int `json:"auto_taking_order"`
	Day                int `json:"day"`
}
