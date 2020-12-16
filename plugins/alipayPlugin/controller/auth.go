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
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/base"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/skip2/go-qrcode"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"strings"
)

type Auth struct {
	rc controller.RestController
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
	if mid == nil{
		rest.rc.Error(c,"小程序不存在！",nil)
	}

	tenant := util.CurrentTenant(c)

	stateMap := make(map[string]string,0)
	stateMap["tenant_id"] = strconv.Itoa(tenant.TenantId)
	stateMap["mp_id"] = strconv.Itoa(mid.(int))
	stateMap["type"] = "alipay"
	sign ,bizContent := easyUtil.Sign(stateMap)

	stateMap["biz_content"] = bizContent
	stateMap["sign"] = sign


	b,err :=  json.Marshal(stateMap)
	if err != nil {
		fmt.Println("err",err)
	}

	state := base64.StdEncoding.EncodeToString(b)

	p := url.Values{}
	p.Add("app_id",appId)
	p.Add("redirect_uri",redirectUri)
	p.Add("state",state)

	e := p.Encode()

	qrcodeUrl := baseUrl + "?" + e

	png, err := qrcode.Encode(qrcodeUrl, qrcode.Highest,512)
	if err != nil {
		rest.rc.Error(c,"生成二维码出错！",nil)
	}

	w := c.Writer
	w.Header().Set("Content-Type", "image/jpg")
	w.Header().Set("Content-Disposition",`inline; filename="oauth.jpg"; filename*=utf-8''oauth.jpg`)

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

	// 获取三方应用的appId
	appId := c.Query("app_id")
	// 获取用户授权码
	appAuthCode := c.Query("app_auth_code")
	fmt.Println("app_id",appId)
	fmt.Println("app_auth_code",appAuthCode)

	// 获取自定义额外参数
	state := c.Query("state")

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodeStr := string(decoded)

	fmt.Println("state",decodeStr)

	inParams := make(map[string]string,0)
	json.Unmarshal(decoded,&inParams)

	sign := inParams["sign"]

	bizContent := inParams["biz_content"]
	fmt.Println("biz_content", bizContent)

	// 验证签名
	err := easyUtil.VerifySign(bizContent,sign)

	if err != nil {
		rest.rc.Error(c,"验证签名出错！不合法的参数！",nil)
		return
	}

	oauth := base.Oauth{}
	data := oauth.GetOpenToken(appAuthCode)

	var result map[string]interface{}
	_ = json.Unmarshal(data, &result)

	temp := result["alipay_open_auth_token_app_response"]
	response := temp.(map[string]interface{})

	codeStatus := response["code"].(string)

	if codeStatus == "10000" {

		token := response["tokens"]

		tokenMap := token.([]interface{})

		for _, v := range tokenMap {

			temp := v.(map[string]interface{})
			userId := temp["user_id"].(string)
			authAppId := temp["auth_app_id"].(string)
			appAuthToken := temp["app_auth_token"].(string)
			appRefreshToken := temp["app_refresh_token"].(string)
			expiresIn := temp["expires_in"].(float64)
			expiresInStr := strconv.FormatFloat(expiresIn, 'f', -1, 64)

			reExpiresIn := temp["re_expires_in"].(float64)
			reExpiresInStr := strconv.FormatFloat(reExpiresIn, 'f', -1, 64)

			tenantId,_ := strconv.Atoi(inParams["tenant_id"])
			mpId,_ := strconv.Atoi(inParams["mp_id"])
			t := inParams["type"]

			auth := model.MpIsvAuth{
				TenantId:tenantId,
				MpId: mpId,
				Type: t,
			}

			query := []string{"user_id","auth_app_id"}
			queryArgs := []interface{}{userId,authAppId}
			queryStr := strings.Join(query,"AND ")
			result := cmf.NewDb().Where(queryStr,queryArgs...).First(&auth)

			auth.UserId = userId
			auth.AuthAppId = authAppId
			auth.AppAuthToken = appAuthToken
			auth.AppRefreshToken = appRefreshToken
			auth.ExpiresIn = expiresInStr
			auth.ReExpiresIn = reExpiresInStr

			if result.RowsAffected == 0 {
				cmf.Db().Create(&auth)
			}else{
				cmf.Db().Save(&auth)
			}

			rest.rc.Success(c, "授权成功！", auth)
			return
		}
	}

	rest.rc.Error(c, "授权失败！", result)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取支付宝小程序授权用户信息
 * @Date 2020/11/23 10:04:29
 * @Param
 * @return
 **/

func (rest *Auth) Token (c *gin.Context) {

	appId,_ := c.Get("app_id")

	isvAuth :=	model.MpIsvAuth{}
	rowResult := cmf.Db().Where("auth_app_id = ?",appId).First(&isvAuth)
	if rowResult.RowsAffected == 0 {
		rest.rc.Error(c,"小程序不存在，请联系管理员！",nil)
		return
	}

	code := c.Query("code")
	if code == "" {
		rest.rc.Error(c,"授权码不能为空！",nil)
		return
	}

	alipayEasySdk.SetOption("AppAuthToken",isvAuth.AppAuthToken)

	base := base.Oauth{}
	data := base.GetSystemToken(code)
	var result *responseData
	json.Unmarshal(data, &result)

	if result.AlipaySystemOauthTokenResponse == nil {
		var errResult map[string]interface{}
		json.Unmarshal(data, &errResult)
		rest.rc.Error(c,"获取失败！",errResult)
		return
	}

	response := result.AlipaySystemOauthTokenResponse
	openId := response.UserId

	query := []string{"open_id = ?"}
	queryArgs :=[]interface{}{openId}

	// 查询当前用户是否存在
	userPart := model.UserPart{}
	partData, err := userPart.Show(query,queryArgs)
	if err != nil && !errors.Is(err,gorm.ErrRecordNotFound){
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	// 当前三方关系不存在 新建第三方用户
	if partData  == nil {
		cmf.NewDb().Create(&model.ThirdPart{
			Type: "alipay-mp",
			UserId: 0,
			OpenId:openId,
		})
	}

	rest.rc.Success(c,"获取成功！",result)
}