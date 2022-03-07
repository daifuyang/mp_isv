/**
** @创建时间: 2021/3/25 10:46 下午
** @作者　　: return
** @描述　　:
 */
package home

import (
	"fmt"
	"gincmf/app/model"
	wechatMiddle "gincmf/plugins/wechatPlugin/middleware"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/view"
	"github.com/gincmf/wechatEasySdk/open"
	"net/url"
	"regexp"
	"strings"
)

type Qrcode struct {
	view.Template
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 扫码跳转
 * @Date 2021/3/28 9:9:40
 * @Param
 * @return
 **/
func (web *Qrcode) Index(c *gin.Context) {

	ua := c.Request.Header.Get("user-agent")
	ua = strings.ToLower(ua)

	uaType := "h5"
	regBool, err := regexp.MatchString("alipay", ua)
	if err != nil {
	}

	if regBool {
		uaType = "alipay"
	}

	regBool, err = regexp.MatchString("micromessenger", ua)
	if err != nil {
	}

	if regBool {
		uaType = "wechat"
	}

	view := web.GetView(c)

	// 完成业务
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	qrcode := model.Qrcode{}
	tx := cmf.Db().Where("code = ?", rewrite.Id).First(&qrcode)
	if tx.Error != nil {
		view.Error("该二维码非指定点餐二维码！")
		return
	}

	var status struct {
		UnBind     bool `json:"un_bind"`
		Deactivate bool `json:"deactivate"`
	}

	status.UnBind = true

	if qrcode.Status == 2 {
		status.UnBind = false
		status.Deactivate = true
	}

	// 判断绑定状态
	canOpen := false
	if qrcode.Status == 1 {

		status.UnBind = false
		status.Deactivate = false

		if qrcode.AliAppId != "" {

			canOpen = true

			queryUrl, err := url.Parse("?" + qrcode.Query)
			if err != nil {
				fmt.Println("err", queryUrl)
			}

			vals := queryUrl.Query()
			vals.Add("aqrfid", qrcode.Aqrfid)
			query := vals.Encode()
			query = url.QueryEscape(query)
			// fmt.Println("query",query)
			platformapi := "alipays://platformapi/startapp?appId=" + qrcode.AliAppId + "&page=" + qrcode.Page + "&query=" + query
			view.Assign("platformapi", platformapi)
		}

		// 获取回调授权authorizationCode
		accessToken, exist := c.Get("accessToken")
		if exist {
			authorizerAccessToken, err := wechatMiddle.GetAuthorizerAccessToken(qrcode.Mid, qrcode.TenantId, accessToken.(string))

			if err != nil {
				if uaType == "wechat" {
					view.Error("请联系商户开通微信小程序！")
					return
				}
			} else {
				canOpen = true
				var bizContent = map[string]interface{}{
					"path":  "/" + qrcode.Page,
					"query": qrcode.Query,
				}

				schemeResponse := new(open.Wxa).GenerateUrlLink(authorizerAccessToken, bizContent)
				if schemeResponse.Errcode != 0 && uaType == "wechat" {
					view.Error(schemeResponse.Errmsg)
					return
				}

				view.Assign("wechatScheme", schemeResponse.UrlLink)
			}
		}
		view.Assign("uaType", uaType)
	}
	view.Assign("status", status)

	if canOpen {
		view.Fetch("openMp.html")
	} else {
		view.Fetch("qrcode.html")
	}

}
