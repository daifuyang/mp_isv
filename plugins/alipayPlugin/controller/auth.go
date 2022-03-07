/**
** @创建时间: 2020/9/5 9:38 下午
** @作者　　: return
** @描述　　: 支付宝授权相关业务
 */
package controller

import (
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	cmfModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/skip2/go-qrcode"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"strings"
	"time"
)

type Auth struct {
	rc controller.Rest
}

type responseData struct {
	AlipaySystemOauthTokenResponse *response `json:"alipay_system_oauth_token_response"`
}

type response struct {
	UserId       string `json:"user_id"`
	AccessToken  string `json:"access_token"`
	ExpiresIn    string `json:"expires_in"`
	RefreshToken string `json:"refresh_token"`
	ReExpiresIn  string `json:"re_expires_in"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 生成支付宝授权二维码
 * @Date 2020/11/23 10:03:11
 * @Param
 * @return
 **/
func (rest *Auth) OutAuthQrcode(c *gin.Context) {

	appId := "2021001192664075"
	baseUrl := "https://openauth.alipay.com/oauth2/appToAppAuth.htm"
	redirectUri := "http://www.codecloud.ltd/alipay/auth_redirect"

	mid, _ := c.Get("mid")
	if mid == nil {
		rest.rc.Error(c, "小程序不存在！", nil)
		return
	}

	tenant, err := saasModel.CurrentTenant(c)
	if err != nil {
		rest.rc.Error(c, "该租户不存在！", nil)
		return
	}

	stateMap := make(map[string]string, 0)
	stateMap["tenant_id"] = strconv.Itoa(tenant.TenantId)
	stateMap["mp_id"] = strconv.Itoa(mid.(int))
	stateMap["type"] = "alipay"
	sign, bizContent := easyUtil.Sign(stateMap)

	stateMap["biz_content"] = bizContent
	stateMap["sign"] = sign

	b, err := json.Marshal(stateMap)
	if err != nil {
		fmt.Println("err", err)
	}

	state := base64.StdEncoding.EncodeToString(b)

	p := url.Values{}
	p.Add("app_id", appId)
	p.Add("redirect_uri", redirectUri)
	p.Add("state", state)

	e := p.Encode()

	qrcodeUrl := baseUrl + "?" + e

	png, err := qrcode.Encode(qrcodeUrl, qrcode.Highest, 512)
	if err != nil {
		rest.rc.Error(c, "生成二维码出错！", nil)
	}

	w := c.Writer
	w.Header().Set("Content-Type", "image/jpg")
	w.Header().Set("Content-Disposition", `inline; filename="oauth.jpg"; filename*=utf-8''oauth.jpg`)

	w.Write(png)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 支付宝授权回调，换取用户auth_token
 * @Date 2020/11/23 10:03:47
 * @Param
 * @return
 **/
func (rest *Auth) Redirect(c *gin.Context) {

	// 获取用户授权码
	appAuthCode := c.Query("app_auth_code")

	if appAuthCode == "" {
		appAuthCode = c.Query("auth_code")
	}

	if appAuthCode == "" {
		rest.rc.Error(c, "auth_code不存在！", nil)
		return
	}

	redirect := c.Query("redirect")

	// 获取自定义额外参数
	state := c.Query("state")

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodeStr := string(decoded)

	fmt.Println("state", decodeStr)

	var stateMap struct {
		TenantId int    `json:"tenant_id"`
		Mid      int    `json:"mid"`
		Type     string `json:"type"`
	}

	json.Unmarshal(decoded, &stateMap)


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
	tx = cmf.ManualDb(db).Where("mid = ?", stateMap.Mid).First(&mp)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "小程序不存在", nil)
		return
	}

	auth := cmfModel.MpIsvAuth{}

	oauth := base.Oauth{}
	oauthResult := oauth.GetOpenToken(appAuthCode)

	response := oauthResult.Response
	codeStatus := response.Code

	if codeStatus == "10000" {

		token := response.Tokens

		v := token[0]

		userId := v.UserId
		authAppId := v.AuthAppId

		appAuthToken := v.AppAuthToken
		appRefreshToken := v.AppRefreshToken
		expiresIn := v.ExpiresIn
		reExpiresIn := v.ReExpiresIn

		tenantId := stateMap.TenantId
		mpId := stateMap.Mid
		t := stateMap.Type

		query := []string{"user_id = ?", "mp_id = ?", "type = ?"}
		queryArgs := []interface{}{userId, mpId, "alipay"}
		queryStr := strings.Join(query, " AND ")
		tx := cmf.Db().Where(queryStr, queryArgs...).Order("id desc").First(&auth)
		if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "获取失败！"+tx.Error.Error(), nil)
		}

		auth.TenantId = tenantId
		auth.MpId = mpId
		auth.Type = t
		auth.UserId = userId
		auth.AppAuthToken = appAuthToken
		auth.AppRefreshToken = appRefreshToken
		auth.ExpiresIn = expiresIn
		auth.ReExpiresIn = reExpiresIn

		if auth.Id == 0 {
			auth.AuthAppId = authAppId
			auth.CreateAt = time.Now().Unix()
			cmf.Db().Create(&auth)
		} else {

			if authAppId != auth.AuthAppId {
				rest.rc.Error(c, "重新授权的账号与当前绑定的账号不一致，如需换绑请先解绑", nil)
				return
			}

			auth.UpdateAt = time.Now().Unix()
			cmf.Db().Debug().Updates(&auth)
		}

		c.Redirect(301, redirect)
		return

	}

	fmt.Println("response", response)

	rest.rc.Error(c, "授权失败！"+response.SubMsg, response)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取支付宝小程序授权用户信息
 * @Date 2020/11/23 10:04:29
 * @Param
 * @return
 **/

func (rest *Auth) Token(c *gin.Context) {

	mid, _ := c.Get("mid")

	code := c.Query("code")
	if code == "" {
		rest.rc.Error(c, "授权码不能为空！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	data := new(base.Oauth).GetSystemToken(code)

	if data.Response.UserId == "" {
		rest.rc.Error(c, "获取失败！"+data.ErrorResponse.SubMsg, data.ErrorResponse)
		return
	}

	openId := data.Response.UserId
	query := []string{"tp.open_id = ? AND tp.mid = ?"}
	queryArgs := []interface{}{openId, mid}

	// 查询当前用户是否存在
	userPart := model.UserPart{
		Db: db,
	}
	partData, err := userPart.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 当前三方关系不存在 新建第三方用户
	if partData.OpenId == "" {
		db.Where("open_id = ?", openId).FirstOrCreate(&model.ThirdPart{
			Mid:    mid.(int),
			Type:   "alipay-mp",
			UserId: 0,
			OpenId: openId,
		})
	}

	rest.rc.Success(c, "获取成功！", data.Response)
}
