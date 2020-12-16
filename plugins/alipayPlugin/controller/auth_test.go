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
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/skip2/go-qrcode"
	"net/url"
	"strconv"
	"strings"
	"testing"
)

func TestAuthRedirectController_OpenAuth(t *testing.T) {
	baseUrl := "https://openauth.alipay.com/oauth2/appToAppBatchAuth.htm"
	appId := "2021001192664075"
	redirectUri := "http://www.codecloud.ltd/alipay/auth_redirect"

	stateMap := make(map[string]string,0)

	stateMap["tenant_id"] = "1051453199"
	stateMap["mp_id"] = "2090057678"
	stateMap["type"] = "alipay"
	sign ,bizContent := easyUtil.Sign(stateMap)

	stateMap["biz_content"] = bizContent
	stateMap["sign"] = sign


	b,err :=  json.Marshal(stateMap)
	if err != nil {
		fmt.Println("err",err)
	}

	state := base64.StdEncoding.EncodeToString(b)

	fmt.Println("state",state)

	p := url.Values{}
	p.Add("app_id",appId)
	p.Add("application_type","TINYAPP")
	p.Add("redirect_uri",redirectUri)
	p.Add("state",state)

	e := p.Encode()

	//e += "&state="+state
	fmt.Println("e",e)


	qcrodeUrl := baseUrl + "?" + e
	fmt.Println("qcrodeUrl",qcrodeUrl)

	//png, err := qrcode.Encode(qcrodeUrl, qrcode.Medium,256)
	//if err != nil {
	//	panic(err)
	//}

	 q, _ := qrcode.New(qcrodeUrl,qrcode.Highest)
	 q.WriteFile(512,"output.png")

	// ?app_id=2021001192664075&redirect_uri=http%3A%2F%2Fwww.gincmf.com%2Falipay%2FauthRedirect&state=eyJhIjoxMjMsImIiOjQ1Nn0%3D
}

func TestAuthRedirectController_Get(t *testing.T) {

	cmf.Initialize("../../../data/conf/config.json")

	appAuthCode := "Pe7ce3e638fd041358fd21a7add59e61"
	state := "eyJiaXpfY29udGVudCI6Imludml0ZWQ9Mzc0NjUyMVx1MDAyNm1lcmNoYW50SWQ9MTExMjIyXHUwMDI2bW9iaWxlPTE3NjI1NDU4NTkiLCJpbnZpdGVkIjoiMzc0NjUyMSIsIm1lcmNoYW50SWQiOiIxMTEyMjIiLCJtb2JpbGUiOiIxNzYyNTQ1ODU5Iiwic2lnbiI6ImMxU21ESlRhaExOdXU5UDZRUnhLNGxLYThvQ2FDNUg5Nm5Ia1lzbFg0QU5mTUptTFpvTE1CL3JGQ0RKOGx1TTU4ZHBFa0x6SU9JVEtzR1B0Tkd2ZkY5cHhGNmJ3U3NJdmI3ZGNTWU1zWHZac2g1RXljdDlqS1N2R2hQZlNsNis4NFV2Tmw2RFI5QmpQRHpkZXJVRWVNMVdUbnUyS05lVy9sVlBhbXd0c1JoL3ZLU1pFRXJnWUdWMmNmYllTNitDNTJSWUFBSFdyMlB4Wll3bmNBbmZUeHd0ZlNadkxnRTZNVWRIZUhwVXlTdWtmN0RKZjR1MXpWREdqa3V2UDloSkgwWlA0RnhIanowbkQveitJK3Z4a0szSWgvWnZwL0lTdkV2VW5KQ1dBN0FoMVUyTkZHZHd1K1hNeityeWpyaTM4ZlBtSWFsdXVzUnBkM3VSbExpc2pzQT09In0="

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodeStr := string(decoded[:])

	fmt.Println("state",decodeStr)
	inParams := make(map[string]string,0)
	json.Unmarshal(decoded,&inParams)

	sign := inParams["sign"]
	fmt.Println("sign",sign)

	bizContent := inParams["biz_content"]
	fmt.Println("biz_content", bizContent)

	// 验证签名
	err := easyUtil.VerifySign(bizContent,sign)

	if err != nil {
		fmt.Println("验证签名出错！")
		return
	}

	options := map[string]string{
		"protocol":           "https",
		"gatewayHost":        "openapi.alipay.com/gateway.do",
		"signType":           "RSA2",
		"appId":              "2021001192664075",
		"version":            "1.0",
		"charset":            "utf-8",
		"merchantPrivateKey": "",
		"alipayCertPath":     "",
		"alipayRootCertPath": "",
		"merchantCertPath":   "",
		"notifyUrl":          "",
		"encryptKey":         "",
		"appAuthToken":       "202011BB7180118e46ed488489e442aba3047A61",
	}

	alipayEasySdk.NewOptions(options)

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


			auth := model.MpIsvAuth{}

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
				cmf.NewDb().Create(&auth)
			}else{
				cmf.NewDb().Save(&auth)
			}
		}

	}

}
