/**
** @创建时间: 2021/3/25 10:46 下午
** @作者　　: return
** @描述　　:
 */
package home

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/view"
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
func (v *Qrcode) Index(c *gin.Context) {

	ua := c.Request.Header.Get("user-agent")
	ua = strings.ToLower(ua)

	uaType := "h5"
	regBool, err := regexp.MatchString("alipay", ua)
	if err != nil {
	}

	if regBool {
		uaType = "alipay"
	}

	regBool, err = regexp.MatchString("weixin", ua)
	if err != nil {}

	if regBool {
		uaType = "wechat"
	}

	iTemplate, _ := c.Get("template")
	v.Template = iTemplate.(view.Template)

	// 完成业务
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	qrcode := model.Qrcode{}
	tx := cmf.Db().Debug().Where("code = ?", rewrite.Id).First(&qrcode)
	if tx.Error != nil {
		c.String(200, "<p>"+tx.Error.Error()+"</p>")
		return
	}

	var status struct {
		UnBind     bool `json:"un_bind"`
		Deactivate bool `json:"deactivate"`
	}

	status.UnBind = true

	if uaType == "alipay" {

		vals := url.Values{}
		vals.Add("query", "aqrfid=1643")
		query := vals.Encode()
		platformapi := "alipays://platformapi/startapp?appId=2021001192675085&page=pages/index/index&query=" + query

		c.Redirect(301,platformapi)

		return

	}

	if qrcode.Status == 2 {
		status.UnBind = false
		status.Deactivate = true
	}

	// 判断绑定状态
	if qrcode.Status == 1 {

	}

	v.Assign("status", status)

	v.Fetch("qrcode.html")
}
