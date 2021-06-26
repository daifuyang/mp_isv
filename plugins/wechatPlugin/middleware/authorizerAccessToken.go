/**
** @创建时间: 2021/4/23 12:49 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"errors"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
	"strconv"
	"time"
)

// 获取/刷新接口调用令牌
func AuthorizerAccessToken(c *gin.Context) {

	mpType, _ := c.Get("mp_type")

	wechat, wechatExist := c.Get("wechat")

	if mpType == "wechat" || wechatExist && wechat.(bool) {

		mid, _ := c.Get("mid")

		tenantId, _ := c.Get("tenant_id")

		accessToken, exist := c.Get("accessToken")

		if accessToken != "" && exist {
			authorizerAccessToken, err := GetAuthorizerAccessToken(mid, tenantId, accessToken.(string))
			if err != nil {
				new(controller.Rest).Error(c, err.Error(), nil)
				c.Abort()
				return
			}

			c.Set("authorizerAccessToken", authorizerAccessToken)
		}
	}

	c.Next()

}

func GetAuthorizerAccessToken(mid interface{}, tenantId interface{}, accessToken string) (authorizerAccessToken string, err error) {
	query := []string{"mp_id = ?", "tenant_id = ?", "type = ?"}
	queryArgs := []interface{}{mid, tenantId, "wechat"}

	isvAuth := model.MpIsvAuth{}
	data, err := isvAuth.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return authorizerAccessToken, err
	}

	if data != nil && data.Id > 0 {

		authorizerAccessToken := data.AppAuthToken

		if accessToken != "" {

			// 判断当前AuthorizerAccessToken是否过期
			expireIn, _ := strconv.Atoi(data.ExpiresIn)
			if int64(expireIn)-1200 < time.Now().Unix() {
				// 已过期重新刷新
				options := wechatEasySdk.OpenOptions()

				bizContent := map[string]interface{}{
					"component_appid":          options.AppId,
					"authorizer_appid":         data.AuthAppId,
					"authorizer_refresh_token": data.AppRefreshToken,
				}

				result := new(open.Component).AuthorizerToken(accessToken, bizContent)

				if result.Errcode == 0 {

					ei := time.Now().Unix() + int64(result.ExpiresIn)
					data.AppAuthToken = result.AuthorizerAccessToken
					data.AppRefreshToken = result.AuthorizerRefreshToken
					data.ExpiresIn = strconv.FormatInt(ei, 10)

					tx := cmf.Db().Where("id = ?", data.Id).Updates(&data)

					if tx.Error != nil {
						return authorizerAccessToken, tx.Error
					}

					authorizerAccessToken = data.AppAuthToken

				} else {
					return authorizerAccessToken, errors.New(result.Errmsg)
				}

			}

			return authorizerAccessToken, nil

		}

	}

	return authorizerAccessToken, errors.New("生成authorizerAccessToken失败！")
}
