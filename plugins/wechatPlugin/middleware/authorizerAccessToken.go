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

	mid, _ := c.Get("mid")

	tenantId, _ := c.Get("tenant_id")

	query := []string{"mp_id = ?", "tenant_id = ?", "type = ?"}
	queryArgs := []interface{}{mid, tenantId, "wechat"}

	isvAuth := model.MpIsvAuth{}
	data, err := isvAuth.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	if data.Id != 0 {

		authorizerAccessToken := data.AppAuthToken

		accessToken, exist := c.Get("accessToken")

		if exist {

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

				result := new(open.Component).AuthorizerToken(accessToken.(string), bizContent)

				if result.Errcode == 0 {

					ei := time.Now().Unix() + int64(result.ExpiresIn)
					data.AppAuthToken = result.AuthorizerAccessToken
					data.AppRefreshToken = result.AuthorizerRefreshToken
					data.ExpiresIn = strconv.FormatInt(ei, 10)

					tx := cmf.Db().Where("id = ?", data.Id).Updates(&data)

					if tx.Error != nil {
						new(controller.Rest).Error(c, tx.Error.Error(), nil)
						c.Abort()
						return
					}

					authorizerAccessToken = data.AppAuthToken

				} else {
					new(controller.Rest).Error(c, result.Errmsg, nil)
					c.Abort()
					return
				}

			}

			c.Set("authorizerAccessToken", authorizerAccessToken)

		}

	}

	c.Next()

}
