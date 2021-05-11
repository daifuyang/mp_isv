/**
** @创建时间: 2021/3/25 10:46 下午
** @作者　　: return
** @描述　　:
 */
package home

import (
	"fmt"
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
	tx := cmf.Db().Where("code = ?", rewrite.Id).First(&qrcode)
	if tx.Error != nil {
		v.Error("该二维码非指定点餐二维码！")
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

	fmt.Println("qrcode",qrcode)

	// 判断绑定状态
	if qrcode.Status == 1 {

		status.UnBind = false
		status.Deactivate = false

		fmt.Println(uaType)

		if uaType == "alipay" {

			queryUrl,err := url.Parse("?"+qrcode.Query)
			if err != nil {
				fmt.Println("err",queryUrl)
			}

			vals := queryUrl.Query()
			vals.Add("aqrfid", qrcode.Aqrfid)
			query := vals.Encode()
			query = url.QueryEscape(query)
			fmt.Println("query",query)
			platformapi := "alipays://platformapi/startapp?appId="+qrcode.AliAppId+"&page="+qrcode.Page+"&query=" + query

			fmt.Println("platformapi",platformapi)

			c.Redirect(301,platformapi)

			return

		}

	}

	v.Assign("status", status)

	v.Fetch("qrcode.html")
}
