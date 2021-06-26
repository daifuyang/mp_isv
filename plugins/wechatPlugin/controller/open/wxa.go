/**
** @创建时间: 2021/5/3 7:02 下午
** @作者　　: return
** @描述　　:
 */
package open

import (
	"errors"
	"fmt"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"gincmf/plugins/wechatPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/open"
	"gorm.io/gorm"
	"time"
)

type Wxa struct {
	rc controller.Rest
}

func (rest *Wxa) AccessToken(c *gin.Context) {

	accessToken, exist := c.Get("accessToken")
	if !exist {
		rest.rc.Error(c, "授权失败！,ak不存在", nil)
		return
	}

	// 获取回调授权authorizationCode
	authorizerAccessToken, exist := c.Get("authorizerAccessToken")
	if !exist {
		rest.rc.Error(c, "授权失败！,aak不存在", nil)
		return
	}

	rest.rc.Success(c, "获取成功！", gin.H{
		"componentAccessToken":  accessToken,
		"authorizerAccessToken": authorizerAccessToken,
	})
}

func (rest *Wxa) FastRegisterWeApp(c *gin.Context) {

	accessToken, exist := c.Get("accessToken")

	if !exist {
		rest.rc.Error(c, "accessToken不存在！", nil)
		return
	}

	var form struct {
		Name               string `json:"name"`
		Code               string `json:"code"`
		CodeType           int    `json:"code_type"`
		LegalPersonaWechat string `json:"legal_persona_wechat"`
		LegalPersonaName   string `json:"legal_persona_name"`
		ComponentPhone     string `json:"component_phone"`
		Pwd                string `json:"pwd"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if form.Pwd != "codecloud2021" {
		rest.rc.Error(c, "安全秘钥验证失败！", nil)
		return
	}

	if form.Name == "" {
		rest.rc.Error(c, "企业名不能为空", nil)
		return
	}

	if form.CodeType == 0 || form.CodeType > 3 {
		rest.rc.Error(c, "企业代码类型错误或为空", nil)
		return
	}

	if form.LegalPersonaWechat == "" {
		rest.rc.Error(c, "法人微信不能为空", nil)
		return
	}

	if form.LegalPersonaName == "" {
		rest.rc.Error(c, "法人姓名不能为空", nil)
		return
	}

	if form.ComponentPhone == "" {
		form.ComponentPhone = "17177723588"
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["name"] = form.Name
	bizContent["code"] = form.Code
	bizContent["code_type"] = form.CodeType
	bizContent["legal_persona_wechat"] = form.LegalPersonaWechat
	bizContent["legal_persona_name"] = form.LegalPersonaName
	bizContent["component_phone"] = form.ComponentPhone

	regResult := new(open.Component).FastRegisterWeapp(accessToken.(string), bizContent)

	if regResult.Errcode != 0 {
		rest.rc.Error(c, regResult.Errmsg, nil)
		return
	}

	rest.rc.Success(c, "发起成功，请尽快处理", regResult)

}

func (rest *Wxa) AddTemplate(c *gin.Context) {

	// 获取回调授权authorizationCode
	authorizerAccessToken, exist := c.Get("authorizerAccessToken")
	if !exist {
		rest.rc.Error(c, "授权失败！,aak不存在", nil)
		return
	}

	mid, _ := c.Get("mid")

	template, err := new(model.Subscribe).Edit(authorizerAccessToken.(string), mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "添加成功！", gin.H{
		"template": template,
	})

}

func (rest *Wxa) GetTemplates(c *gin.Context) {

	mid, _ := c.Get("mid")

	template, err := new(model.Subscribe).Show(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", gin.H{
		"template": template,
	})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 开通即使配送模板
 * @Date 2021/6/12 23:43:32
 * @Param
 * @return
 **/
func (rest *Wxa) OpenDelivery(c *gin.Context) {

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")
	if !akExist {
		rest.rc.Error(c, "authorizerAccessToken不存在！", nil)
		return
	}
	at := authorizerAccessToken.(string)

	var rewrite struct {
		Id string `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	deliveryId := rewrite.Id
	immediateDelivery := resModel.ImmediateDelivery{}
	tx := cmf.NewDb().Where("delivery_id = ?", deliveryId).First(&immediateDelivery)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 未开通先开通权限
	if tx.RowsAffected == 0 {
		result := new(open.Delivery).Open(at, deliveryId)
		fmt.Println(result)
		if result.Errcode > 0 && result.Errcode != 930569 {
			rest.rc.Error(c, result.Errmsg, nil)
			return
		}

		deliveryName := ""
		switch deliveryId {
		case "DADA":
			deliveryName = "达达"
		default:

		}

		immediateDelivery.DeliveryName = deliveryName
		immediateDelivery.DeliveryId = deliveryId
		immediateDelivery.CreateAt = time.Now().Unix()

		cmf.NewDb().Create(&immediateDelivery)
	}

	// 添加绑定账号
	result := new(open.Delivery).Add(at, deliveryId)
	if result.Errcode > 0 {
		rest.rc.Error(c, result.Errmsg, nil)
		return
	}

	rest.rc.Success(c, "发起绑定成功！", nil)

}
