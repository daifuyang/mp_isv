/**
** @创建时间: 2020/10/29 4:47 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"gincmf/app/util"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"strings"
	"time"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description 微信进件申请单
 * @Date 2021/4/30 16:58:20
 * @Param
 * @return
 **/
type Applyment struct {
	Id                int                 `json:"id"`
	BusinessCode      string              `gorm:"type:varchar(128);comment:服务商自定义的唯一编号;not null" json:"business_code"`
	ApplymentId       int                 `gorm:"type:bigint(20);comment:微信支付分配的申请单号;not null" json:"applyment_id"`
	MediaList         string              `gorm:"type:json;comment:图片资源存储json" json:"media_list"`
	Form              string              `gorm:"type:json;comment:用户提交得资料;not null" json:"form"`
	OriginForm        string              `gorm:"type:json;comment:用户提交得资料;not null" json:"origin_form"`
	CreateAt          int64               `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt          int64               `gorm:"type:bigint(20)" json:"update_at"`
	CreateTime        string              `gorm:"-" json:"create_time"`
	UpdateTime        string              `gorm:"-" json:"update_time"`
	SubMchid          string              `gorm:"type:varchar(32);comment:特约商户号，当申请单状态为APPLYMENT_STATE_FINISHED时才返回;" json:"sub_mchid"`
	SignUrl           string              `gorm:"type:varchar(255);comment:微信签约二维码;" json:"sign_url"`
	ApplymentState    string              `gorm:"type:varchar(32);comment:申请单状态;default:APPLYMENT_STATE_AUDITING" json:"applyment_state"`
	ApplymentStateMsg string              `gorm:"type:text(1024);comment:申请单状态描述" json:"applyment_state_msg"`
	AuditDetail       string              `gorm:"type:json;comment:驳回原因" json:"audit_detail"`
	PayStatus         int                 `gorm:"-" json:"pay_status"` // 是否为微信支付收钱账号
	AuditDetailObj    []map[string]string `gorm:"-" json:"audit_detail_obj"`
	MerchantName      string              `gorm:"-" json:"merchant_name"`
	OriginFormObj     Form                `gorm:"-" json:"origin_form_obj"`
	MediaListObj      MediaList           `gorm:"-" json:"media_list_obj"`
}

type contactInfo struct {
	ContactName     string `json:"contact_name" structs:"contact_name"`
	ContactIdNumber string `json:"contact_id_number" structs:"contact_id_number"`
	MobilePhone     string `json:"mobile_phone" structs:"mobile_phone"`
	ContactEmail    string `json:"contact_email" structs:"contact_email"`
}

type businessLicenseInfo struct {
	LicenseCopy   string `json:"license_copy" structs:"license_copy"`
	LicenseNumber string `json:"license_number" structs:"license_number"`
	MerchantName  string `json:"merchant_name" structs:"merchant_name"`
	LegalPerson   string `json:"legal_person" structs:"legal_person"`
}

type certificateInfo struct {
	CertCopy       string `json:"cert_copy" structs:"cert_copy"`
	CertType       string `json:"cert_type" structs:"cert_type"`
	CertNumber     string `json:"cert_number" structs:"cert_number"`
	MerchantName   string `json:"merchant_name" structs:"merchant_name"`
	CompanyAddress string `json:"company_address" structs:"company_address"`
	LegalPerson    string `json:"legal_person" structs:"legal_person"`
	PeriodBegin    string `json:"period_begin" structs:"period_begin"`
	PeriodEnd      string `json:"period_end" structs:"period_end"`
}

type organizationInfo struct {
	OrganizationCopy string `json:"organization_copy,omitempty" structs:"organization_copy,omitempty"`
	OrganizationCode string `json:"organization_code,omitempty" structs:"organization_code,omitempty"`
	OrgPeriodBegin   string `json:"org_period_begin,omitempty" structs:"org_period_begin,omitempty"`
	OrgPeriodEnd     string `json:"org_period_end,omitempty" structs:"org_period_end,omitempty"`
}

type idCardInfo struct {
	IdCardCopy      string `json:"id_card_copy" structs:"id_card_copy"`
	IdCardNational  string `json:"id_card_national" structs:"id_card_national"`
	IdCardName      string `json:"id_card_name" structs:"id_card_name"`
	IdCardNumber    string `json:"id_card_number" structs:"id_card_number"`
	CardPeriodBegin string `json:"card_period_begin" structs:"card_period_begin"`
	CardPeriodEnd   string `json:"card_period_end" structs:"card_period_end"`
}

type idDocInfo struct {
	IdDocCopy      string `json:"id_doc_copy" structs:"id_doc_copy"`
	IdDocName      string `json:"id_doc_name" structs:"id_doc_name"`
	IdDocNumber    string `json:"id_doc_number" structs:"id_doc_number"`
	DocPeriodBegin string `json:"doc_period_begin" structs:"doc_period_begin"`
	DocPeriodEnd   string `json:"doc_period_end" structs:"doc_period_end"`
}

type identityInfo struct {
	IdDocType  string     `json:"id_doc_type" structs:"id_doc_type"`
	IdCardInfo idCardInfo `json:"id_card_info,omitempty" structs:"id_card_info,omitempty"`
	IdDocInfo  idDocInfo  `json:"id_doc_info,omitempty" structs:"id_doc_info,omitempty"`
	Owner      bool       `json:"owner" structs:"owner"`
}

type subjectInfo struct {
	SubjectType         string              `json:"subject_type" structs:"subject_type"`
	BusinessLicenseInfo businessLicenseInfo `json:"business_license_info" structs:"business_license_info"`
	// CertificateInfo     certificateInfo     `json:"certificate_info" structs:"certificate_info"`
	OrganizationInfo organizationInfo `json:"organization_info,omitempty" structs:"organization_info,omitempty"`
	IdentityInfo     identityInfo     `json:"identity_info" structs:"identity_info"`
}

type bizStoreInfo struct {
	BizStoreName     string   `json:"biz_store_name" structs:"biz_store_name"`
	BizAddressRegion []int    `json:"biz_address_region"`
	BizAddressCode   string   `json:"biz_address_code" structs:"biz_address_code"`
	BizStoreAddress  string   `json:"biz_store_address" structs:"biz_store_address"`
	StoreEntrancePic []string `json:"store_entrance_pic" structs:"store_entrance_pic"`
	IndoorPic        []string `json:"indoor_pic" structs:"indoor_pic"`
}

type miniProgramInfo struct {
	MiniProgramAppid string   `json:"mini_program_appid" structs:"mini_program_appid"`
	MiniProgramPics  []string `json:"mini_program_pics" structs:"mini_program_pics"`
}

type salesInfo struct {
	SalesScenesType []string        `json:"sales_scenes_type" structs:"sales_scenes_type"`
	BizStoreInfo    bizStoreInfo    `json:"biz_store_info" structs:"biz_store_info"`
	MiniProgramInfo miniProgramInfo `json:"mini_program_info" structs:"mini_program_info"`
}

type businessInfo struct {
	MerchantShortname string    `json:"merchant_shortname" structs:"merchant_shortname"`
	ServicePhone      string    `json:"service_phone" structs:"service_phone"`
	SalesInfo         salesInfo `json:"sales_info" structs:"sales_info"`
}

// 结算
type settlementInfo struct {
	SettlementId        string   `json:"settlement_id" structs:"settlement_id"`
	QualificationType   string   `json:"qualification_type" structs:"qualification_type"`
	Qualifications      []string `json:"qualifications,omitempty" structs:"qualifications,omitempty"`
	ActivitiesId        string   `json:"activities_id" structs:"activities_id"`
	ActivitiesRate      string   `json:"activities_rate" structs:"activities_rate"`
	ActivitiesAdditions []string `json:"activities_additions,omitempty" structs:"activities_additions,omitempty"`
}

// 账号信息
type bankAccountInfo struct {
	BankAccountType   string `json:"bank_account_type" structs:"bank_account_type"`
	AccountName       string `json:"account_name" structs:"account_name"`
	AccountBank       string `json:"account_bank" structs:"account_bank"`
	BankAddressRegion []int  `json:"bank_address_region"`
	BankAddressCode   string `json:"bank_address_code" structs:"bank_address_code"`
	BankName          string `json:"bank_name,omitempty" structs:"bank_name,omitempty"`
	AccountNumber     string `json:"account_number" structs:"account_number"`
}

// 补充材料
type additionInfo struct {
	BusinessAdditionPics []string `json:"business_addition_pics,omitempty" structs:"business_addition_pics,omitempty"`
	BusinessAdditionMsg  string   `json:"business_addition_msg,omitempty" structs:"business_addition_msg,omitempty"`
}

type fileInfo struct {
	FileName string `json:"file_name"`
	FilePath string `json:"file_path"`
	MediaId  string `json:"media_id"`
	Name     string `json:"name"`
	PrevPath string `json:"prev_path"`
}

type MediaList struct {
	StoreEntrance    fileInfo   `json:"store_entrance"`
	Indoor           fileInfo   `json:"indoor"`
	MiniProgram      []fileInfo `json:"mini_program"`
	IdCardCopy       fileInfo   `json:"id_card_copy,omitempty"`
	IdCardNational   fileInfo   `json:"id_card_national,omitempty"`
	IdDocCopy        fileInfo   `json:"id_doc_copy,omitempty"`
	LicenseCopy      fileInfo   `json:"license_copy,omitempty"`
	Qualifications   fileInfo   `json:"qualifications,omitempty"`
	OrganizationCopy fileInfo   `json:"organization_copy,omitempty"`
	BusinessAddition []fileInfo `json:"business_addition,omitempty"`
}

type Form struct {
	BusinessCode    string          `json:"business_code" structs:"business_code"`
	ContactInfo     contactInfo     `json:"contact_info" structs:"contact_info"`
	SubjectInfo     subjectInfo     `json:"subject_info" structs:"subject_info"`
	BusinessInfo    businessInfo    `json:"business_info" structs:"business_info"`
	SettlementInfo  settlementInfo  `json:"settlement_info" structs:"settlement_info"`
	BankAccountInfo bankAccountInfo `json:"bank_account_info" structs:"bank_account_info"`
	AdditionInfo    additionInfo    `json:"addition_info,omitempty" structs:"addition_info,omitempty"`
	MediaList       MediaList       `json:"media_list,omitempty"`
}

func (model *Applyment) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&Applyment{})
}

func (model *Applyment) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	mid, _ := c.Get("mid")

	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	var applyment []Applyment
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Find(&applyment).Count(&total)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	tx = cmf.NewDb().Where(queryStr, queryArgs...).
		Limit(pageSize).Offset((current - 1) * pageSize).Find(&applyment)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	// 获取当前主题小程序
	theme := saasModel.MpTheme{}
	tx = cmf.NewDb().Where("mid = ?", mid).First(&theme)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range applyment {
		form := &Form{}
		json.Unmarshal([]byte(v.Form), &form)
		json.Unmarshal([]byte(v.AuditDetail), &applyment[k].AuditDetailObj)

		applyment[k].PayStatus = 0
		if theme.SubMchid != "" && theme.SubMchid == v.SubMchid {
			applyment[k].PayStatus = 1
		}

		applyment[k].MerchantName = form.SubjectInfo.BusinessLicenseInfo.MerchantName
		applyment[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		applyment[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	paginate := cmfModel.Paginate{Data: applyment, Current: current, PageSize: pageSize, Total: total}
	if len(applyment) == 0 {
		paginate.Data = make([]Applyment, 0)
	}

	return paginate, nil

}

func (model *Applyment) Show(query []string, queryArgs []interface{}) (applyment Applyment, err error) {

	queryStr := strings.Join(query, " AND ")
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Find(&applyment)
	if tx.Error != nil {
		return applyment, tx.Error
	}

	form := Form{}
	json.Unmarshal([]byte(applyment.OriginForm), &form)

	mlObj := MediaList{}
	json.Unmarshal([]byte(applyment.MediaList), &mlObj)

	json.Unmarshal([]byte(applyment.AuditDetail), &applyment.AuditDetailObj)

	for k, v := range mlObj.MiniProgram {
		mlObj.MiniProgram[k].PrevPath = util.GetFileUrl(v.FilePath,"clipper")
	}

	for k, v := range mlObj.BusinessAddition {
		mlObj.BusinessAddition[k].PrevPath = util.GetFileUrl(v.FilePath,"clipper")
	}

	applyment.OriginFormObj = form
	applyment.MediaListObj = mlObj
	applyment.MerchantName = form.SubjectInfo.BusinessLicenseInfo.MerchantName
	applyment.CreateTime = time.Unix(applyment.CreateAt, 0).Format("2006-01-02 15:04:05")
	applyment.UpdateTime = time.Unix(applyment.UpdateAt, 0).Format("2006-01-02 15:04:05")

	return applyment, nil
}
