/**
** @创建时间: 2020/12/7 10:01 上午
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

type TakeOut struct {
	rc controller.Rest
}

func (rest *TakeOut) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	op := model.Option{}

	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", "takeout", rewrite.Id, mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	ei := model.TakeOut{}

	json.Unmarshal([]byte(op.OptionValue), &ei)

	rest.rc.Success(c, "获取成功！", ei)
}

func (rest *TakeOut) Edit(c *gin.Context) {

	var form struct {
		StoreId int `json:"store_id"`
		model.TakeOut
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	if form.StoreId == 0 {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	op := model.Option{}

	result := cmf.NewDb().Where("option_name = ? AND store_id = ?", "takeout", form.StoreId).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	status := 0
	if form.Status == 1 {
		status = 1
	}

	if form.FirstClass == "" {
		rest.rc.Error(c, "一级类目不能为空！", nil)
		return
	}

	if form.SecondClass == "" {
		rest.rc.Error(c, "二级类目不能为空！", nil)
		return
	}

	immediateDelivery := 0
	if form.ImmediateDelivery == 1 {
		immediateDelivery = 1
	}

	enabledSellClear := 0
	if form.EnabledSellClear == 1 {
		enabledSellClear = 1
	}

	enabledAppointment := 0
	day := 0
	if form.EnabledAppointment == 1 {
		enabledAppointment = 1
		if form.Day > 0 {
			day = form.Day
		}
	}

	automaticOrder := 0
	if form.AutomaticOrder == 1 {
		automaticOrder = 1
	}

	if form.StartKm == 0 {
		rest.rc.Error(c, "起步公里不能为空！", nil)
		return
	}

	if form.StartFee == 0 {
		rest.rc.Error(c, "起步价不能为空！", nil)
		return
	}

	op.Mid = mid.(int)
	op.StoreId = form.StoreId
	op.AutoLoad = 1
	op.OptionName = "takeout"
	ei := model.TakeOut{
		Status:             status,
		FirstClass:         form.FirstClass,
		SecondClass:        form.SecondClass,
		MinPrice:           form.MinPrice,
		ImmediateDelivery:  immediateDelivery,
		EnabledSellClear:   enabledSellClear,
		SellClear:          form.SellClear,
		EnabledAppointment: enabledAppointment,
		Day:                day,
		AutomaticOrder:     automaticOrder,
		DeliveryDistance:   form.DeliveryDistance,
		StopBeforeMin:      form.StopBeforeMin,
		StartKm:            form.StartKm,
		StartFee:           form.StartFee,
		StepKm:             form.StepKm,
		StepFee:            form.StepFee,
		DeliveryPercent:    form.DeliveryPercent,
		DeliveryTimes:      form.DeliveryTimes,
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
