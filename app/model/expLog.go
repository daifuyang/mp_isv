/**
** @创建时间: 2021/1/2 9:56 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"time"
)

type ExpLog struct {
	Id         int    `json:"id"`
	UserId     int    `gorm:"type:int(11);comment:所属用户id;not null" json:"user_id"`
	Exp        int    `gorm:"type:int(11);comment:增加积分;not null" json:"exp"`
	Fee        string `gorm:"type:varchar(11);comment:合计金额;default:0;not null" json:"fee"`
	Remark     string `gorm:"type:varchar(255);comment:备注" json:"remark"`
	CreateAt   int64  `gorm:"type:int(11);not nul" json:"create_at"`
	CreateTime string `gorm:"-" json:"create_time"`
}

// 订单日志
func (model *ExpLog) Save() error {

	if model.CreateAt == 0 {
		model.CreateAt = time.Now().Unix()
	}

	if tx := cmf.NewDb().Create(&model); tx.Error != nil {
		return tx.Error
	}

	return nil

}

func (model *ExpLog) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}
