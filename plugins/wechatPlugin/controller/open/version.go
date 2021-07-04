/**
** @创建时间: 2021/5/5 10:09 上午
** @作者　　: return
** @描述　　:
 */
package open

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"gincmf/plugins/wechatPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
	"io"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
	"time"
)

type Version struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看小程序的详情
 * @Date 2021/5/5 17:53:22
 * @Param
 * @return
 **/
func (rest *Version) Detail(c *gin.Context) {

	mid, _ := c.Get("mid")

	accessToken, exist := c.Get("authorizerAccessToken")

	if !exist {
		rest.rc.Error(c, "请联系管理员，授权token不存在！", nil)
		return
	}

	data := new(open.Base).BaseInfo(accessToken.(string))

	if data.Errcode != 0 {
		rest.rc.Error(c, data.Errmsg, nil)
		return
	}

	var result struct {
		open.Base
		QrCodeUrl string `json:"qr_code_url"`
	}

	mpTheme := new(saasModel.MpTheme)
	tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").First(&mpTheme)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该主题不存在", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	result.Base = data
	result.QrCodeUrl = util.GetFileUrl(mpTheme.WechatQrCodeUrl)

	rest.rc.Success(c, "获取成功！", result)

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
	midStr := strconv.Itoa(midInt)

	accessToken, exist := c.Get("authorizerAccessToken")

	if !exist {
		rest.rc.Error(c, "请联系管理员，授权token不存在！", nil)
		return
	}

	var count int64
	cmf.NewDb().Where("mid = ? and is_audit = ? AND type = ?", mid, 1, "wechat").First(&saasModel.MpThemeVersion{}).Count(&count)
	if count > 0 {
		rest.rc.Error(c, "请等待待审核的小程序完成审核状态在升级!", nil)
		return
	}

	appVersions := "0.0.0"

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ? and type = ?"}, []interface{}{mid, "wechat"})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if version != nil && version.Id > 0 {
		appVersions = version.Version
	}

	// 首次构建
	if appVersions == "0.0.0" {

		bizContent := map[string]interface{}{
			"action": "add",
			"requestdomain": []string{
				"https://console.mashangdian.cn",
			},
			"wsrequestdomain": []string{
				"wss://console.mashangdian.cn",
			},
			"uploaddomain": []string{
				"https://console.mashangdian.cn",
			},
			"downloaddomain": []string{
				"https://console.mashangdian.cn",
			},
		}
		data := new(open.Wxa).ModifyDomain(accessToken.(string), bizContent)

		if data.Errcode > 0 {
			rest.rc.Error(c, data.Errmsg, data)
			return
		}

		bizContent = map[string]interface{}{
			"action": "add",
			"webviewdomain": []string{
				"https://console.mashangdian.cn",
			},
		}

		webData := new(open.Wxa).SetWebViewDomain(accessToken.(string), bizContent)

		if webData.Errcode > 0 {
			rest.rc.Error(c, webData.Errmsg, webData)
			return
		}

		// 进行模板生成和绑定
		_, err := new(model.Subscribe).Edit(accessToken.(string), midInt)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
		}

	}

	// 取消在审核的小程序

	// 获取当前最新模板id
	app, _ := new(appModel.WechatIsvApp).Show()

	// 存入日志
	versionModel := saasModel.MpThemeVersion{
		Mid:             midInt,
		Version:         appVersions,
		TemplateId:      strconv.Itoa(app.TemplateId),
		TemplateVersion: app.UserVersion,
		IsAudit:         0,
		Type:            "wechat",
		CreateAt:        time.Now().Unix(),
	}

	appVersion := rest.NextVersion(&versionModel)
	versionModel.Version = appVersion

	// 开始构建
	bizContent := map[string]interface{}{
		"template_id":  app.TemplateId,
		"ext_json":     "{}",
		"user_version": appVersion,
		"user_desc":    "码上云餐厅数字化转型模板",
	}

	commitResult := new(open.Wxa).Commit(accessToken.(string), bizContent)

	if commitResult.Errcode != 0 {
		rest.rc.Error(c, commitResult.Errmsg, nil)
		return
	}

	theme := saasModel.MpTheme{}
	tx := cmf.NewDb().Where("mid = ?", mid).First(&theme)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 设为体验版
	response, jpg := new(open.Wxa).GetQrcode(accessToken.(string), "")
	if response.Errcode == 0 {
		// 创建一个文件用于保存
		path := "tenant/" + midStr + "/wechat-exp.jpg"

		_, err = os.Stat("public/uploads/tenant/" + midStr)

		if err != nil {
			err = os.MkdirAll("public/uploads/tenant/"+midStr, os.ModePerm)
			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
		}

		out, err := os.Create("public/uploads/" + path)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		defer out.Close()

		// 然后将响应流和文件流对接起来
		_, err = io.Copy(out, ioutil.NopCloser(bytes.NewReader(jpg)))
		if err != nil {
			panic(err)
		}

		theme := saasModel.MpTheme{}
		tx := cmf.NewDb().Where("mid = ?", mid).First(&theme)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		theme.WechatExpQrCodeUrl = path
		tx = cmf.NewDb().Where("mid = ?", mid).Updates(&theme)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

	} else {
		fmt.Println(response.Errmsg)
	}

	tx = cmf.NewDb().Where("template_version = ? AND  type = ?", versionModel.TemplateVersion, "wechat").First(&versionModel)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if theme.WechatQrCodeUrl == "" {
		// 设置正式版
		response, jpg := new(open.Wxa).GetWxaCode(accessToken.(string))
		if response.Errcode == 0 {
			// 创建一个文件用于保存
			path := "tenant/" + midStr + "/wechat-qrcode.jpg"

			_, err = os.Stat("uploads/tenant/" + midStr)
			if err != nil {
				os.MkdirAll("uploads/tenant/"+midStr, os.ModePerm)
			}

			out, err := os.Create("public/uploads/" + path)
			if err != nil {
				panic(err)
			}
			defer out.Close()

			// 然后将响应流和文件流对接起来
			_, err = io.Copy(out, ioutil.NopCloser(bytes.NewReader(jpg)))
			if err != nil {
				panic(err)
			}

			theme := saasModel.MpTheme{}
			tx := cmf.NewDb().Where("mid = ?", mid).First(&theme)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			theme.WechatQrCodeUrl = path
			tx = cmf.NewDb().Where("mid = ?", mid).Updates(&theme)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

		} else {
			fmt.Println(response.Errmsg)
		}
	}

	if tx.RowsAffected == 0 {
		cmf.NewDb().Where("template_version = ? AND  type = ?", versionModel.TemplateVersion, "wechat").Create(&versionModel)
	} else {
		cmf.NewDb().Where("template_version = ? AND  type = ?", versionModel.TemplateVersion, "wechat").Updates(&versionModel)

	}

	rest.rc.Success(c, "构建成功！", nil)
	return

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
 * @Description 审核小程序
 * @Date 2021/5/6 21:36:56
 * @Param
 * @return
 **/
func (rest *Version) Audit(c *gin.Context) {

	mid, _ := c.Get("mid")

	accessToken, exist := c.Get("authorizerAccessToken")

	if !exist {
		rest.rc.Error(c, "请联系管理员，授权token不存在！", nil)
		return
	}

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

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "wechat"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if version.Id == 0 {
		rest.rc.Error(c, "请先构建小程序", nil)
		return
	}

	businessJson := saasModel.Options("business_info", mid.(int))

	bi := resModel.BusinessInfo{}

	json.Unmarshal([]byte(businessJson), &bi)

	if bi.BrandName == "" || bi.BrandLogo == "" || bi.Mobile == "" {
		rest.rc.Error(c, "请先完善基本信息！", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["version_desc"] = bi.AppDesc
	auditResponse := new(open.Wxa).SubmitAudit(accessToken.(string), bizContent)

	if auditResponse.Errcode != 0 {
		rest.rc.Error(c, auditResponse.Response.Errmsg, auditResponse.Response)
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

	rest.rc.Success(c, "更新成功！", auditResponse.Response)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询最新一次审核状态
 * @Date 2021/5/6 21:53:26
 * @Param
 * @return
 **/

func (rest *Version) LatestAuditStatus(c *gin.Context) {

	mid, _ := c.Get("mid")

	accessToken, exist := c.Get("authorizerAccessToken")

	if !exist {
		rest.rc.Error(c, "请联系管理员，授权token不存在！", nil)
		return
	}

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

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "wechat"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if version.Id == 0 {
		rest.rc.Error(c, "请先构建小程序", nil)
		return
	}

	auditResponse := new(open.Wxa).GetLatestAuditStatus(accessToken.(string))

	if auditResponse.Errcode != 0 {
		rest.rc.Error(c, auditResponse.Errmsg, nil)
		return
	}

	// 已拒绝
	if auditResponse.Status == 1 {
		version.Status = "reject"
		version.RejectReason = auditResponse.Reason
		version.IsAudit = 0
	}

	if auditResponse.Status == 0 {
		releaseResponse := new(open.Wxa).Release(accessToken.(string))
		if releaseResponse.Errcode == 0 || releaseResponse.Errcode == 85052 {
			version.IsAudit = 0
			version.Status = "online"
		}
	}

	version.UpdateAt = time.Now().Unix()
	tx = cmf.NewDb().Save(&version)

	if tx.Error != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", auditResponse)

}
