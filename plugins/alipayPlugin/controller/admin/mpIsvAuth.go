/**
** @创建时间: 2021/2/21 9:03 上午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	"github.com/gincmf/alipayEasySdk/mini"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"time"
)

type MpIsvAuth struct {
	rc controller.RestController
}

type AlipayAuthResult struct {
	MpIsvAuth       *model.MpIsvAuth          `json:"mp_isv_auth"`
	MpTheme         *saasModel.MpTheme        `json:"mp_theme"`
	BusinessInfo    *resModel.BusinessInfo    `json:"business_info"`
	MpThemeVersion  *saasModel.MpThemeVersion `json:"mp_theme_version"`
	TemplateVersion *model.AlipayIsvApp       `json:"template_version"`
	AuditVersion    *saasModel.MpThemeVersion `json:"audit_version"`
	OnlineVersion   *saasModel.MpThemeVersion `json:"online_version"`
}

func (rest MpIsvAuth) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	t := c.Query("type")

	if t == "" {
		rest.rc.Error(c, "类型不能为空", nil)
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")

	result, err := rest.GetAuth(mid, rewrite.Id, t)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功", result)

}

func (rest MpIsvAuth) GetAuth(mid interface{}, tenantId int, t string) (AlipayAuthResult, error) {

	query := []string{"mp_id = ?", "tenant_id = ?", "type = ?"}
	queryArgs := []interface{}{mid, tenantId, t}

	isvAuth := model.MpIsvAuth{}

	var result AlipayAuthResult

	data, err := isvAuth.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	result.MpIsvAuth = data

	mpTheme := new(saasModel.MpTheme)

	tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").First(&mpTheme)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return result, err
	}

	if tx.RowsAffected == 0 {
		mpTheme = nil
		return result, errors.New("小程序不存在或被删除")
	}

	businessJson := saasModel.Options("business_info", mid.(int))
	bi := resModel.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)
	mpTheme.AlipayCategoryIds = bi.MiniCategoryIds
	result.MpTheme = mpTheme
	result.BusinessInfo = &bi

	upMpTheme := saasModel.MpTheme{}
	if mpTheme != nil &&
		// 如果接口加密秘钥为空
		mpTheme.EncryptKey == "" {

		bizContent := make(map[string]string, 0)
		bizContent["merchant_app_id"] = data.AuthAppId
		aesResult := new(base.Oauth).AesSet(bizContent)

		if aesResult.Code == "10000" {

			aesKey := aesResult.AesKey
			upMpTheme.EncryptKey = aesKey

		} else {
			fmt.Println("aesResult", aesResult)
		}

	}

	app, _ := new(model.AlipayIsvApp).Show()
	result.TemplateVersion = &app

	bizContent := make(map[string]interface{}, 0)
	bizContent["bundle_id"] = "com.alipay.alipaywallet"
	vResult := new(mini.Version).VersionListQuery(bizContent)

	appVersion := ""
	status := ""
	if vResult.Response.Code == "10000" {

		if len(vResult.Response.AppVersions) > 0 {
			end := len(vResult.Response.AppVersions) - 1
			if end >= 0 {
				appVersion = vResult.Response.AppVersions[end]

				bizContent := make(map[string]interface{}, 0)
				bizContent["app_version"] = appVersion
				queryResult := new(mini.Audit).DetailQuery(bizContent)

				if queryResult.Response.Code == "10000" {
					if queryResult.Response.Status == "RELEASE" {
						status = "online"
					}
				}

			}
		}

		if appVersion != "" {
			if mpTheme.AlipayExpQrCodeUrl == "" {
				bizContent := make(map[string]interface{}, 0)
				bizContent["app_version"] = appVersion
				vResult := new(mini.Version).ExperienceQuery(bizContent)

				if vResult.Response.Code == "10000" {
					upMpTheme.AlipayExpQrCodeUrl = vResult.Response.ExpQrCodeUrl
					tx := cmf.NewDb().Where("id = ?", mpTheme.Id).Updates(&upMpTheme)
					if tx.Error != nil {
						return result, err
					}
				}

			}

			version := saasModel.MpThemeVersion{}

			tx := cmf.NewDb().Where("version = ?", appVersion).First(&version)

			if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				return result, err
			}

			vData := saasModel.MpThemeVersion{
				Mid:             mid.(int),
				TemplateId:      app.TemplateAppId,
				TemplateVersion: app.Version,
				Version:         appVersion,
				Status:          status,
			}

			if tx.RowsAffected == 0 {
				vData.CreateAt = time.Now().Unix()
				tx := cmf.NewDb().Create(&vData)
				if tx.Error != nil {
					return result, err
				}
			} else {
				vData.UpdateAt = time.Now().Unix()
				tx := cmf.NewDb().Where("id  = ?", version.Id).Updates(&vData)
				if tx.Error != nil {
					return result, err
				}
			}
		}

	} else {
		fmt.Println(vResult.Response)
	}

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?"}, []interface{}{mid})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	result.MpThemeVersion = version

	// 获取审核版本
	auditVersion, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "is_audit = ?"}, []interface{}{mid, 1})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	if auditVersion != nil {
		result.AuditVersion = auditVersion
	}

	// 获取线上
	onlineVersion, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "status = ?"}, []interface{}{mid, "online"})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	if onlineVersion != nil {
		result.OnlineVersion = onlineVersion
	}

	return result, nil

}
