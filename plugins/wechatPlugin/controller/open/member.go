/**
** @创建时间: 2021/5/5 7:07 下午
** @作者　　: return
** @描述　　:
 */
package open

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/open"
)

type Member struct {
	rc controller.Rest
}

func (rest *Member) Members(c *gin.Context) {

	accessToken, _ := c.Get("authorizerAccessToken")
	if accessToken == "" {
		rest.rc.Error(c, "授权失败！", nil)
		return
	}

	data := new(open.Wxa).MemberAuth(accessToken.(string))

	if data.Errcode != 0 {
		rest.rc.Error(c, data.Errmsg, nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}
