/**
** @创建时间: 2021/3/12 1:50 上午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

// 活码二维码
type Qrcode struct {
	Id             int    `json:"id"`
	Code           string `gorm:"type:varchar(100);comment:二维码码值;not null" json:"code"`
	TenantId       string `gorm:"type:varchar(100);comment:绑定所属租户" json:"tenant_id"`
	Mid            int    `gorm:"type:int(11);comment:绑定平台编号" json:"mid"`
	FileName       string `gorm:"type:varchar(100);comment:文件名;not null" json:"file_name"`
	Redirect       string `gorm:"type:varchar(255);comment:跳转地址" json:"redirect"`
	AlipayRedirect string `gorm:"type:varchar(255);comment:支付宝跳转地址" json:"alipay_redirect"`
	Aqrfid         string `gorm:"type:varchar(64);comment:支付宝标识码;not null" json:"aqrfid"`
	CreateAt       int64  `gorm:"type:bigint(20);not nul" json:"create_at"`
	CreateTime     string `gorm:"-" json:"create_time"`
	UpdateAt       int64  `gorm:"type:bigint(20);not nul" json:"update_at"`
	UpdateTime     string `gorm:"-" json:"update_time"`
}

func (model *Qrcode) AutoMigrate() {
	cmf.Db().AutoMigrate(&model)
}
