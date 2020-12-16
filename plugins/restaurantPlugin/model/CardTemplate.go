/**
** @创建时间: 2020/12/12 2:12 下午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

type CardTemplate struct {
	Id                 int    `json:"id"`
	CardName           string `gorm:"type:varchar(20);comment:会员卡名称;not null" json:"card_name"`
	CardShowName       string `gorm:"type:varchar(10);comment:钱包端显示名称;not null" json:"card_show_name"`
	CardBackground     string `gorm:"type:varchar(255);comment:卡片背景图片;not null" json:"card_background"`
	AlipayBackgroundId string `gorm:"type:varchar(1000);comment:背景图片Id;not null" json:"alipay_background_id"`
	ValidPeriod        int    `gorm:"type:int(11);comment:有效期;not null" json:"valid_period"`
	BenefitInfo        string `gorm:"type:json;comment:权益说明" json:"benefit_info"`
	CreateAt           int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt           int64  `gorm:"type:int(11)" json:"update_at"`
	DeleteAt           int64  `gorm:"type:int(10);comment:'删除时间';default:0" json:"delete_at"`
	CreateTime         string `gorm:"-" json:"create_time"`
	UpdateTime         string `gorm:"-" json:"update_time"`
	TemplateId         string `gorm:"type:varchar(32);comment:模板ID;" json:"template_id"`
	SyncToAlipay       int    `gorm:"type:tinyint(2);default:0;comment:同步到支付宝卡包;not null" json:"sync_to_alipay"`
	Status             int    `gorm:"type:tinyint(2);default:1;comment:状态;not null" json:"status"`
}

func (model *CardTemplate) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}
