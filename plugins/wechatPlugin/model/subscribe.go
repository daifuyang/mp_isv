/**
** @创建时间: 2021/5/27 5:43 下午
** @作者　　: return
** @描述　　: 微信订阅模板设置
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/model"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
)

type Option struct {
	model.Option
	Mid     int `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId int `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
}

type PriTmpl struct {
	PayTmpId      string `json:"pay_tmp_id"`
	RefundTmpId   string `json:"refund_tmp_id"`
	FinishedTmpId string `json:"finished_tmp_id"`
	TakeTmpId     string `json:"take_tmp_id"`
}

type Subscribe struct {
	Mid int      `json:"mid"`
	Db  *gorm.DB `gorm:"-" json:"-"`
}

func (model *Subscribe) Show(mid int) (priTmpl PriTmpl, err error) {

	db := model.Db
	op := Option{}
	result := db.Where("option_name = ? AND mid = ?", "subscribe", mid).First(&op)
	if result.Error != nil {
		return priTmpl, result.Error
	}

	err = json.Unmarshal([]byte(op.OptionValue), &priTmpl)

	if err != nil {
		return priTmpl, err
	}

	return priTmpl, nil

}

func (model *Subscribe) Edit(ak string, mid int) (priTmpl PriTmpl, err error) {

	db := model.Db
	op := Option{}
	op.Mid = mid
	op.AutoLoad = 1
	op.OptionName = "subscribe"
	result := db.Where("option_name = ? AND mid = ?", "subscribe", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return priTmpl, result.Error
	}

	if result.RowsAffected == 0 {

		// 增加下单成功模板
		successResponse := new(open.Wxa).AddTemplate(ak, map[string]interface{}{
			"tid":       "264",
			"kidList":   []string{"45", "37", "12", "4", "26"},
			"sceneDesc": "点餐下单成功通知",
		})

		if successResponse.Errcode == 0 {
			priTmpl.PayTmpId = successResponse.PriTmplId
		} else {
			return priTmpl, errors.New(successResponse.Errmsg)
		}

		// 增加退款成功模板
		refundResponse := new(open.Wxa).AddTemplate(ak, map[string]interface{}{
			"tid":       "3335",
			"kidList":   []string{"3", "5", "7", "9"},
			"sceneDesc": "点餐退款成功通知",
		})

		if refundResponse.Errcode == 0 {
			priTmpl.RefundTmpId = refundResponse.PriTmplId
		} else {
			return priTmpl, errors.New(refundResponse.Errmsg)
		}

		// 增加订单完成通知模板
		finishedResponse := new(open.Wxa).AddTemplate(ak, map[string]interface{}{
			"tid":       "677",
			"kidList":   []string{"13", "2", "7", "12", "5"},
			"sceneDesc": "点餐完成通知",
		})

		if finishedResponse.Errcode == 0 {
			priTmpl.FinishedTmpId = finishedResponse.PriTmplId
		} else {
			return priTmpl, errors.New(finishedResponse.Errmsg)
		}

		// 订单取餐提醒模板
		takeResponse := new(open.Wxa).AddTemplate(ak, map[string]interface{}{
			"tid":       "250",
			"kidList":   []string{"22", "23", "7", "12"},
			"sceneDesc": "取餐提醒通知",
		})

		if takeResponse.Errcode == 0 {
			priTmpl.TakeTmpId = takeResponse.PriTmplId
		} else {
			return priTmpl, errors.New(finishedResponse.Errmsg)
		}

		jsonStr, err := json.Marshal(priTmpl)
		if err != nil {
			return priTmpl, err
		}
		op.OptionValue = string(jsonStr)

		db.Create(&op)
	} else {
		json.Unmarshal([]byte(op.OptionValue), &priTmpl)
	}

	return priTmpl, nil

}
