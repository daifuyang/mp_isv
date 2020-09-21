/**
** @创建时间: 2020/9/5 9:38 下午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
	"strings"
	"testing"
)

func TestAuthRedirectController_Get(t *testing.T) {

	cmf.Initialize("../../../../conf/config.json")

	appId := "2021000120611436"
	appAuthCode := "2565329bb70a4fbfb4c8036028986B20"
	state := "eyJhIjoiMTIzIiwiYiI6IjQ1NiJ9"

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodestr := string(decoded[:])

	fmt.Println("state",decodestr)
	return

	op := alipayEasySdk.OptionsController{
		Protocol:           "https",
		GatewayHost:        "openapi.alipaydev.com/gateway.do",
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
