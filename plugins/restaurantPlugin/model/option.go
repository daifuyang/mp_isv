/**
** @创建时间: 2020/12/7 10:07 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

type Option struct {
	model.Option
	Mid     int `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId int `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
}

func (m *Option) AutoMigrate() {
	_ = cmf.NewDb().AutoMigrate(&m)
}

type EatIn struct {
	Status           int     `json:"status"`
	EnabledSellClear int     `json:"enabled_sell_clear"` // 启用自动沽清
	SellClear        string  `json:"sell_clear"`
	SaleType         int     `json:"sale_type"`
	EatType          int     `json:"eat_type"`
	SurchargeType    int     `json:"surcharge_type"` // 附件费类型
	Surcharge        float64 `json:"surcharge"`      // 附件费
	CustomEnabled    int     `json:"custom_enabled"`
	CustomName       string  `json:"custom_name"`
	PayType          int     `json:"pay_type"`
	/*BusinessStartHours string  `json:"business_start_hours"` // 起售时间
	BusinessEndHours   string  `json:"business_end_hours"`   // 截止时间
	PickUpStartTime    string  `json:"pick_up_start_time"`   // 自提时间
	PickUpEndTime      string  `json:"pick_up_end_time"`     // 自提时间*/
	EnabledAppointment int `json:"enabled_appointment"` // 启用预约
	Day                int `json:"day"`
}

type TakeOut struct {
	Status             int     `json:"status"`
	ImmediateDelivery  int     `json:"immediate_delivery"`  // 立即配送
	EnabledAppointment int     `json:"enabled_appointment"` // 启用预约
	Day                int     `json:"day"`                 //可预约天数
	EnabledSellClear   int     `json:"enabled_sell_clear"`  // 启用自动沽清
	SellClear          string  `json:"sell_clear"`
	AutomaticOrder     int     `json:"automatic_order"`   // 自动接单
	DeliveryDistance   float64 `json:"delivery_distance"` // 配送距离
	StopBeforeMin      int     `json:"stop_before_min"`   //停止营业前停止接单
}

type Recharge struct {
	Gear           float64       `json:"gear"` // 储值金额档位
	EnabledMoney   int           `json:"enabled_money"`
	Money          float64       `json:"money"`
	EnabledPoint   int           `json:"enabled_point"`
	Point          int           `json:"point"`
	EnabledVoucher int           `json:"voucher_enabled"`
	Voucher        []voucherItem `json:"voucher"`
}

// 积分
type Score struct {
	EnabledPay     int `json:"enabled_pay"`      // 启用消费有礼
	PayScore       int `json:"pay_score"`        //消费送积分
	EnabledToScore int `json:"enabled_to_score"` // 积分抵扣开关
	ToScore        int `json:"to_score"`         // 积分抵钱
	ValidPeriod    int `json:"valid_period"`     // 有效期 （1年，永久）
}

func (model *EatIn) Show(storeId int,mid int) (*EatIn, error) {

	op := Option{}
	tx := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", "eat_in", storeId,mid).First(&op)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			return nil, errors.New("配置不存在！")
		}
		return nil, tx.Error
	}

	val := op.OptionValue
	ei := EatIn{}

	_ = json.Unmarshal([]byte(val), &ei)

	return &ei, nil

}
