package model

import (
	"encoding/json"
	"errors"
	cmf "github.com/gincmf/cmf/bootstrap"
	wechatEasySdkOpen "github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
)

type Option struct {
	Id          int    `json:"id"`
	AutoLoad    int    `gorm:"type:tinyint(3);default:1;not null" json:"autoload"`
	OptionName  string `gorm:"type:varchar(64);not null" json:"option_name"`
	OptionValue string `gorm:"type:json" json:"option_value"`
}

//定义site_info类型
type SiteInfo struct {
	SiteName           string `json:"site_name"`
	AdminPassword      string `json:"admin_password"`
	SiteSeoTitle       string `json:"site_seo_title"`
	SiteSeoKeywords    string `json:"site_seo_keywords"`
	SiteSeoDescription string `json:"site_seo_description"`
	SiteIcp            string `json:"site_icp"`
	SiteGwa            string `json:"site_gwa"`
	SiteAdminEmail     string `json:"site_admin_email"`
	SiteAnalytics      string `json:"site_analytics"`
	OpenRegistration   string `json:"open_registration"`
}

//定义upload_setting类型
type UploadSetting struct {
	MaxFiles  int `json:"max_files"`
	ChunkSize int `json:"chunk_size"`
	FileTypes `json:"file_types"`
}

type FileTypes struct {
	Image TypeValues `json:"image"`
	Video TypeValues `json:"video"`
	Audio TypeValues `json:"audio"`
	File  TypeValues `json:"file"`
}

type TypeValues struct {
	UploadMaxFileSize int    `json:"upload_max_file_size"`
	Extensions        string `json:"extensions"`
}

// 支付宝小程序最新模板
type AlipayIsvApp struct {
	AppId         string `json:"app_id"`
	TemplateAppId string `json:"template_app_id"`
	Version       string `json:"version"`
}

// 微信小程序最新模板
type WechatIsvApp struct {
	SourceMiniprogramAppid string `json:"source_miniprogram_appid"`
	TemplateId             int    `json:"template_id"`
	UserVersion            string `json:"user_version"`
}

func (app AlipayIsvApp) Show() (AlipayIsvApp, error) {

	isvApp := AlipayIsvApp{}
	op := Option{}
	result := cmf.Db().Where("option_name = ?", "alipay_isv_app").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return isvApp, result.Error
	}

	json.Unmarshal([]byte(op.OptionValue), &isvApp)

	return isvApp, nil

}

func (app WechatIsvApp) Show() (WechatIsvApp, error) {

	isvApp := WechatIsvApp{}
	op := Option{}
	result := cmf.Db().Where("option_name = ?", "wechat_isv_app").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return isvApp, result.Error
	}

	json.Unmarshal([]byte(op.OptionValue), &isvApp)

	return isvApp, nil

}

func (app AlipayIsvApp) Edit() (AlipayIsvApp, error) {

	isvApp := AlipayIsvApp{}
	op := Option{}
	result := cmf.Db().Where("option_name = ?", "alipay_isv_app").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return isvApp, result.Error
	}

	json.Unmarshal([]byte(op.OptionValue), &isvApp)

	isvApp.AppId = "2021001192664075"
	isvApp.TemplateAppId = "2021001192675085"
	isvApp.Version = app.Version

	v, _ := json.Marshal(&isvApp)

	op.OptionValue = string(v)

	var tx *gorm.DB
	if op.Id == 0 {
		op.OptionName = "alipay_isv_app"
		tx = cmf.Db().Debug().Create(&op)
	} else {
		tx = cmf.Db().Debug().Updates(&op)
	}
	if tx.Error != nil {
		return isvApp, tx.Error
	}

	return isvApp, nil

}

func (app WechatIsvApp) Edit(ak string) (WechatIsvApp, error) {

	isvApp := WechatIsvApp{}
	op := Option{}
	result := cmf.Db().Where("option_name = ?", "wechat_isv_app").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return isvApp, result.Error
	}

	json.Unmarshal([]byte(op.OptionValue), &isvApp)

	componentAccessToken := ak
	listResult := new(wechatEasySdkOpen.Wxa).GetTemplateList(componentAccessToken)

	if listResult.Errcode != 0 {
		return isvApp, errors.New(listResult.Errmsg)
	}

	isvApp.SourceMiniprogramAppid =  listResult.TemplateList[0].SourceMiniprogramAppid
	isvApp.TemplateId = listResult.TemplateList[0].TemplateId
	isvApp.UserVersion = listResult.TemplateList[0].UserVersion

	v, _ := json.Marshal(&isvApp)

	op.OptionValue = string(v)

	var tx *gorm.DB
	if op.Id == 0 {
		op.OptionName = "wechat_isv_app"
		tx = cmf.Db().Create(&op)
	} else {
		tx = cmf.Db().Updates(&op)
	}
	if tx.Error != nil {
		return isvApp, tx.Error
	}

	return isvApp, nil

}

// 测试appId
type TestAppId struct {
	Name  string `json:"name"`
	AppId string `json:"template_app_id"`
}

func (app TestAppId) List() (appId []TestAppId) {
	appId = []TestAppId{
		{
			Name:  "码上点模板",
			AppId: "", //2021001192675085
		},
	}
	return
}

func (app TestAppId) InList(appId string) (result bool) {

	ids := app.List()
	for _, v := range ids {
		if v.AppId == appId {
			result = true
			return
		}
	}
	result = false
	return
}
