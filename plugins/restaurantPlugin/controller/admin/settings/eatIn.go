/**
** @创建时间: 2020/12/7 10:00 上午
** @作者　　: return
** @描述　　:
 */
package settings

import (
	"encoding/json"
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
)

type EatIn struct {
	rc controller.RestController
}

// 编辑
func (rest *EatIn) Edit(c *gin.Context) {

	var form struct {
		StoreId            int     `json:"store_id"`
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
		Day                int     `json:"day"`                  //可预约天数
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if form.StoreId == 0 {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	op := model.Option{
		StoreId: form.StoreId,
	}
	result := cmf.NewDb().Where("option_name = ? AND store_id = ?", "eat_in", form.StoreId).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	status := 0
	if form.Status == 1 {
		status = 1
	}

	enabledSellClear := 0
	if form.EnabledSellClear == 1 {
		enabledSellClear = 1
	}

	eatType := 0
	if form.EatType == 1 {
		eatType = 1
	}

	surchargeType := 0
	if form.SurchargeType == 1 {
		surchargeType = 1
	}

	customEnabled := 0
	customName := ""

	if form.CustomEnabled == 1 {
		customEnabled = 1

		if form.CustomName == "" {
			rest.rc.Error(c, "自定义名称不能为空！", nil)
			return
		}
		customName = form.CustomName
	}

	payType := 0
	if form.PayType == 1 {
		payType = 1
	}

	businessStartHours := "00:00"
	if form.BusinessStartHours != "" {
		businessStartHours = form.BusinessStartHours
	}

	businessEndHours := "00:00"
	if form.BusinessEndHours != "" {
		businessEndHours = form.BusinessEndHours
	}

	pickStartTime := "00:00"
	if form.PickUpStartTime != "" {
		pickStartTime = form.PickUpStartTime
	}

	pickEndTime := "00:00"
	if form.PickUpEndTime != "" {
		pickEndTime = form.PickUpEndTime
	}

	enabledAppointment := 0
	day := 0
	if form.EnabledAppointment == 1 {
		enabledAppointment = 1
		if form.Day > 0 {
			day = form.Day
		}
	}

	op.AutoLoad = 1
	op.OptionName = "eat_in"
	ei := model.EatIn{
		Status:             status,
		EnabledSellClear:   enabledSellClear,
		EatType:            eatType,
		SurchargeType:      surchargeType,
		CustomEnabled:      customEnabled,
		CustomName:         customName,
		PayType:            payType,
		BusinessStartHours: businessStartHours,
		BusinessEndHours:   businessEndHours,
		PickUpStartTime:    pickStartTime,
		PickUpEndTime:      pickEndTime,
		EnabledAppointment: enabledAppointment,
		Day:                day,
	}
	val, err := json.Marshal(ei)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	op.OptionValue = string(val)
	if op.Id == 0 {
		cmf.NewDb().Create(&op)
	} else {
		cmf.NewDb().Save(&op)
	}

	rest.rc.Success(c, "修改成功！", nil)
}
