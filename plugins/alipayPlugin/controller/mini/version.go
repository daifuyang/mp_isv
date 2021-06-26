/**
** @创建时间: 2021/2/21 1:36 下午
** @作者　　: return
** @描述　　:
 */
package mini

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/data"
	"github.com/gincmf/alipayEasySdk/merchant"
	"github.com/gincmf/alipayEasySdk/mini"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type Version struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看小程序详情
 * @Date 2021/2/21 20:26:8
 * @Param
 * @return
 **/
func (rest *Version) Detail(c *gin.Context) {

	mid, _ := c.Get("mid")
	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "alipay"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["app_version"] = version.Version

	result := new(mini.Audit).DetailQuery(bizContent)

	fmt.Println(result)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 上传小程序版本
 * @Date 2021/2/21 13:37:47
 * @Param
 * @return
 **/
func (rest *Version) Upload(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt := mid.(int)

	var count int64
	cmf.NewDb().Where("mid = ? and is_audit = ? AND type = ?", mid, 1, "alipay").First(&saasModel.MpThemeVersion{}).Count(&count)
	if count > 0 {
		rest.rc.Error(c, "请等待待审核的小程序完成审核状态在升级!", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["bundle_id"] = "com.alipay.alipaywallet"
	vResult := new(mini.Version).VersionListQuery(bizContent)

	appVersions := "0.0.0"
	if vResult.Response.Code == "10000" {
		if len(vResult.Response.AppVersions) > 0 {
			appVersions = vResult.Response.AppVersions[0]
		}
	}

	bizContent = make(map[string]interface{}, 0)
	bizContent["app_version"] = appVersions
	new(mini.Audit).AuditedCancel(bizContent)

	app, _ := new(appModel.AlipayIsvApp).Show()

	// 存入日志
	versionModel := saasModel.MpThemeVersion{
		Mid:             midInt,
		Version:         appVersions,
		TemplateId:      app.TemplateAppId,
		TemplateVersion: app.Version,
		IsAudit:         0,
		Type:            "alipay",
		CreateAt:        time.Now().Unix(),
	}

	appVersion := rest.NextVersion(&versionModel)
	versionModel.Version = appVersion

	result, appVersion := rest.UploadVersion(versionModel)

	if result.Response.Code == "10000" {

		// 设为体验版本
		bizContent := make(map[string]interface{}, 0)
		bizContent["app_version"] = appVersion

		result := new(mini.Version).ExperienceCreate(bizContent)
		if result.Response.Code == "10000" {
			rest.rc.Success(c, "发起成功", nil)
		} else {
			rest.rc.Error(c, result.Response.SubMsg, result.Response)
		}

	} else {
		rest.rc.Error(c, "发起失败："+result.Response.SubMsg, result.Response)
	}

}

// 递归发起
func (rest *Version) UploadVersion(version saasModel.MpThemeVersion) (mini.VersionUploadResult, string) {

	appVersion := version.Version
	bizContent := make(map[string]interface{}, 0)
	bizContent["template_id"] = version.TemplateId
	bizContent["template_version"] = version.TemplateVersion
	bizContent["app_version"] = appVersion

	version.Version = appVersion
	version.Id = 0

	fmt.Println("bizContent", bizContent)

	result := new(mini.Version).Upload(bizContent)
	if result.Response.Code != "10000" {
		if result.Response.SubCode == "LARGER_VERSION_HAS_EXISTED" || result.Response.SubCode == "VERSION_HAS_EXISTED" {

			appVersion = rest.NextVersion(&version)
			version.Version = appVersion
			version.Id = 0
			version.CreateAt = time.Now().Unix()
			cmf.NewDb().Create(&version)
			// 递归
			return rest.UploadVersion(version)
		}
	} else {
		cmf.NewDb().Create(&version)
	}

	return result, appVersion
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取下一版本号
 * @Date 2021/2/21 18:2:10
 * @Param
 * @return
 **/

func (rest *Version) NextVersion(version *saasModel.MpThemeVersion) string {

	if version == nil {
		version = &saasModel.MpThemeVersion{
			Version: "0.0.0",
		}
	}

	versionArr := strings.Split(version.Version, ".")

	if len(versionArr) > 0 {

		last, _ := strconv.Atoi(versionArr[2])

		if last > 20 {

			middle, _ := strconv.Atoi(versionArr[1])
			middle++
			versionArr[1] = strconv.Itoa(middle)
			versionArr[2] = "1"

		} else {

			last++
			versionArr[2] = strconv.Itoa(last)

		}

	}

	appVersion := strings.Join(versionArr, ".")

	return appVersion

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 设置体验版本
 * @Date 2021/2/22 10:35:47
 * @Param
 * @return
 **/

func (rest *Version) ExperienceCreate(c *gin.Context) {

	// 获取当前版本
	mid, _ := c.Get("mid")
	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "alipay"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	appVersion := version.Version

	if version.Id == 0 {
		rest.rc.Error(c, "请先构建小程序", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["app_version"] = appVersion
	result := new(mini.Version).ExperienceCreate(bizContent)

	if result.Response.Code == "10000" {
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}

// 查询体验版状态
func (rest *Version) ExperienceQuery(c *gin.Context) {

	// 获取当前版本
	mid, _ := c.Get("mid")
	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "alipay"})
	if err != nil {

		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "请先构建小程序", nil)
			return
		}

		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 如果是正式版
	if version.Status == "online" {

		bizContent := make(map[string]interface{}, 0)
		bizContent["describe"] = "扫码点单"
		bizContent["url_param"] = "pages/index/index"
		bizContent["query_param"] = "x=1"

		result := new(merchant.Qrcode).Create(bizContent)
		if result.Response.Code != "10000" {
			rest.rc.Error(c, "获取失败！"+result.Response.SubMsg, result)
			return
		}

		rest.rc.Success(c, "获取成功！", gin.H{
			"exp_qr_code_url": result.Response.QrCodeUrl,
		})
		return
	}

	appVersion := version.Version

	bizContent := make(map[string]interface{}, 0)
	bizContent["app_version"] = appVersion
	result := new(mini.Version).ExperienceQuery(bizContent)

	if result.Response.Code == "10000" {
		if result.Response.ExpQrCodeUrl == "" {
			response, err := rest.experienceCreate(appVersion)
			if err != nil {
				rest.rc.Error(c, err.Error(), response)
				return
			}
			rest.ExperienceQuery(c)
		}
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}

func (rest *Version) experienceCreate(appVersion string) (data.AlipayResponse, error) {
	bizContent := make(map[string]interface{}, 0)
	bizContent["app_version"] = appVersion
	result := new(mini.Version).ExperienceCreate(bizContent)

	if result.Response.Code != "10000" {
		return result.Response, errors.New(result.Response.SubMsg)
	}

	return data.AlipayResponse{}, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询当前小程序状态
 * @Date 2021/3/3 0:55:33
 * @Param
 * @return
 **/
func (rest *Version) DetailQuery(c *gin.Context) {

	mid, _ := c.Get("mid")

	mpTheme := new(saasModel.MpTheme)
	tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").First(&mpTheme)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		mpTheme = nil
		rest.rc.Error(c, "小程序不存在或被删除", nil)
		return
	}

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "alipay"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	appVersion := version.Version

	if version.Id == 0 {
		rest.rc.Error(c, "请先构建小程序", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["app_version"] = appVersion
	result := new(mini.Audit).DetailQuery(bizContent)

	if result.Response.Code != "10000" {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
		return
	}

	// 更新状态为已拒绝
	if result.Response.Status == "AUDIT_REJECT" {
		version.Status = "reject"
		version.RejectReason = result.Response.RejectReason
		version.IsAudit = 0

		bizContent := make(map[string]interface{}, 0)
		bizContent["app_version"] = appVersion
		result := new(mini.Audit).AuditedCancel(bizContent)

		if result.Response.Code != "10000" {
			rest.rc.Error(c, result.Response.SubMsg, result.Response)
			return
		}

		tx = cmf.NewDb().Save(&version)
		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	rest.rc.Success(c, result.Response.Msg, result.Response)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 发起审核
 * @Date 2021/3/2 20:10:44
 * @Param
 * @return
 **/

func (rest *Version) Audit(c *gin.Context) {

	mid, _ := c.Get("mid")

	mpTheme := new(saasModel.MpTheme)
	tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").First(&mpTheme)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		mpTheme = nil
		rest.rc.Error(c, "小程序不存在或被删除", nil)
		return
	}

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "alipay"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	appVersion := version.Version

	if version.Id == 0 {
		rest.rc.Error(c, "请先构建小程序", nil)
		return
	}

	businessJson := saasModel.Options("business_info", mid.(int))
	bi := model.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)

	if bi.Mobile == "" {
		rest.rc.Error(c, "请先填写系统设置联系人手机号", nil)
		return
	}

	if bi.Email == "" {
		rest.rc.Error(c, "请先填写系统设置客服邮箱", nil)
		return
	}

	if bi.AppSlogan == "" {
		rest.rc.Error(c, "请先填写系统设置小程序简介", nil)
		return
	}

	if bi.AppDesc == "" {
		rest.rc.Error(c, "请先填写系统设置小程序描述", nil)
		return
	}

	/*if bi.BusinessLicense == "" {
		rest.rc.Error(c, "请先填写营业执照号", nil)
		return
	}

	if bi.BusinessPhoto == "" {
		rest.rc.Error(c, "请先上传营业执照", nil)
		return
	}*/

	if bi.OutDoorPic == "" {
		rest.rc.Error(c, "请先上传门头照片", nil)
		return
	}

	/*if bi.FoodLicensePic == "" {
		rest.rc.Error(c, "请先上传食品经营许可证", nil)
		return
	}*/

	if version.Status == "reject" {
		cancelBizContent := make(map[string]interface{}, 0)
		cancelBizContent["app_version"] = version.Version
		result := new(mini.Audit).AuditedCancel(cancelBizContent)

		if result.Response.Code != "10000" {
			rest.rc.Error(c, result.Response.SubMsg, result.Response)
			return
		}
	}

	bizContent := make(map[string]string, 0)
	bizContent["app_version"] = appVersion
	bizContent["mini_category_ids"] = bi.MiniCategoryIds
	bizContent["service_phone"] = bi.Mobile
	bizContent["service_email"] = bi.Email
	bizContent["app_slogan"] = bi.AppSlogan
	bizContent["app_desc"] = bi.AppDesc
	bizContent["region_type"] = "CHINA"
	bizContent["version_desc"] = "提供堂食、外卖、储值、会员服务的小程序，快速打造数字化生活"
	bizContent["license_name"] = "营业执照"
	bizContent["license_no"] = bi.BusinessLicense
	files := make(map[string]string, 0)

	if mpTheme.AppLogo == "" {
		rest.rc.Error(c, "logo图标不能为空！", nil)
		return
	}

	files["app_logo"] = util.GetAbsPath(mpTheme.AppLogo)

	files["out_door_pic"] = util.GetAbsPath(bi.OutDoorPic)
	if bi.BusinessPhoto != "" {
		files["first_license_pic"] = util.GetAbsPath(bi.BusinessPhoto)
	}

	if bi.FoodLicensePic != "" {
		files["first_special_license_pic"] = util.GetAbsPath(bi.FoodLicensePic)
	}

	result, _ := new(mini.Audit).Apply(bizContent, files)

	if result.Response.Code != "10000" {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
		return
	}

	// 更新状态为审核中

	version.IsAudit = 1
	version.Status = "wait"
	tx = cmf.NewDb().Save(&version)

	if tx.Error != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, result.Response.Msg, result.Response)

}
