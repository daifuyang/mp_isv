/**
** @创建时间: 2021/4/20 6:59 下午
** @作者　　: return
** @描述　　:
 */
package open

import (
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	cmfModel "gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"strings"
	"time"
)

type Auth struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 预授权码（pre_auth_code）是第三方平台方实现授权托管的必备信息，每个预授权码有效期为 1800秒。需要先获取令牌才能调用。使用过程中如遇到问题，可在开放平台服务商专区发帖交流。
 * @Date 2021/4/20 22:9:46
 * @Param
 * @return
 **/
func (rest *Auth) PreAuthCode(c *gin.Context) {

	// 租户授权绑定单个小程序

	mid, _ := c.Get("mid")
	if mid == nil {
		rest.rc.Error(c, "小程序不存在！", nil)
		return
	}

	redirect := c.Query("redirect")

	if redirect == "" {
		redirect = cmf.Conf().App.Domain
	}

	tenant, err := saasModel.CurrentTenant(c)
	if err != nil {
		rest.rc.Error(c, "该租户不存在！", nil)
		return
	}

	tenantId := strconv.Itoa(tenant.TenantId)

	stateMap := make(map[string]interface{}, 0)
	stateMap["tenant_id"] = tenantId
	stateMap["mid"] = mid
	stateMap["type"] = "wechat"
	b, err := json.Marshal(stateMap)
	if err != nil {
		fmt.Println("err", err)
	}
	state := base64.StdEncoding.EncodeToString(b)

	p := url.Values{}
	p.Add("state", state)
	p.Add("redirect", redirect)

	e := p.Encode()

	accessToken, exist := c.Get("accessToken")

	if !exist {
		rest.rc.Error(c,"accessToken以失效",nil)
		return
	}

	options := wechatEasySdk.OpenOptions()

	redirectUrl := url.QueryEscape(options.RedirectUrl + "?" + e)

	bizContent := map[string]interface{}{
		"component_access_token": accessToken,
		"component_appid":        options.AppId,
	}

	preAuthCode, err := cmf.NewRedisDb().Get("preAuthCode").Result()

	if err != nil {
		preResult := new(open.Component).PreAuthCode(accessToken.(string), bizContent)

		if preResult.Errcode > 0 {
			cmf.NewRedisDb().Del("accessToken")
			rest.rc.Error(c, "获取失败！"+preResult.Errmsg, preResult)
			return
		}

		preAuthCode = preResult.PreAuthCode

		if preAuthCode != "" {
			cmf.NewRedisDb().Set("preAuthCode", preAuthCode, time.Second*1700)
		} else {
			cmf.NewRedisDb().Del("accessToken")
			rest.rc.Error(c, "获取失败！", nil)
			return
		}

	}

	url := "https://mp.weixin.qq.com/cgi-bin/componentloginpage?component_appid=" + options.AppId + "&pre_auth_code=" + preAuthCode + "&auth_type=2&redirect_uri=" + redirectUrl

	rest.rc.Success(c, "获取成功！", url)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 授权公众号小程序权限
 * @Date 2021/4/21 10:27:16
 * @Param
 * @return
 **/
func (rest *Auth) Redirect(c *gin.Context) {

	// 获取回调授权authorizationCode
	authCode := c.Query("auth_code")
	if authCode == "" {
		rest.rc.Error(c, "授权失败！", nil)
		return
	}

	redirect := c.Query("redirect")

	// 获取自定义额外参数
	state := c.Query("state")

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodeStr := string(decoded)

	fmt.Println("state", decodeStr)

	var stateMap struct {
		TenantId string `json:"tenant_id"`
		Mid      int    `json:"mid"`
		Type     string `json:"type"`
	}
	err := json.Unmarshal(decoded, &stateMap)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	tenant := saasModel.Tenant{}
	tx := cmf.Db().Where("tenant_id = ?", stateMap.TenantId).First(&tenant)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "租户不存在或已删除", nil)
		return
	}

	db := "tenant_" + strconv.Itoa(tenant.TenantId)
	mp := saasModel.MpTheme{}
	tx = cmf.TempDb(db).Where("mid = ?", stateMap.Mid).First(&mp)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "小程序不存在", nil)
		return
	}

	// 获取accessToken
	accessToken, exist := c.Get("accessToken")

	if !exist {
		rest.rc.Error(c, "accessToken不存在！", nil)
		return
	}

	options := wechatEasySdk.OpenOptions()

	bizContent := map[string]interface{}{
		"component_appid":    options.AppId,
		"authorization_code": authCode,
	}

	authResult := new(open.Component).QueryAuth(accessToken.(string), bizContent)

	if authResult.Errcode > 0 {
		cmf.NewRedisDb().Del("accessToken")
		rest.rc.Error(c, "获取失败！"+authResult.Errmsg, authResult)
		return
	}

	auth := cmfModel.MpIsvAuth{}

	authAppId := authResult.AuthorizationInfo.AuthorizerAppid

	query := []string{"auth_app_id = ?"}
	queryArgs := []interface{}{authAppId}
	queryStr := strings.Join(query, " AND ")
	tx = cmf.Db().Debug().Where(queryStr, queryArgs...).Order("id desc").First(&auth)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, "获取失败！"+tx.Error.Error(), nil)
	}

	auth.TenantId = tenant.TenantId
	auth.MpId = stateMap.Mid
	auth.Type = stateMap.Type
	auth.AuthAppId = authResult.AuthorizationInfo.AuthorizerAppid
	auth.AppAuthToken = authResult.AuthorizationInfo.AuthorizerAccessToken
	auth.AppRefreshToken = authResult.AuthorizationInfo.AuthorizerRefreshToken
	auth.ExpiresIn = strconv.Itoa(authResult.AuthorizationInfo.ExpiresIn)

	if auth.Id == 0 {
		auth.CreateAt = time.Now().Unix()
		cmf.Db().Create(&auth)
	} else {
		if authAppId != auth.AuthAppId {
			rest.rc.Error(c, "重新授权的账号与当前绑定的账号不一致", nil)
			return
		}
		auth.UpdateAt = time.Now().Unix()
		cmf.Db().Updates(&auth)
	}

	bizContent = map[string]interface{}{
		"action": "add",
		"requestdomain": []string{
			"https://console.mashangdian.cn",
		},
		"wsrequestdomain": []string{
			"https://console.mashangdian.cn",
		},
		"uploaddomain": []string{
			"https://console.mashangdian.cn",
		},
		"downloaddomain": []string{
			"https://console.mashangdian.cn",
		},
	}

	new(open.Wxa).ModifyDomain(accessToken.(string), bizContent)

	bizContent = map[string]interface{}{
		"action": "add",
		"webviewdomain": []string{
			"https://console.mashangdian.cn",
		},
	}

	new(open.Wxa).SetWebViewDomain(accessToken.(string), bizContent)

	c.Redirect(301, redirect)
	return

}
