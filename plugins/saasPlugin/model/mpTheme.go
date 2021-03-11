/**
** @创建时间: 2020/10/4 1:57 下午
** @作者　　: return
** @描述　　: 租户创建的主题类型
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	"strings"
	"time"
)

type MpTheme struct {
	Id                 int     `json:"id"`
	Mid                int     `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	Category           int     `gorm:"type:tinyint(3);comment:小程序类型分类;not null;default:0" json:"category"`
	Name               string  `gorm:"type:varchar(20);comment:小程序主题名称;not null" json:"name"`
	Thumbnail          string  `gorm:"type:varchar(255);comment:小程序缩略图;not null" json:"thumbnail"`
	ThemeId            int     `gorm:"type:int(11);comment:小程序原主题id;not null" json:"theme_id"`
	TenantId           int     `gorm:"type:int(11);comment:小程序所属租户id;not null" json:"-"`
	AppLogo            string  `gorm:"type:varchar(255);comment:小程序应用logo图标;not null" json:"app_logo"`
	AppLogoPrev        string  `gorm:"-" json:"app_logo_prev"`
	AppDesc            string  `gorm:"type:varchar(200);comment:小程序应用描述，20-200个字;not null" json:"app_desc"`
	AlipayCategoryIds  string  `gorm:"-" json:"alipay_category_ids"`
	AlipayExpQrCodeUrl string  `gorm:"type:varchar(255);comment:支付宝小程序体验版二维码;not null" json:"alipay_exp_qr_code_url"`
	EncryptKey         string  `gorm:"type:varchar(40);comment:小程序接口加密内容;not null" json:"encrypt_key"`
	CreateAt           int64   `gorm:"type:bigint(20);comment:创建时间;default:0" json:"create_at"`
	UpdateAt           int64   `gorm:"type:bigint(20);comment:更新时间;default:0" json:"update_at"`
	CreateTime         string  `gorm:"-" json:"create_time"`
	UpdateTime         string  `gorm:"-" json:"update_time"`
	ListOrder          float64 `gorm:"type:float;comment:排序;default:10000" json:"list_order"`
	DeleteAt           int64   `gorm:"type:bigint(20);comment:删除时间;default:0" json:"delete_at"`
}

type MpThemeVersion struct {
	Id              int    `json:"id"`
	Mid             int    `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	Version         string `gorm:"type:varchar(10);comment:小程序版本;not null" json:"version"`
	TemplateId      string `gorm:"type:varchar(32);comment:小程序构建模板id;not null" json:"template_id"`
	TemplateVersion string `gorm:"type:varchar(64);comment:小程序构建模板版本;not null" json:"template_version"`
	IsAudit         int    `gorm:"type:tinyint(3);comment:小程序版本审核状态;not null" json:"is_audit"`
	Status          string `gorm:"type:varchar(10);default:wait;comment:小程序版本状态(gray:灰度，wait:待审核,reject:已拒绝,audit:已审核，online:已上线，offline：下架);not null;" json:"status"`
	RejectReason    string `gorm:"type:varchar(512);" json:"reject_reason"`
	Type            string `gorm:"type:varchar(20);comment:授权商户小程序类型;not null" json:"type"`
	CreateAt        int64  `gorm:"type:bigint(20);comment:创建时间;default:0" json:"create_at"`
	CreateTime      string `gorm:"-" json:"create_time"`
	UpdateAt        int64  `gorm:"type:bigint(20);comment:更新时间;default:0" json:"update_at"`
	UpdateTime      string `gorm:"-" json:"update_time"`
}

type MpThemePage struct {
	Id          int    `json:"id"`
	ThemeId     int    `gorm:"type:int(11)" json:"theme_id"`
	Mid         int    `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	Home        int    `gorm:"type:tinyint(3);comment:是否为首页;not null;default:0" json:"home"`
	Title       string `gorm:"type:varchar(20);comment:页面名称;not null" json:"title"`
	File        string `gorm:"type:varchar(20);comment:页面路径;not null" json:"file"`
	Style       string `gorm:"type:text;comment:主题文件用户公共样式" json:"style"`
	ConfigStyle string `gorm:"type:text;comment:主题文件默认公共样式" json:"global_style"`
	More        string `gorm:"type:text;comment:主题文件用户配置文件" json:"more"`
	ConfigMore  string `gorm:"type:text;comment:主题文件默认配置文件" json:"config_more"`
	CreateAt    int64  `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt    int64  `gorm:"type:bigint(20)" json:"update_at"`
}

func (model *MpThemeVersion) Show(query []string, queryArgs []interface{}) (*MpThemeVersion, error) {

	queryStr := ""
	if len(query) > 0 {
		queryStr = strings.Join(query, " AND ")
	}

	version := new(MpThemeVersion)

	tx := cmf.NewDb().Where(queryStr, queryArgs...).Order("id desc").First(&version)

	if tx.Error != nil {
		return nil, tx.Error
	}

	if tx.RowsAffected > 0 {
		version.CreateTime = time.Unix(version.CreateAt, 0).Format(data.TimeLayout)
		version.UpdateTime = time.Unix(version.UpdateAt, 0).Format(data.TimeLayout)
	} else {
		version = nil
	}

	return version, nil

}
