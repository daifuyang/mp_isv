/**
** @创建时间: 2020/12/12 10:25 上午
** @作者　　: return
** @描述　　:
 */
package settings

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
)

type Common struct {
	rc controller.RestController
}

type BusinessInfo struct {
	BrandName       string `json:"brand_name"`
	BrandLogo       string `json:"brand_logo"`
	AlipayLogoId    string `json:"alipay_logo_id"`
	Company         string `json:"company"`
	Address         string `json:"address"`
	Contact         string `json:"contact"`
	Mobile          string `json:"mobile"`
	Email           string `json:"email"`
	BusinessLicense string `json:"business_license"`
	BusinessScope   string `json:"business_scope"`
	BusinessExpired string `json:"business_expired"`
	BusinessPhoto   string `json:"business_photo"`
}

// @Summary 系统基础设置
// @Description 查看系统基础设置
// @Tags restaurant 系统设置
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=BusinessInfo} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/settings/business_info [get]
func (rest *Common) Show(c *gin.Context) {

	mid, _ := c.Get("mid")
	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND mid = ?", "business_info",mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}
	bi := BusinessInfo{}
	json.Unmarshal([]byte(op.OptionValue), &bi)

	var res struct {
		BusinessInfo
		BrandLogoPrev     string `json:"brand_logo_prev"`
		BusinessPhotoPrev string `json:"business_photo_prev"`
	}

	res.BusinessInfo = bi
	res.BrandLogoPrev = util.GetFileUrl(bi.BrandLogo)
	res.BusinessPhotoPrev = util.GetFileUrl(bi.BusinessPhoto)

	rest.rc.Success(c, "获取成功！", res)

}

// @Summary 系统基础设置
// @Description 提交系统基础设置
// @Tags restaurant 系统设置
// @Accept mpfd
// @Produce mpfd
// @Param brand_name formData string true "品牌名称"
// @Param brand_logo formData string true "品牌LOGO"
// @Param company formData string false "公司"
// @Param address formData string false "公司地址"
// @Param contact formData string false "联系人"
// @Param mobile formData string false "手机号"
// @Param email formData string false "邮箱"
// @Param business_license formData string false "营业执照许可证"
// @Param business_scope formData string false "经营范围"
// @Param business_expired formData string false "营业执照有效期"
// @Param business_photo formData string false "营业执照照片"
// @Success 200 {object} model.ReturnData{data=BusinessInfo} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/settings/business_info [post]
func (rest *Common) Edit(c *gin.Context) {

	mid, _ := c.Get("mid")

	// 品牌名
	brandName := c.PostForm("brand_name")
	if brandName == "" {
		rest.rc.Error(c, "品牌名不能为空！", nil)
		return
	}

	// 品牌LOGO
	brandLogo := c.PostForm("brand_logo")
	if brandLogo == "" {
		rest.rc.Error(c, "品牌LOGO不能为空！", nil)
		return
	}

	absPath := util.CurrentPath() + "/public/uploads/" + brandLogo
	b, err := util.ExistPath(absPath)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if !b {
		rest.rc.Error(c, "品牌LOGO地址错误！", nil)
		return
	}


	bizContent := make(map[string]string, 0)
	bizContent["image_type"] = "jpg"
	bizContent["image_name"] = "brand_logo"
	imgResult, err := new(base.Image).Upload(bizContent, absPath)

	if imgResult.Response.Code != "10000" {
		rest.rc.Error(c, "上传失败！"+imgResult.Response.SubMsg, imgResult)
		return
	}

	fmt.Println(imgResult)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	company := c.PostForm("company")
	address := c.PostForm("address")
	contact := c.PostForm("contact")
	mobile := c.PostForm("mobile")
	email := c.PostForm("email")
	businessLicense := c.PostForm("business_license")
	businessScope := c.PostForm("business_scope")
	businessExpired := c.PostForm("business_expired")
	businessPhoto := c.PostForm("business_photo")

	op := model.Option{}

	var businessInfo BusinessInfo
	businessInfo.BrandName = brandName
	businessInfo.BrandLogo = brandLogo
	businessInfo.AlipayLogoId = imgResult.Response.ImageId
	businessInfo.Company = company
	businessInfo.Address = address
	businessInfo.Contact = contact
	businessInfo.Mobile = mobile
	businessInfo.Email = email
	businessInfo.BusinessLicense = businessLicense
	businessInfo.BusinessScope = businessScope
	businessInfo.BusinessExpired = businessExpired
	businessInfo.BusinessPhoto = businessPhoto

	result := cmf.NewDb().Where("option_name = ?", "business_info").First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	op.Mid = mid.(int)
	op.AutoLoad = 1
	op.OptionName = "business_info"

	val, err := json.Marshal(businessInfo)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	op.OptionValue = string(val)

	var tx *gorm.DB
	if op.Id == 0 {
		tx = cmf.NewDb().Create(&op)
	} else {
		tx = cmf.NewDb().Save(&op)
	}

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "修改成功！", businessInfo)

}
