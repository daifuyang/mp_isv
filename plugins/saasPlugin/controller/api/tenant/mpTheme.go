/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序列表
 */
package tenant

import (
	"encoding/json"
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"gincmf/plugins/saasPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type MpTheme struct {
	rc controller.RestController
}

func (rest *MpTheme) Get(c *gin.Context) {
	var mpTheme []model.MpTheme

	current := c.DefaultQuery("current", "1")
	pageSize := c.DefaultQuery("pageSize", "10")

	intCurrent, _ := strconv.Atoi(current)
	intPageSize, _ := strconv.Atoi(pageSize)

	if intCurrent <= 0 {
		rest.rc.Error(c, "当前页码需大于0！", nil)
		return
	}

	if intPageSize <= 0 {
		rest.rc.Error(c, "每页数需大于0！", nil)
		return
	}

	var total int64 = 0
	cmf.NewDb().First(&mpTheme).Count(&total)
	result := cmf.NewDb().Where("delete_at = 0").Limit(intPageSize).Offset((intCurrent - 1) * intPageSize).Order("id desc").Find(&mpTheme)

	type tempStruct struct {
		model.MpTheme
		HomeId int `json:"home_id"`
	}

	var temp []tempStruct
	for _, v := range mpTheme {

		createTime := time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		v.CreateTime = createTime

		updateTime := time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
		v.UpdateTime = updateTime

		v.AppLogoPrev = util.GetFileUrl(v.AppLogo)

		mpThemeFile := model.MpThemePage{}
		result := cmf.NewDb().Where("theme_id = ? and home = 1", v.Id).First(&mpThemeFile)

		// 对外加密id
		mid := util.EncodeId(uint64(mpThemeFile.Id))

		if result.Error != nil {
			themeFile := model.MpThemePage{
				ThemeId:  v.Id,
				Mid:      v.Mid,
				Title:    "首页",
				Home:     1,
				CreateAt: time.Now().Unix(),
			}
			cmf.NewDb().Create(&themeFile)

			mid = util.EncodeId(uint64(themeFile.Id))
		}

		temp = append(temp, tempStruct{
			MpTheme: v,
			HomeId:  mid,
		})

	}

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	paginationData := appModel.Paginate{Data: temp, Current: intCurrent, PageSize: intPageSize, Total: total}
	if len(temp) == 0 {
		paginationData.Data = make([]string, 0)
	}

	rest.rc.Success(c, "获取成功！", paginationData)
}

func (rest *MpTheme) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mp := model.MpTheme{}
	cmf.NewDb().Where("id = ?", rewrite.Id).First(&mp)

	rest.rc.Success(c, "获取成功！", mp)

}

func (rest *MpTheme) ShowByMid(c *gin.Context) {

	mid, _ := c.Get("mid")

	mp := model.MpTheme{}
	cmf.NewDb().Debug().Where("mid = ?", mid).First(&mp)

	rest.rc.Success(c, "获取成功！", mp)

}

func (rest *MpTheme) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "name不能为空！", nil)
		return
	}

	appLogo := c.PostForm("app_logo")
	if appLogo == "" {
		rest.rc.Error(c, "logo图标不能为空！", nil)
		return
	}

	mp := model.MpTheme{}
	tx := cmf.NewDb().Where("id = ?", rewrite.Id).First(&mp)

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "该小程序不存在！", nil)
		return
	}

	mp.Name = name
	mp.AppLogo = appLogo

	cmf.NewDb().Save(&mp)

	rest.rc.Success(c, "修改成功！", nil)

}

func (rest *MpTheme) Store(c *gin.Context) {

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "name不能为空！", nil)
		return
	}

	appLogo := c.PostForm("app_logo")
	if appLogo == "" {
		rest.rc.Error(c, "logo图标不能为空！", nil)
		return
	}

	miniCategoryIds := c.PostForm("mini_category_ids")
	if miniCategoryIds == "" {
		rest.rc.Error(c, "小程序分类不能为空", nil)
		return
	}

	themeIdStr := c.PostForm("theme_id")
	themeId, _ := strconv.Atoi(themeIdStr)
	tenantIdStr, _ := c.Get("user_id")
	tenantId, _ := strconv.Atoi(tenantIdStr.(string))

	// 判断当前用户开通的门户数
	var count int64 = 0
	cmf.NewDb().Model(&model.MpTheme{}).Where("delete_at = 0").Count(&count)

	if count > 2 {
		rest.rc.Error(c, "体验用户最多可以生成三个小程序！", nil)
		return
	}

	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */

	year, month, day := util.CurrentDate()
	date := year + month + day
	insertKey := "mp_isv:mp_theme" + date
	number := util.EncryptUuid(insertKey, date, 0)
	mid, _ := strconv.Atoi(number)

	businessInfo := resModel.BusinessInfo{}
	businessInfo.BrandName = name
	businessInfo.BrandLogo = appLogo
	businessInfo.MiniCategoryIds = miniCategoryIds

	op := resModel.Option{Mid: mid}
	_, err := op.Updates(businessInfo)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mpTheme := model.MpTheme{
		Mid:      mid,
		Name:     name,
		ThemeId:  themeId,
		TenantId: tenantId,
		AppLogo:  appLogo,
		CreateAt: time.Now().Unix(),
	}

	var mpThemeFile []model.MpThemePage

	err = cmf.NewDb().Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(&mpTheme).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}

		if themeId == 0 {
			mpThemeFile = append(mpThemeFile, model.MpThemePage{
				ThemeId:  mpTheme.Id,
				Mid:      mid,
				Title:    "首页",
				File:     "home",
				Home:     1,
				CreateAt: time.Now().Unix(),
			})

			// 插入主题单页面
			if err := tx.Create(&mpThemeFile).Error; err != nil {
				// 返回任何错误都会回滚事务
				return err
			}
			return nil
		}
		return nil
	})

	if err != nil {
		rest.rc.Error(c, "创建失败！", err.Error())
		return
	}

	rest.rc.Success(c, "创建成功！", mpTheme)
}

func (rest *MpTheme) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mp := model.MpTheme{
		Id:       rewrite.Id,
		DeleteAt: time.Now().Unix(),
	}
	cmf.NewDb().Updates(&mp)

	rest.rc.Success(c, "删除成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 修改小程序类目信息
 * @Date 2021/3/2 10:26:12
 * @Param
 * @return
 **/

func (rest *MpTheme) UpdateCategory(c *gin.Context) {

	mid, _ := c.Get("mid")

	miniCategoryIds := c.Query("mini_category_ids")
	if miniCategoryIds == "" {
		rest.rc.Error(c, "小程序分类不能为空", nil)
		return
	}

	businessJson := saasModel.Options("business_info", mid.(int))
	bi := resModel.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)

	rest.rc.Success(c, "更新成功", bi)

}

// 解绑小程序授权关系
func (rest *MpTheme) UnOauth(c *gin.Context) {

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	tenant := model.CurrentTenant(c)

	oauth := appModel.MpIsvAuth{}

	tx := cmf.NewDb().Where("tenant_id = ? AND mp_id = ?", tenant.TenantId, mid).First(&oauth)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "授权信息不存在或已删除", nil)
		return
	}

	tx = cmf.NewDb().Where("tenant_id = ? AND mp_id = ?", tenant.TenantId, mid).Delete(&oauth)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "解绑成功！", nil)

}
