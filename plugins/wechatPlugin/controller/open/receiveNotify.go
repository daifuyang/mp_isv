/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　: 微信三方平台授权
 */
package open

import (
	"encoding/base64"
	"encoding/xml"
	"fmt"
	"gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	wechatMiddle "gincmf/plugins/wechatPlugin/middleware"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"net/http"
	"strconv"
	"strings"
	"time"
)

type ReceiveNotify struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 授权事件接收URL
 * @Date 2021/4/20 13:21:6
 * @Param
 * @return
 **/
func (rest *ReceiveNotify) Notify(c *gin.Context) {

	var form struct {
		AppId   string `xml:"AppId"`
		Encrypt string `xml:"Encrypt"`
	}

	err := c.ShouldBindXML(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	appId := strings.TrimSpace(form.AppId)
	encrypt := strings.TrimSpace(form.Encrypt)

	encryptBytes, _ := base64.StdEncoding.DecodeString(encrypt)

	openOptions := wechatEasySdk.OpenOptions()
	aesKey := openOptions.Aeskey

	result, err := util.AesDeCrypt(encryptBytes, []byte(aesKey))

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	end := strings.LastIndex(string(result), appId)

	if end == -1 {
		rest.rc.Error(c, "非法签名！", nil)
		return
	}

	result = result[20:end]

	var tickets struct {
		AppId                 string
		CreateTime            int64
		InfoType              string
		ComponentVerifyTicket string
	}

	xml.Unmarshal(result, &tickets)

	if tickets.ComponentVerifyTicket != "" {
		fmt.Println("tickets.ComponentVerifyTicket", tickets.ComponentVerifyTicket)
		cmfLog.Save(tickets.ComponentVerifyTicket, "tickets.log")
		wechatEasySdk.SetOpenOption("ComponentVerifyTicket", tickets.ComponentVerifyTicket)

		redis := cmf.NewRedisDb()
		redis.Set("componentVerifyTicket", tickets.ComponentVerifyTicket, time.Hour*12)
	}

	c.String(http.StatusOK, "success")
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 消息事件推送时间
 * @Date 2021/5/6 8:27:47
 * @Param
 * @return
 **/
func (rest *ReceiveNotify) AppIdNotify(c *gin.Context) {

	var rewrite struct {
		AppId string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	defer c.Request.Body.Close()

	var form struct {
		AppId   string `xml:"AppId"`
		Encrypt string `xml:"Encrypt"`
	}

	err := c.ShouldBindXML(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	appId := strings.TrimSpace(form.AppId)
	encrypt := strings.TrimSpace(form.Encrypt)

	mpAuth := model.MpIsvAuth{}
	tx := cmf.Db().Where("auth_app_id = ?", appId).Order("id desc").First(&mpAuth)

	if tx.RowsAffected == 0 {
		fmt.Println("ValidationMp,小程序app_id不正确")
		cmfLog.Error("小程序app_id不正确，appId：" + appId)
		controller.Rest{}.Error(c, "小程序auth_app_id不正确！", nil)
		c.Abort()
		return
	}

	// 设置访问数据库
	db := "tenant_" + strconv.Itoa(mpAuth.TenantId)
	cmf.ManualDb(db)

	mid := mpAuth.MpId

	c.Set("mid", mid)
	c.Set("app_id", appId)
	c.Set("mp_type", mpAuth.Type)

	wechatMiddle.AccessToken(c)
	wechatMiddle.AuthorizerAccessToken(c)

	accessToken, _ := c.Get("authorizerAccessToken")
	if accessToken == "" {
		rest.rc.Error(c, "授权失败！", nil)
		return
	}

	encryptBytes, _ := base64.StdEncoding.DecodeString(encrypt)

	openOptions := wechatEasySdk.OpenOptions()
	aesKey := openOptions.Aeskey

	result, err := util.AesDeCrypt(encryptBytes, []byte(aesKey))

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	end := strings.LastIndex(string(result), appId)

	if end == -1 {
		rest.rc.Error(c, "非法签名！", nil)
		return
	}

	result = result[20:end]

	var auditEvent struct {
		ToUserName   string `xml:"ToUserName"`
		FromUserName string `xml:"FromUserName"`
		CreateTime   int    `xml:"CreateTime"`
		MsgType      string `xml:"MsgType"`
		Event        string `xml:"Event"`
		SuccTime     int    `xml:"SuccTime"`
		FailTime     int    `xml:"FailTime"`
		DelayTime    int    `xml:"DelayTime"`
		Reason       string `json:"reason"`
		ScreenShot   string `json:"screen_shot"`
	}

	xml.Unmarshal(result, &auditEvent)

	version, err := new(saasModel.MpThemeVersion).Show(nil, nil)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if auditEvent.Event == "weapp_audit_fail" {

		version.Status = "reject"
		version.RejectReason = auditEvent.Reason
		version.IsAudit = 0

		tx := cmf.NewDb().Updates(&version)

		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	if auditEvent.Event == "weapp_audit_success" {

		version.Status = "audit"
		version.RejectReason = auditEvent.Reason
		version.IsAudit = 0

		releaseResponse := new(open.Wxa).Release(accessToken.(string))
		if releaseResponse.Errcode == 0 {
			version.Status = "online"
		}

		tx := cmf.NewDb().Updates(&version)

		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	c.String(http.StatusOK, "success")

}
