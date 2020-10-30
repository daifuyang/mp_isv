/**
** @创建时间: 2020/9/5 9:38 下午
** @作者　　: return
** @描述　　: 支付宝授权相关业务
 */
package controller

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/skip2/go-qrcode"
	"net/url"
	"strconv"
	"strings"
)

type AuthRedirectController struct {
	rc controller.RestController
}

func (rest *AuthRedirectController) OutAuthQrcode(c *gin.Context) {

	appId := c.Query("app_id")
	redirectUri := c.Query("redirect_uri")
	baseUrl := "https://openauth.alipay.com/oauth2/appToAppAuth.htm"

	stateMap := make(map[string]string,0)
	stateMap["merchantId"] = "111222"
	stateMap["mobile"] = "1762545859"
	stateMap["invited"] = "3746521"

	b,err :=  json.Marshal(stateMap)
	if err != nil {
		fmt.Println("err",err)
	}

	state := base64.StdEncoding.EncodeToString(b)

	fmt.Println("state",state)

	p := url.Values{}
	p.Add("app_id",appId)
	p.Add("redirect_uri",redirectUri)
	p.Add("state",state)
	e := p.Encode()
	fmt.Println("e",e)

	qrcodeUrl := baseUrl + "?" + e
	fmt.Println("",qrcodeUrl)

	q, err := qrcode.New(qrcodeUrl, qrcode.Medium)
	if err != nil {
		panic(err)
	}

	q.DisableBorder = true//去掉边框

	//70*70一般手机最小能扫描的尺寸了  输出的文件名称:output.png
	err = q.WriteFile(200, "output.png")
	if err != nil {
		panic(err)
	}

	// ?app_id=2021001192664075&redirect_uri=http%3A%2F%2Fwww.gincmf.com%2Falipay%2FauthRedirect&state=eyJhIjoxMjMsImIiOjQ1Nn0%3D
}

// 支付宝第三方授权扫码回调
func (rest *AuthRedirectController) Get(c *gin.Context) {

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

	// 获取统一公共参数
	op := alipayEasySdk.OptionsController{
		Protocol:           "https",
		GatewayHost:        "openapi.alipay.com/gateway.do",
		SignType:           "RSA2",
		AppId:              appId,
		Charset:            "utf-8",
		MerchantPrivateKey: "",
		AlipayCertPath:     "",
		AlipayRootCertPath: "",
		MerchantCertPath:   "",
		NotifyUrl:          "",
		EncryptKey:         "",
	}
	op.SetOptions()
	oauth := base.Oauth{}
	data := oauth.GetOpenToken(appAuthCode)

	var result map[string]interface{}
	_ = json.Unmarshal(data, &result)

	fmt.Println("result", result)
	temp := result["alipay_open_auth_token_app_response"]
	response := temp.(map[string]interface{})

	codeStatus := response["code"].(string)

	if codeStatus == "10000" {

		fmt.Println("response", response)
		token := response["tokens"]
		fmt.Println("token", token)

		tokenMap := token.([]interface{})

		fmt.Println("tokenMap", tokenMap)

		for k, v := range tokenMap {

			temp := v.(map[string]interface{})

			fmt.Println(k, v)
			userId := temp["user_id"].(string)
			authAppId := temp["auth_app_id"].(string)
			appAuthToken := temp["app_auth_token"].(string)
			appRefreshToken := temp["app_refresh_token"].(string)
			expiresIn := temp["expires_in"].(float64)
			expiresInStr := strconv.FormatFloat(expiresIn, 'f', -1, 64)

			reExpiresIn := temp["re_expires_in"].(float64)
			reExpiresInStr := strconv.FormatFloat(reExpiresIn, 'f', -1, 64)


			auth := model.AlipayAuth{}

			query := []string{"user_id","auth_app_id"}
			queryArgs := []interface{}{userId,authAppId}
			queryStr := strings.Join(query,"AND ")
			result := cmf.Db.Where(queryStr,queryArgs...).First(&auth)

			auth.UserId = userId
			auth.AuthAppId = authAppId
			auth.AppAuthToken = appAuthToken
			auth.AppRefreshToken = appRefreshToken
			auth.ExpiresIn = expiresInStr
			auth.ReExpiresIn = reExpiresInStr

			if result.RowsAffected == 0 {
				cmf.Db.Create(&auth)
			}else{
				cmf.Db.Save(&auth)
			}

			rest.rc.Success(c, "授权成功！", auth)
			return
		}
	}

	rest.rc.Error(c, "授权失败！", result)
}
