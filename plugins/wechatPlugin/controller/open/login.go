/**
** @创建时间: 2021/4/21 10:27 上午
** @作者　　: return
** @描述　　:
 */
package open

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
)

type Login struct {
	rc controller.Rest
}

func (rest *Login) Login(c *gin.Context) {

	mid, _ := c.Get("mid")
	accessToken, exist := c.Get("accessToken")

	if !exist {
		rest.rc.Error(c,"accessToken不存在！",nil)
		return
	}

	appId, _ := c.Get("app_id")
	code := c.Query("code")

	options := wechatEasySdk.OpenOptions()

	params := open.Code2Session{
		AppId:                appId.(string),
		JsCode:               code,
		ComponentAppid:       options.AppId,
		ComponentAccessToken: accessToken.(string),
	}

	data := new(open.Component).Code2session(params)

	if data.Errcode > 0 {
		cmf.NewRedisDb().Del("accessToken")
		rest.rc.Error(c, "获取失败！"+data.Errmsg, data)
		return
	}

	openId := data.Openid
	sessionKey := data.SessionKey
	query := []string{"tp.open_id = ? AND tp.mid = ?"}
	queryArgs := []interface{}{openId, mid}

	// 查询当前用户是否存在
	var err error
	userPart := model.UserPart{}
	userPart, err = userPart.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 当前三方关系不存在 新建第三方用户
	if userPart.OpenId == "" {
		cmf.NewDb().Where("open_id = ?", openId).FirstOrCreate(&model.ThirdPart{
			Mid:        mid.(int),
			Type:       "wechat-mp",
			UserId:     0,
			OpenId:     openId,
			SessionKey: sessionKey,
		})
	} else {
		cmf.NewDb().Where("open_id = ?", openId).Updates(&model.ThirdPart{
			SessionKey: sessionKey,
		})
	}

	data.SessionKey = ""
	rest.rc.Success(c, "登录成功！", data)

}
