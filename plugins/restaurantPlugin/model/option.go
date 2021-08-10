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
	"gincmf/app/util"
	"github.com/gincmf/alipayEasySdk/base"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
)

type Option struct {
	model.Option
	Mid     int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId int      `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	Db      *gorm.DB `gorm:"-" json:"-"`
}

func (model *Option) AutoMigrate() {
	_ = model.Db.AutoMigrate(&model)
}

type EatIn struct {
	Status           int     `json:"status"`
	EnabledSellClear int     `json:"enabled_sell_clear"` // 启用自动沽清
	SellClear        string  `json:"sell_clear"`
	SaleType         int     `json:"sale_type"`
	EatType          int     `json:"eat_type"`       //堂食模式
	OrderType        int     `json:"order_type"`     // 点餐模式
	SurchargeType    int     `json:"surcharge_type"` // 附件费类型
	Surcharge        float64 `json:"surcharge"`      // 附件费
	CustomEnabled    int     `json:"custom_enabled"`
	CustomName       string  `json:"custom_name"`
	PayType          int     `json:"pay_type"`
	/*BusinessStartHours string  `json:"business_start_hours"` // 起售时间
	BusinessEndHours   string  `json:"business_end_hours"`   // 截止时间
	PickUpStartTime    string  `json:"pick_up_start_time"`   // 自提时间
	PickUpEndTime      string  `json:"pick_up_end_time"`     // 自提时间*/
	EnabledAppointment int      `json:"enabled_appointment"` // 启用预约
	Day                int      `json:"day"`
	Db                 *gorm.DB `gorm:"-" json:"-"`
}

type deliveryTimes struct {
	StartTime string `json:"start_time"`
	EndTime   string `json:"end_time"`
}

type TakeOut struct {
	Status             int             `json:"status"`
	FirstClass         string          `json:"first_class"`
	SecondClass        string          `json:"second_class"`
	MinPrice           float64         `json:"min_price"`           // 起送价格
	ImmediateDelivery  int             `json:"immediate_delivery"`  // 立即配送
	EnabledAppointment int             `json:"enabled_appointment"` // 启用预约
	Day                int             `json:"day"`                 //可预约天数
	EnabledSellClear   int             `json:"enabled_sell_clear"`  // 启用自动沽清
	SellClear          string          `json:"sell_clear"`
	AutomaticOrder     int             `json:"automatic_order"`   // 自动接单
	DeliveryDistance   float64         `json:"delivery_distance"` // 配送距离
	StopBeforeMin      int             `json:"stop_before_min"`   //停止营业前停止接单
	StartKm            float64         `json:"start_km"`          // 起步km
	StartFee           float64         `json:"start_fee"`         // 起步价格
	StepKm             float64         `json:"step_km"`           // 阶梯距离
	StepFee            float64         `json:"step_fee"`          // 阶梯价格
	DeliveryPercent    float64         `json:"delivery_percent"`  // 最大承受运费比例
	DeliveryTimes      []deliveryTimes `json:"delivery_times"`    // 自动配送时间段
	Db                 *gorm.DB        `gorm:"-" json:"-"`
}

type Recharge struct {
	Gear           float64       `json:"gear"` // 储值金额档位
	EnabledMoney   int           `json:"enabled_money"`
	Money          float64       `json:"money"`
	EnabledScore   int           `json:"enabled_score"`
	Score          int           `json:"score"`
	EnabledVoucher int           `json:"enabled_voucher"`
	Voucher        []VoucherItem `json:"voucher"`
}

// 积分
type Score struct {
	EnabledPay     int `json:"enabled_pay"`      // 启用消费有礼
	PayScore       int `json:"pay_score"`        //消费送积分
	EnabledToScore int `json:"enabled_to_score"` // 积分抵扣开关
	ToScore        int `json:"to_score"`         // 积分抵钱
	ValidPeriod    int `json:"valid_period"`     // 有效期 （1年，永久）
}

func (model *EatIn) Show(storeId int, mid int) (EatIn, error) {

	db := model.Db

	op := Option{}
	tx := db.Where("option_name = ? AND store_id = ? AND mid = ?", "eatin", storeId, mid).First(&op)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			return EatIn{}, errors.New("配置不存在！")
		}
		return EatIn{}, tx.Error
	}

	val := op.OptionValue
	ei := EatIn{}

	_ = json.Unmarshal([]byte(val), &ei)

	if ei.OrderType == 1 {
		ei.EatType = 0
	}

	return ei, nil

}

func (model *TakeOut) Show(storeId int, mid int) (TakeOut, error) {

	db := model.Db

	op := Option{}
	tx := db.Where("option_name = ? AND store_id = ? AND mid = ?", "takeout", storeId, mid).First(&op)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			return TakeOut{}, errors.New("配置不存在！")
		}
		return TakeOut{}, tx.Error
	}

	val := op.OptionValue
	to := TakeOut{}

	_ = json.Unmarshal([]byte(val), &to)

	return to, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2021/3/2 23:53:49
 * @Param
 * @return
 **/

type BusinessInfo struct {
	BrandName       string `json:"brand_name"`
	BrandLogo       string `json:"brand_logo"`
	AlipayLogoId    string `json:"alipay_logo_id"`
	Company         string `json:"company"`
	Address         string `json:"address"`
	Contact         string `json:"contact"`
	Mobile          string `json:"mobile"`
	Email           string `json:"email"`
	BusinessLicense string `json:"business_license"`
	BusinessScope   string `json:"business_scope"`
	BusinessExpired string `json:"business_expired"`
	BusinessPhoto   string `json:"business_photo"`
	MiniCategoryIds string `json:"mini_category_ids"`
	AppSlogan       string `json:"app_slogan"`
	AppDesc         string `json:"app_desc"`
	OutDoorPic      string `json:"out_door_pic"`
	FoodLicensePic  string `json:"food_license_pic"`
}

func (model *BusinessInfo) AlipayImageId(brandLogo string) (string, error) {

	absPath := util.CurrentPath() + "/public/uploads/" + brandLogo
	b, err := util.ExistPath(absPath)
	if err != nil {

		return "", err
	}

	if !b {
		return "", errors.New("品牌LOGO地址错误！")
	}

	imageId := ""

	bizContent := make(map[string]string, 0)
	bizContent["image_type"] = "jpg"
	bizContent["image_name"] = "brand_logo"
	imgResult, err := new(base.Image).Upload(bizContent, absPath)

	if imgResult.Response.Code != "10000" {

		return "", errors.New("上传失败！" + imgResult.Response.SubMsg)
	}

	imageId = imgResult.Response.ImageId

	if err != nil {
		return "", err
	}

	return imageId, nil

}

func (model *Option) Updates(businessInfo BusinessInfo) (Option, error) {

	op := Option{}

	db := model.Db

	result := db.Where("option_name = ? AND mid = ?", "business_info", model.Mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return op, result.Error
	}

	op.Mid = model.Mid
	op.AutoLoad = 1
	op.OptionName = "business_info"

	val, err := json.Marshal(businessInfo)
	if err != nil {
		cmfLog.Error(err.Error())
		return op, err
	}

	op.OptionValue = string(val)

	var tx *gorm.DB
	if op.Id == 0 {
		tx = db.Create(&op)
	} else {
		tx = db.Save(&op)
	}

	if tx.Error != nil {
		return op, tx.Error
	}

	return op, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 微信扫码领券
 * @Date 2021/7/3 15:43:10
 * @Param
 * @return
 **/
// 微信扫码领券
type Scan struct {
	AppId string   `json:"app_id"`
	Path  string   `json:"path"`
	Db    *gorm.DB `gorm:"-" json:"-"`
}

func (model *Scan) Show(mid int) (Scan, error) {

	op := Option{}

	scan := Scan{}

	db := model.Db

	tx := db.Where("option_name = ? AND mid = ?", "wechat_cfav", mid).First(&op)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return scan, tx.Error
	}

	val := op.OptionValue

	_ = json.Unmarshal([]byte(val), &scan)

	return scan, nil

}

func (model *Scan) Edit(mid int) (Scan, error) {

	db := model.Db

	op := Option{}

	scan := Scan{}

	result := db.Where("option_name = ? AND mid = ?", "wechat_cfav", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return scan, result.Error
	}

	op.Mid = mid
	op.AutoLoad = 1
	op.OptionName = "wechat_cfav"

	val, err := json.Marshal(model)
	if err != nil {
		cmfLog.Error(err.Error())
		return scan, err
	}

	op.OptionValue = string(val)

	var tx *gorm.DB
	if op.Id == 0 {
		tx = db.Create(&op)
	} else {
		tx = db.Save(&op)
	}

	if tx.Error != nil {
		return scan, tx.Error
	}

	return *model, nil

}

// 微信社群配置
type Group struct {
	PlugId string   `json:"plugid"`
	Db     *gorm.DB `gorm:"-" json:"-"`
}

func (model *Group) Show(mid int) (Group, error) {

	op := Option{}

	group := Group{}

	db := model.Db

	tx := db.Where("option_name = ? AND mid = ?", "wechat_work_group", mid).First(&op)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return group, tx.Error
	}

	val := op.OptionValue

	_ = json.Unmarshal([]byte(val), &group)

	return group, nil

}

func (model *Group) Edit(mid int) (Group, error) {

	op := Option{}

	group := Group{}

	db := model.Db

	result := db.Where("option_name = ? AND mid = ?", "wechat_work_group", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return group, result.Error
	}

	op.Mid = mid
	op.AutoLoad = 1
	op.OptionName = "wechat_work_group"

	val, err := json.Marshal(model)
	if err != nil {
		cmfLog.Error(err.Error())
		return group, err
	}

	op.OptionValue = string(val)

	var tx *gorm.DB
	if op.Id == 0 {
		tx = db.Create(&op)
	} else {
		tx = db.Save(&op)
	}

	if tx.Error != nil {
		return group, tx.Error
	}

	return *model, nil

}
