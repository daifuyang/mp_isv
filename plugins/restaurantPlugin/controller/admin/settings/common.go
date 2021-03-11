/**
** @创建时间: 2020/12/12 10:25 上午
** @作者　　: return
** @描述　　:
 */
package settings

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
)

type Common struct {
	rc controller.RestController
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
	result := cmf.NewDb().Where("option_name = ? AND mid = ?", "business_info", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}
	bi := model.BusinessInfo{}
	json.Unmarshal([]byte(op.OptionValue), &bi)

	var res struct {
		model.BusinessInfo
		BrandLogoPrev      string `json:"brand_logo_prev"`
		BusinessPhotoPrev  string `json:"business_photo_prev"`
		OutDoorPicPrev     string `json:"out_door_pic_prev"`
		FoodLicensePicPrev string `json:"food_license_pic_prev"`
	}

	res.BusinessInfo = bi
	res.BrandLogoPrev = util.GetFileUrl(bi.BrandLogo)
	res.BusinessPhotoPrev = util.GetFileUrl(bi.BusinessPhoto)
	res.OutDoorPicPrev = util.GetFileUrl(bi.OutDoorPic)
	res.FoodLicensePicPrev = util.GetFileUrl(bi.FoodLicensePic)

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
	_, exist := c.Get("user_id")

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

	var (
		businessInfo model.BusinessInfo
		imageId      string
		err          error
	)

	if exist {
		imageId, err = businessInfo.AlipayImageId(brandLogo)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	company := c.PostForm("company")
	address := c.PostForm("address")
	contact := c.PostForm("contact")
	mobile := c.PostForm("mobile")
	email := c.PostForm("email")
	miniCategoryIds := c.PostForm("mini_category_ids")
	businessLicense := c.PostForm("business_license")
	businessScope := c.PostForm("business_scope")
	businessExpired := c.PostForm("business_expired")
	businessPhoto := c.PostForm("business_photo")
	appSlogan := c.PostForm("app_slogan")
	appDesc := c.PostForm("app_desc")
	outDoorPic := c.PostForm("out_door_pic")
	foodLicensePic := c.PostForm("food_license_pic")

	businessInfo.BrandName = brandName
	businessInfo.BrandLogo = brandLogo
	businessInfo.AlipayLogoId = imageId
	businessInfo.Company = company
	businessInfo.Address = address
	businessInfo.Contact = contact
	businessInfo.Mobile = mobile
	businessInfo.Email = email
	businessInfo.BusinessLicense = businessLicense
	businessInfo.BusinessScope = businessScope
	businessInfo.BusinessExpired = businessExpired
	businessInfo.BusinessPhoto = businessPhoto
	businessInfo.AppSlogan = appSlogan
	businessInfo.AppDesc = appDesc
	businessInfo.OutDoorPic = outDoorPic
	businessInfo.FoodLicensePic = foodLicensePic
	businessInfo.MiniCategoryIds = miniCategoryIds

	op := model.Option{
		Mid: mid.(int),
	}

	_, err = op.Updates(businessInfo)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "修改成功！", businessInfo)

}
