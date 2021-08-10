/**
** @创建时间: 2021/4/22 11:48 下午
** @作者　　: return
** @描述　　: 小程序面板授权
 */
package admin

import (
	"encoding/json"
	"errors"
	"gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type MpIsvAuth struct {
	rc controller.Rest
}

type WechatAuthResult struct {
	MpIsvAuth       *model.MpIsvAuth          `json:"mp_isv_auth"`
	MpTheme         *saasModel.MpTheme        `json:"mp_theme"`
	BusinessInfo    *resModel.BusinessInfo    `json:"business_info"`
	MpThemeVersion  *saasModel.MpThemeVersion `json:"mp_theme_version"`
	CanUpdate       int                       `json:"can_update"`
	TemplateVersion *model.AlipayIsvApp       `json:"template_version"`
	AuditVersion    *saasModel.MpThemeVersion `json:"audit_version"`
	OnlineVersion   *saasModel.MpThemeVersion `json:"online_version"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 小程序授权
 * @Date 2021/4/22 23:50:31
 * @Param
 * @return
 **/
func (rest *MpIsvAuth) Show(c *gin.Context) {

	/*
		1.获取小程序的授权信息
		2.验证用户信息
	*/

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")

	accessToken, exist := c.Get("authorizerAccessToken")
	if !exist {
		rest.rc.Error(c, "authorizerAccessToken 授权失败！", nil)
		return
	}

	result, err := rest.GetAuth(c, mid, rewrite.Id, accessToken.(string))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功", result)

}

func (rest MpIsvAuth) GetAuth(c *gin.Context, mid interface{}, tenantId int, accessToken string) (result WechatAuthResult, err error) {

	query := []string{"mp_id = ?", "tenant_id = ?", "type = ?"}
	queryArgs := []interface{}{mid, tenantId, "wechat"}

	isvAuth := model.MpIsvAuth{}

	data, err := isvAuth.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	data.AppAuthToken = ""
	data.AppRefreshToken = ""

	result.MpIsvAuth = data

	app, _ := new(model.WechatIsvApp).Show()

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mpTheme := new(saasModel.MpTheme)

	/*绑定小程序信息*/
	tx := db.Where("mid = ?", mid).Order("id desc").First(&mpTheme)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return result, err
	}

	if tx.RowsAffected == 0 {
		mpTheme = nil
		return result, errors.New("小程序不存在或被删除")
	}

	mpTheme.WechatExpQrCodeUrl = util.GetFileUrl(mpTheme.WechatExpQrCodeUrl)

	businessJson, err := saasModel.Options(db, "business_info", mid.(int))
	bi := resModel.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)
	mpTheme.AlipayCategoryIds = bi.MiniCategoryIds
	result.MpTheme = mpTheme

	result.BusinessInfo = &bi

	/* 获取模板版本信息 */
	mpThemeVersion := saasModel.MpThemeVersion{
		Db: db,
	}
	version, err := mpThemeVersion.Show([]string{"mid = ? AND type = ?"}, []interface{}{mid, "wechat"})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	if version != nil && version.Status == "wait" && version.IsAudit == 1 {
		releaseResponse := new(open.Wxa).Release(accessToken)
		if releaseResponse.Errcode == 0 || releaseResponse.Errcode == 85052 {
			version.IsAudit = 0
			version.Status = "online"
			version.UpdateAt = time.Now().Unix()
			db.Save(&version)
		}
	}

	result.MpThemeVersion = version

	// 获取审核版本
	auditVersion, err := mpThemeVersion.Show([]string{"mid = ?", "type = ?", "is_audit = ?"}, []interface{}{mid, "wechat", 1})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	if auditVersion != nil {
		result.AuditVersion = auditVersion
	}

	// 获取线上
	onlineVersion, err := mpThemeVersion.Show([]string{"mid = ?", "type = ?", "status = ?"}, []interface{}{mid, "wechat", "online"})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return result, err
	}

	if onlineVersion != nil {
		result.OnlineVersion = onlineVersion
	}

	// 判断是否可升级，当前用户的模板未在审核且当前模板版本不等于线上小程序版本
	if version != nil && version.IsAudit == 0 && strconv.Itoa(app.TemplateId) != version.TemplateId {
		result.CanUpdate = 1
	}

	return result, nil

}
