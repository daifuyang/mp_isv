/**
** @创建时间: 2020/12/12 10:57 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type Level struct {
	rc controller.Rest
}

func (rest *Level) Show(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	// 配置卡券基本配置
	op := model.Option{}
	vipResult := db.Where("option_name = ? AND mid = ?", "vip_info", mid).First(&op)
	if vipResult.Error != nil && !errors.Is(vipResult.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, vipResult.Error.Error(), nil)
		return
	}

	var vipInfoMap model.VipInfo
	_ = json.Unmarshal([]byte(op.OptionValue), &vipInfoMap)

	rest.rc.Success(c, "获取成功！", vipInfoMap)

}

func (rest *Level) Edit(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	var form struct {
		EnabledRecharge int            `json:"enabled_recharge"` // 启用充值送
		RechargePoint   int            `json:"recharge_point"`
		EnabledConsume  int            `json:"enabled_consume"` // 启用消费送
		ConsumePoint    int            `json:"consume_point"`
		ExpValidPeriod  int            `json:"exp_valid_period"`
		Level           []model.SLevel `json:"level"`
	}

	err = c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	enabledRecharge := 0
	if form.EnabledRecharge == 1 {
		enabledRecharge = 1
	}

	enabledConsume := 0
	if form.EnabledConsume == 1 {
		enabledConsume = 1
	}

	// 充值加经验值
	rechargePoint := 1
	if form.RechargePoint > 0 {
		rechargePoint = form.RechargePoint
	}

	// 消费加经验值
	consumePoint := 1
	if form.ConsumePoint > 0 {
		consumePoint = form.ConsumePoint
	}

	// 有效期
	expValidPeriod := -1
	if form.ExpValidPeriod == 0 {
		rest.rc.Error(c, "有效期非法！", nil)
		return
	}

	expValidPeriod = form.ExpValidPeriod

	// 会员等级
	ExpRangeStart := 0
	for k, v := range form.Level {
		if v.ExpRangeStart != ExpRangeStart {
			rest.rc.Error(c, v.LevelName+"经验值非法", nil)
		}
		form.Level[k].LevelId = "VIP" + strconv.Itoa(k+1)
		ExpRangeStart = v.ExpRangeEnd
	}

	// 配置卡券基本配置
	op := model.Option{}
	vipResult := db.Where("option_name = ? AND mid = ?", "vip_info", mid).First(&op)
	if vipResult.Error != nil && !errors.Is(vipResult.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, vipResult.Error.Error(), nil)
		return
	}

	var vipInfoMap model.VipInfo

	vipInfoMap.EnabledRecharge = enabledRecharge
	vipInfoMap.RechargePoint = rechargePoint
	vipInfoMap.EnabledConsume = enabledConsume
	vipInfoMap.ConsumePoint = consumePoint
	vipInfoMap.ExpValidPeriod = expValidPeriod
	vipInfoMap.Level = form.Level

	vipInfoJson, _ := json.Marshal(&vipInfoMap)

	op.Mid = mid.(int)
	op.AutoLoad = 1
	op.OptionName = "vip_info"
	op.OptionValue = string(vipInfoJson)

	if vipResult.RowsAffected == 0 {
		db.Create(&op)
	} else {
		db.Save(&op)
	}

	rest.rc.Success(c, "编辑成功！", vipInfoMap)

}
