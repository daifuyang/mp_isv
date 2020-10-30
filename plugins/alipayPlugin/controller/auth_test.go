/**
** @创建时间: 2020/9/5 9:38 下午
** @作者　　: return
** @描述　　:
 */
package controller

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/skip2/go-qrcode"
	"net/url"
	"strconv"
	"strings"
	"testing"
)

func TestAuthRedirectController_OpenAuth(t *testing.T) {
	baseUrl := "https://openauth.alipay.com/oauth2/appToAppAuth.htm"
	appId := "2021001192664075"
	redirectUri := "http://www.gincmf.com/alipay/authRedirect"

	stateMap := make(map[string]string,0)
	stateMap["merchantId"] = "111222"
	stateMap["mobile"] = "1762545859"


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

	//e += "&state="+state
	fmt.Println("e",e)


	qcrodeUrl := baseUrl + "?" + e
	fmt.Println("qcrodeUrl",qcrodeUrl)

	q, err := qrcode.New(qcrodeUrl, qrcode.Medium)
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

func TestAuthRedirectController_Get(t *testing.T) {

	cmf.Initialize("../../../../conf/config.json")

	appId := "2021001192664075"
	appAuthCode := "Pe7ce3e638fd041358fd21a7add59e61"
	state := "eyJhIjoiMTIzIiwiYiI6IjQ1NiJ9"

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodestr := string(decoded[:])

	fmt.Println("state",decodestr)

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
	json.Unmarshal(data, &result)

	fmt.Println("result",result)

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
		}

	}

}
