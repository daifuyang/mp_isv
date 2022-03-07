/**
** @创建时间: 2021/4/21 12:42 下午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"strings"
	"time"
)

func AccessToken(c *gin.Context) {

	// 获取accessToken
	options := wechatEasySdk.OpenOptions()

	if options.ComponentVerifyTicket == "" {
		redis :=cmf.RedisDb()
		ticket, err := redis.Get("componentVerifyTicket").Result()
		if err == nil {
			options.ComponentVerifyTicket = ticket
		}
	}

	if options.ComponentVerifyTicket != "" {

		bizContent := map[string]interface{}{
			"component_appid":         options.AppId,
			"component_appsecret":     options.AppSecret,
			"component_verify_ticket": options.ComponentVerifyTicket,
		}

		redis :=cmf.RedisDb()

		accessToken, err := redis.Get("accessToken").Result()

		if accessToken == "" || err != nil {
			token := new(open.Component).Token(bizContent)

			if token.Errcode == 0 {
				accessToken = strings.TrimSpace(token.AccessToken)
				if accessToken != "" {
					redis.Set("accessToken", accessToken, time.Minute*110)
				}
			}
		}

		if accessToken != "" {
			c.Set("accessToken", accessToken)
		}
	}

	c.Next()
}
