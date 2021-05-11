/**
** @创建时间: 2021/3/12 1:50 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
)

// 活码二维码
type Qrcode struct {
	Id           int    `json:"id"`
	Code         string `gorm:"type:varchar(100);comment:二维码码值;not null" json:"code"`
	TenantId     int    `gorm:"type:bigint(20);comment:绑定所属租户" json:"tenant_id"`
	Mid          int    `gorm:"type:int(11);comment:绑定平台编号" json:"mid"`
	AliAppId     string `gorm:"type:varchar(32);comment:阿里小程序id" json:"ali_app_id"`
	WxAppId      string `gorm:"type:varchar(32);comment:微信小程序id" json:"wx_app_id"`
	Page         string `gorm:"type:varchar(255);comment:绑定小程序页面" json:"page"`
	Query        string `gorm:"type:varchar(255);comment:绑定小程序额外参数" json:"query"`
	Aqrfid       string `gorm:"type:varchar(64);comment:支付宝标识码;not null" json:"aqrfid"`
	Hits         int    `gorm:"type:bigint(20);comment:扫码次数统计;not null;default:0" json:"hits"`
	FilePath     string `gorm:"type:varchar(100);comment:文件路径;not null" json:"file_path"`
	FilePathPrev string `gorm:"->" json:"file_path_prev"`
	CreateAt     int64  `gorm:"type:bigint(20);not nul" json:"create_at"`
	CreateTime   string `gorm:"-" json:"create_time"`
	UpdateAt     int64  `gorm:"type:bigint(20);not nul" json:"update_at"`
	UpdateTime   string `gorm:"-" json:"update_time"`
	Status       int    `gorm:"type:tinyint(3);not null;comment:活码状态（0 => 待绑定，1 => 已绑定，2 => 已停用）;default:0" json:"status"`
}

func (model *Qrcode) AutoMigrate() {
	cmf.Db().AutoMigrate(&model)
}

func (model *Qrcode) Show() {

}
