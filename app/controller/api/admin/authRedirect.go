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
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"strconv"
	"strings"
)

type AuthRedirectController struct {
	rc controller.RestController
}

func (rest *AuthRedirectController) Get(c *gin.Context) {

	appId := c.Query("app_id")
	appAuthCode := c.Query("app_auth_code")
	fmt.Println("app_id",appId)
	fmt.Println("app_auth_code",appAuthCode)
	state := c.Query("state")

	decoded, _ := base64.StdEncoding.DecodeString(state)
	decodestr := string(decoded)

	fmt.Println("state",decodestr)

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
