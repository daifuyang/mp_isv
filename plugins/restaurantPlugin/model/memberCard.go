/**
** @创建时间: 2020/12/13 1:55 下午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

// 用户vip表
type MemberCard struct {
	Id        int    `json:"id"`
	UserId    int    `gorm:"type:int(11);not null" json:"user_id"`
	VipNum    string `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	VipLevel  string `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	VipName   string `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	StartAt   int64    `gorm:"type:int(11);comment:起始时间;not null" json:"start_at"`
	EndAt     int64    `gorm:"type:int(11);comment:截止时间;not null" json:"end_at"`
	StartTime string `gorm:"-" json:"start_time"`
	EndTime   string `gorm:"-" json:"end_time"`
	CreateAt  int64    `gorm:"type:int(11);not null" json:"create_at"`
	UpdateAt  int64    `gorm:"type:int(11);not null" json:"update_at"`
	DeleteAt  int64    `gorm:"type:int(11);not null" json:"delete_at"`
}

func (model *MemberCard) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}
