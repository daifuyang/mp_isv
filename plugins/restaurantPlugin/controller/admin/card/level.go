/**
** @创建时间: 2020/12/12 10:57 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"encoding/json"
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type Level struct {
	rc controller.RestController
}

func (rest *Level) Edit(c *gin.Context) {

	var form struct {
		RechargePoint  int            `json:"recharge_point"`
		ConsumePoint   int            `json:"consume_point"`
		ExpValidPeriod int            `json:"exp_valid_period"`
		Level          []model.SLevel `json:"level"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
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
	vipResult := cmf.NewDb().Where("option_name = ?", "vip_info").First(&op)
	if vipResult.Error != nil && !errors.Is(vipResult.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, vipResult.Error.Error(), nil)
		return
	}

	var vipInfoMap model.VipInfo

	vipInfoMap.RechargePoint = rechargePoint
	vipInfoMap.ConsumePoint = consumePoint
	vipInfoMap.ExpValidPeriod = expValidPeriod
	vipInfoMap.Level = form.Level

	vipInfoJson, _ := json.Marshal(&vipInfoMap)

	op.AutoLoad = 1
	op.OptionName = "vip_info"
	op.OptionValue = string(vipInfoJson)

	if vipResult.RowsAffected == 0 {
		cmf.NewDb().Create(&op)
	} else {
		cmf.NewDb().Save(&op)
	}

	rest.rc.Success(c, "编辑成功！", vipInfoMap)

}
