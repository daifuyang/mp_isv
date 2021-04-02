/**
** @创建时间: 2021/3/31 5:13 下午
** @作者　　: return
** @描述　　: 支付宝云客服
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
)

type ContactButton struct {
	TntInstId string `json:"tnt_inst_id"`
	Scene string `json:"scene"`
	Size int `json:"size"`
	Color string `json:"color"`
	Icon string `json:"icon"`
	IconPrev string `json:"icon_prev"`
}

func (model *ContactButton) Show(mid int) (ContactButton,error) {

	op := resModel.Option{}

	cb := ContactButton{}

	tx := cmf.NewDb().Where("option_name = ? AND mid = ?", "alipay_contact", mid).First(&op)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cb, tx.Error
	}

	val := op.OptionValue


	_ = json.Unmarshal([]byte(val), &cb)

	cb.IconPrev = util.GetFileUrl(cb.Icon)

	return cb, nil

}

func (model *ContactButton) Edit(mid int) (ContactButton, error) {

	op := resModel.Option{}

	cb := ContactButton{}

	result := cmf.NewDb().Where("option_name = ? AND mid = ?", "alipay_contact", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cb, result.Error
	}

	op.Mid = mid
	op.AutoLoad = 1
	op.OptionName = "alipay_contact"

	val, err := json.Marshal(model)
	if err != nil {
		cmfLog.Error(err.Error())
		return cb, err
	}

	op.OptionValue = string(val)

	var tx *gorm.DB
	if op.Id == 0 {
		tx = cmf.NewDb().Create(&op)
	} else {
		tx = cmf.NewDb().Save(&op)
	}

	if tx.Error != nil {
		return cb, tx.Error
	}

	return *model, nil

}
