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

func (rest *EatIn) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	op := model.Option{}

	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", "eat_in", rewrite.Id,mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	ei := model.EatIn{}

	json.Unmarshal([]byte(op.OptionValue), &ei)

	rest.rc.Success(c, "获取成功！", ei)

}

// 编辑
func (rest *EatIn) Edit(c *gin.Context) {

	mid, _ := c.Get("mid")

	var form struct {
		StoreId            int     `json:"store_id"`
		Status             int     `json:"status"`
		EnabledSellClear   int     `json:"enabled_sell_clear"` // 启用自动沽清
		SellClear          string  `json:"sell_clear"`
		SaleType           int     `json:"sale_type"`      // 0：餐前付款    1：餐后付款
		EatType            int     `json:"eat_type"`       // 0：堂食有桌号  1：堂食无桌号
		SurchargeType      int     `json:"surcharge_type"` // 附加费类型
		Surcharge          float64 `json:"surcharge"`      // 附加费
		CustomEnabled      int     `json:"custom_enabled"`
		CustomName         string  `json:"custom_name"`
		PayType            int     `json:"pay_type"`
		EnabledAppointment int     `json:"enabled_appointment"` // 启用预约
		Day                int     `json:"day"`                 //可预约天数
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

	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid =?", "eat_in", form.StoreId,mid).First(&op)
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

	saleType := 0
	if form.SaleType == 1 {
		saleType = 1
	}

	eatType := 0
	if form.EatType == 1 {
		eatType = 1
	}

	surchargeType := 0

	if form.SurchargeType == 1 {
		surchargeType = 1
	}

	surcharge := form.Surcharge

	customEnabled := 0
	customName := ""

	if form.CustomEnabled == 1 {
		customEnabled = 1
	}

	if form.CustomName != "" {
		customName = form.CustomName
	}

	payType := 0
	if form.PayType == 1 {
		payType = 1
	}

	enabledAppointment := 0
	day := 0
	if form.EnabledAppointment == 1 {
		enabledAppointment = 1
		if form.Day > 0 {
			day = form.Day
		}
	}

	op.Mid = mid.(int)
	op.StoreId = form.StoreId
	op.AutoLoad = 1
	op.OptionName = "eat_in"
	ei := model.EatIn{
		Status:             status,
		EnabledSellClear:   enabledSellClear,
		SellClear:          form.SellClear,
		SaleType:           saleType,
		EatType:            eatType,
		SurchargeType:      surchargeType,
		Surcharge:          surcharge,
		CustomEnabled:      customEnabled,
		CustomName:         customName,
		PayType:            payType,
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

	rest.rc.Success(c, "修改成功！", ei)
}
