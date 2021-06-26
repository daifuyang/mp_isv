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
	resModel "gincmf/plugins/restaurantPlugin/model"
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

	var requestForm struct {
		AppId                 string
		CreateTime            int64
		InfoType              string
		ComponentVerifyTicket string
	}

	xml.Unmarshal(result, &requestForm)

	switch requestForm.InfoType {
	case "component_verify_ticket":
		if requestForm.ComponentVerifyTicket != "" {
			fmt.Println("tickets.ComponentVerifyTicket", requestForm.ComponentVerifyTicket)
			cmfLog.Save(requestForm.ComponentVerifyTicket, "tickets.log")
			wechatEasySdk.SetOpenOption("ComponentVerifyTicket", requestForm.ComponentVerifyTicket)
			redis := cmf.NewRedisDb()
			redis.Set("componentVerifyTicket", requestForm.ComponentVerifyTicket, time.Hour*12)

			if cmf.Conf().App.Evn == "release" {
				redisDb, err := cmf.RedisDb("52.130.144.34", "codecloud2020")
				if err == nil {
					redisDb.Set("componentVerifyTicket", requestForm.ComponentVerifyTicket, time.Hour*12)
				}
			}

		}
	case "notify_third_fasteregister":

	default:
		c.String(http.StatusBadRequest, "not implements")
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

	fmt.Println("appId", appId)
	fmt.Println("encrypt", encrypt)

	authAppId := rewrite.AppId

	mpAuth := model.MpIsvAuth{}
	tx := cmf.Db().Where("auth_app_id = ?", authAppId).Order("id desc").First(&mpAuth)

	if tx.RowsAffected == 0 {
		fmt.Println("ValidationMp-小程序app_id不正确", appId)
		rest.rc.Error(c, "小程序auth_app_id不正确！", nil)
		return
	}

	c.Set("tenant_id", mpAuth.TenantId)
	// 设置访问数据库
	db := "tenant_" + strconv.Itoa(mpAuth.TenantId)
	cmf.ManualDb(db)

	mid := mpAuth.MpId

	c.Set("mid", mid)
	c.Set("app_id", appId)
	c.Set("mp_type", mpAuth.Type)

	wechatMiddle.AccessToken(c)
	wechatMiddle.AuthorizerAccessToken(c)

	accessToken, exist := c.Get("authorizerAccessToken")

	if !exist {
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

	type agent struct {
		Name      string `xml:"name"`
		Phone     string `xml:"phone"`
		ReachTime string `xml:"reach_time"`
	}

	var messageRequest struct {
		ToUserName   string `xml:"ToUserName"`
		FromUserName string `xml:"FromUserName"`
		CreateTime   int    `xml:"CreateTime"`
		MsgType      string `xml:"MsgType"`
		Event        string `xml:"Event"`
		Shopid       string `xml:"shopid"`
		ShopOrderId  string `xml:"shop_order_id"`
		WaybillId    string `xml:"waybill_id"`
		ActionTime   int    `xml:"action_time"`
		OrderStatus  int    `xml:"order_status"`
		ActionMsg    string `xml:"action_msg"`
		ShopNo       string `xml:"shop_no"`
		SuccTime     int    `xml:"SuccTime"`
		FailTime     int    `xml:"FailTime"`
		DelayTime    int    `xml:"DelayTime"`
		Reason       string `xml:"reason"`
		ScreenShot   string `xml:"screen_shot"`
		Agent        agent  `xml:"agent"`
	}

	xml.Unmarshal(result, &messageRequest)

	version, err := new(saasModel.MpThemeVersion).Show([]string{"mid = ?", "type = ?"}, []interface{}{mid, "wechat"})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	fmt.Println("result", string(result))

	if messageRequest.Event == "weapp_audit_fail" {

		version.Status = "reject"
		version.RejectReason = messageRequest.Reason
		version.IsAudit = 0

		tx := cmf.NewDb().Save(&version)

		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	if messageRequest.Event == "weapp_audit_success" {

		version.Status = "wait"
		version.RejectReason = messageRequest.Reason
		version.IsAudit = 1

		releaseResponse := new(open.Wxa).Release(accessToken.(string))
		if releaseResponse.Errcode == 0 {
			version.Status = "online"
			version.IsAudit = 0
		}

		tx := cmf.NewDb().Save(&version)

		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	if messageRequest.Event == "update_waybill_status" {
		var result struct {
			resModel.FoodOrder
			IdoId int `json:"ido_id"`
		}

		// 更新配送状态
		prefix := cmf.Conf().Database.Prefix
		tx := cmf.NewDb().Debug().Table(prefix+"immediate_delivery_order ido").Select("fo.*,ido.id as ido_id").
			Joins("INNER JOIN  "+prefix+"food_order fo ON ido.order_id = fo.order_id").
			Where("ido.shop_order_id = ?", messageRequest.ShopOrderId).
			Scan(&result)

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		// 更新状态
		ido := resModel.ImmediateDeliveryOrder{
			OrderStatus: messageRequest.OrderStatus,
		}
		cmf.NewDb().Where("id = ?", result.IdoId).Updates(&ido)
	}

	c.String(http.StatusOK, "success")

}
