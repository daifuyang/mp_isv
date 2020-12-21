/**
** @创建时间: 2020/12/18 3:03 下午
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
	"gorm.io/gorm"
)

type Recharge struct {
	rc controller.RestController
}

// @Summary 充值规则设置
// @Description 查看充值规则设置
// @Tags restaurant 充值规则
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Recharge} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/settings/recharge [get]
func (rest *Recharge) Show(c *gin.Context) {
	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ?", "recharge").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}
	var recharge []model.Recharge
	json.Unmarshal([]byte(op.OptionValue),&recharge)
	rest.rc.Success(c,"获取成功！",recharge)

}

// @Summary 充值规则设置
// @Description 查看充值规则设置
// @Tags restaurant 充值规则
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Recharge} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/settings/recharge [post]
func (rest *Recharge) Edit(c *gin.Context) {

	var form []model.Recharge
	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	jsonStr,err := json.Marshal(form)
	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	op := model.Option{}
	op.AutoLoad = 1
	op.OptionName = "recharge"
	result := cmf.NewDb().Where("option_name = ?", "recharge").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	op.OptionValue = string(jsonStr)
	if result.RowsAffected == 0 {
		cmf.NewDb().Create(&op)
	}else{
		cmf.NewDb().Save(&op)
	}

	rest.rc.Success(c,"修改成功！",form)

}
