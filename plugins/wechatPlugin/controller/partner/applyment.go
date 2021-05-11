/**
** @创建时间: 2021/4/29 10:11 下午
** @作者　　: return
** @描述　　: 微信支付申请单
 */
package partner

import (
	"encoding/json"
	"errors"
	"fmt"
	saasModel "gincmf/plugins/saasPlugin/model"
	"gincmf/plugins/wechatPlugin/model"
	"github.com/fatih/structs"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/merchant"
	"github.com/gincmf/wechatEasySdk/util"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Applyment struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部申请单
 * @Date 2021/5/1 0:1:2
 * @Param
 * @return
 **/
func (rest *Applyment) Get(c *gin.Context) {

	data, err := new(model.Applyment).Index(c, nil, nil)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
	return

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取单项申请单
 * @Date 2021/5/1 0:58:8
 * @Param
 * @return
 **/

func (rest *Applyment) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	query := []string{"id = ?"}
	queryArgs := []interface{}{rewrite.Id}

	data, err := new(model.Applyment).Show(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
	return

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交申请单
 * @Date 2021/5/1 0:0:54
 * @Param
 * @return
 **/
func (rest *Applyment) Store(c *gin.Context) {
	rest.Applyment(c, 0)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 编辑提交申请单
 * @Date 2021/5/1 9:7:22
 * @Param
 * @return
 **/
func (rest *Applyment) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	rest.Applyment(c, rewrite.Id)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 统一申请单请求
 * @Date 2021/5/1 14:11:43
 * @Param
 * @return
 **/
func (rest *Applyment) Applyment(c *gin.Context, editId int) {

	form := model.Form{}
	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mediaListStr, _ := json.Marshal(form.MediaList)
	mediaListJson := string(mediaListStr)

	form.MediaList = model.MediaList{}

	form.BusinessInfo.SalesInfo.MiniProgramInfo.MiniProgramAppid = "wx1da941c68db4f659"
	form.SubjectInfo.IdentityInfo.Owner = true

	// 配置结算规则
	if form.SubjectInfo.SubjectType == "SUBJECT_TYPE_INDIVIDUAL" {
		form.SettlementInfo.SettlementId = "719" // 个体户
	} else {
		form.SettlementInfo.SettlementId = "716"
	}

	form.SettlementInfo.ActivitiesId = "20191030111cff5b5e"
	form.SettlementInfo.ActivitiesRate = "0.38"

	form.BusinessCode = "APPLYMENT_" + strconv.Itoa(int(time.Now().Unix()))
	originForm := form
	originFormStr, _ := json.Marshal(originForm)

	fmt.Println("originFormStr", string(originFormStr))

	// 敏感数据加密
	/*contact_name*/
	contactName, err := util.EncryptCiphertext(form.ContactInfo.ContactName, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.ContactInfo.ContactName = contactName

	/*ContactIdNumber*/
	contactIdNumber, err := util.EncryptCiphertext(form.ContactInfo.ContactIdNumber, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.ContactInfo.ContactIdNumber = contactIdNumber

	/*mobile_phone*/
	mobilePhone, err := util.EncryptCiphertext(form.ContactInfo.MobilePhone, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.ContactInfo.MobilePhone = mobilePhone

	/*contact_email*/
	contactEmail, err := util.EncryptCiphertext(form.ContactInfo.ContactEmail, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.ContactInfo.ContactEmail = contactEmail

	/*organization_copy*/
	if form.SubjectInfo.OrganizationInfo.OrganizationCopy != "" {
		organizationCopy, err := util.EncryptCiphertext(form.SubjectInfo.OrganizationInfo.OrganizationCopy, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.OrganizationInfo.OrganizationCopy = organizationCopy
	}

	/*organization_code*/
	if form.SubjectInfo.OrganizationInfo.OrganizationCode != "" {
		organizationCode, err := util.EncryptCiphertext(form.SubjectInfo.OrganizationInfo.OrganizationCode, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.OrganizationInfo.OrganizationCode = organizationCode

	}

	/*id_card_info*/
	if form.SubjectInfo.IdentityInfo.IdDocType == "IDENTIFICATION_TYPE_IDCARD" {
		/*id_card_name*/
		idCardName, err := util.EncryptCiphertext(form.SubjectInfo.IdentityInfo.IdCardInfo.IdCardName, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.IdentityInfo.IdCardInfo.IdCardName = idCardName

		/*id_card_number*/
		idCardNumber, err := util.EncryptCiphertext(form.SubjectInfo.IdentityInfo.IdCardInfo.IdCardNumber, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.IdentityInfo.IdCardInfo.IdCardNumber = idCardNumber

	} else {

		/*id_doc_info*/
		idDocCopy, err := util.EncryptCiphertext(form.SubjectInfo.IdentityInfo.IdDocInfo.IdDocCopy, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.IdentityInfo.IdCardInfo.IdCardCopy = idDocCopy

		/*id_doc_name*/
		idDocName, err := util.EncryptCiphertext(form.SubjectInfo.IdentityInfo.IdDocInfo.IdDocName, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.IdentityInfo.IdDocInfo.IdDocName = idDocName

		/*id_doc_number*/
		idDocNumber, err := util.EncryptCiphertext(form.SubjectInfo.IdentityInfo.IdDocInfo.IdDocNumber, true)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		form.SubjectInfo.IdentityInfo.IdDocInfo.IdDocNumber = idDocNumber

	}

	/*account_name*/
	accountName, err := util.EncryptCiphertext(form.BankAccountInfo.AccountName, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.BankAccountInfo.AccountName = accountName

	/*account_number*/
	accountNumber, err := util.EncryptCiphertext(form.BankAccountInfo.AccountNumber, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	form.BankAccountInfo.AccountNumber = accountNumber

	bizContent := structs.Map(form)
	delete(bizContent, "media_list")

	bizContentStr, _ := json.Marshal(bizContent)

	data := new(merchant.Applyment).Applyment(bizContent)

	if data.Code != "" {
		rest.rc.Error(c, data.Message, nil)
		return
	}

	if data.ApplymentId > 0 {
		applyment := model.Applyment{}

		var tx *gorm.DB
		if editId > 0 {

			tx = cmf.NewDb().Where("id = ?", editId).First(&applyment)
			if tx.Error != nil {
				if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, "该申请记录不存在", nil)
					return
				}
			}

			auditDetail := "{}"
			if applyment.AuditDetail != "" {
				auditDetail = applyment.AuditDetail
			}

			applyment = model.Applyment{
				Id:             editId,
				BusinessCode:   form.BusinessCode,
				ApplymentId:    data.ApplymentId,
				MediaList:      mediaListJson,
				Form:           string(bizContentStr),
				OriginForm:     string(originFormStr),
				CreateAt:       time.Now().Unix(),
				UpdateAt:       time.Now().Unix(),
				ApplymentState: "APPLYMENT_STATE_AUDITING",
				AuditDetail:    auditDetail,
			}

			tx = cmf.NewDb().Save(&applyment)

		} else {
			tx = cmf.NewDb().Create(&applyment)
		}

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
	}

	rest.rc.Success(c, "提交成功！", data)

}

/*
 * 查看目前审核状态

 */

func (rest *Applyment) State(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	query := []string{"id = ?"}
	queryArgs := []interface{}{rewrite.Id}

	applyment, err := new(model.Applyment).Show(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	applyResult := new(merchant.Applyment).State(strconv.Itoa(applyment.ApplymentId))
	if applyResult.Code != "" {
		rest.rc.Error(c, applyResult.Message, applyResult)
		return
	}

	auditDetail, _ := json.Marshal(applyResult.AuditDetail)

	applyment.UpdateAt = time.Now().Unix()
	applyment.ApplymentState = applyResult.ApplymentState
	applyment.AuditDetail = string(auditDetail)
	applyment.AuditDetailObj = applyResult.AuditDetail
	tx := cmf.NewDb().Updates(&applyment)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", applyment)
	return

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 设置为微信主账号
 * @Date 2021/5/1 23:1:26
 * @Param
 * @return
 **/

func (rest *Applyment) BindSubMchid(c *gin.Context) {

	subMcchid := c.PostForm("sub_mchid")

	if subMcchid == "" {
		rest.rc.Error(c,"支付商户号不能为空！",nil)
		return
	}

	mid,_ := c.Get("mid")

	// 获取当前主题小程序
	theme := saasModel.MpTheme{}
	tx := cmf.NewDb().Where("mid = ?", mid).First(&theme)
	if tx.Error != nil {
		if errors.Is(tx.Error,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,"小程序不存在！",nil)
			return
		}
		rest.rc.Error(c,tx.Error.Error(),nil)
		return
	}

	theme.SubMchid = subMcchid
	tx = cmf.NewDb().Where("mid = ?",mid).Updates(&theme)
	if tx.Error != nil {
		rest.rc.Error(c,tx.Error.Error(),nil)
		return
	}

	rest.rc.Success(c,"设置成功！",nil)
}
