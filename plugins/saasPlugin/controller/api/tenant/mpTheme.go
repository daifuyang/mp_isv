/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序列表
 */
package tenant

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	portalModel "gincmf/plugins/portalPlugin/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"gincmf/plugins/saasPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type MpTheme struct {
	rc controller.Rest
}

func (rest *MpTheme) Get(c *gin.Context) {
	var mpTheme []model.MpTheme

	superRole := model.SuperRole(c)

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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var query = []string{"delete_at = ?"}
	var queryArgs = []interface{}{0}

	// 不是超级管理只能查看授权的目录

	var total int64 = 0
	var tx *gorm.DB
	if superRole {

		queryStr := strings.Join(query, " AND ")
		db.Where(queryStr, queryArgs...).First(&mpTheme).Count(&total)
		tx = db.Where(queryStr, queryArgs...).Limit(intPageSize).Offset((intCurrent - 1) * intPageSize).Order("id desc").Find(&mpTheme)

	} else {

		userId, _ := c.Get("user_id")
		query = append(query, "admin_user_id = ?")
		queryArgs = append(queryArgs, userId)

		queryStr := strings.Join(query, " AND ")
		prefix := cmf.Conf().Database.Prefix
		db.Table(prefix+"mp_theme theme").
			Joins("INNER JOIN "+prefix+"theme_admin_user_post p ON p.mid = theme.mid").
			Where(queryStr, queryArgs...).
			First(&mpTheme).Count(&total)

		tx = db.Table(prefix+"mp_theme as theme").
			Joins("INNER JOIN "+prefix+"mp_theme_admin_user_post p ON p.mid = theme.mid").
			Where(queryStr, queryArgs...).
			Limit(intPageSize).Offset((intCurrent - 1) * intPageSize).
			Order("theme.id desc").Find(&mpTheme)

	}

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

		v.AppLogoPrev = util.GetFileUrl(v.AppLogo, "clipper")

		mpThemeFile := model.MpThemePage{}
		result := db.Where("theme_id = ? and home = 1", v.Id).First(&mpThemeFile)

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
			db.Create(&themeFile)

			mid = util.EncodeId(uint64(themeFile.Id))
		}

		temp = append(temp, tempStruct{
			MpTheme: v,
			HomeId:  mid,
		})

	}

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mp := model.MpTheme{}
	tx := db.Where("id = ?", rewrite.Id).First(&mp)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	mp.AppLogoPrev = util.GetFileUrl(mp.AppLogo, "clipper")

	rest.rc.Success(c, "获取成功！", mp)

}

func (rest *MpTheme) ShowByMid(c *gin.Context) {

	mid, _ := c.Get("mid")

	mp := model.MpTheme{}

	var style model.Style

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	db.Where("mid = ?", mid).First(&mp)

	json.Unmarshal([]byte(mp.Style), &style)

	mp.StyleJson = style

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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mp := model.MpTheme{}
	tx := db.Where("id = ?", rewrite.Id).First(&mp)

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "该小程序不存在！", nil)
		return
	}

	mp.Name = name
	mp.AppLogo = appLogo

	db.Save(&mp)

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
	iTenantId, _ := c.Get("tenant_id")
	tenantId, _ := iTenantId.(int)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 判断当前用户开通的门户数
	var count int64 = 0
	db.Model(&model.MpTheme{}).Where("delete_at = 0").Count(&count)

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

	op := resModel.Option{
		Mid: mid,
		Db:  db,
	}
	_, err = op.Updates(businessInfo)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mpTheme := model.MpTheme{}
	if themeId > 0 {
		tx := db.Where("id = ?", themeId).Find(&mpTheme)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
	}

	saasTheme := saasModel.MpTheme{
		Mid:       mid,
		Name:      name,
		Thumbnail: mpTheme.Thumbnail,
		ThemeId:   themeId,
		TenantId:  tenantId,
		AppLogo:   appLogo,
		Style:     "{}",
		CreateAt:  time.Now().Unix(),
	}

	var mpThemePage []model.MpThemePage

	err = db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(&saasTheme).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}

		if themeId == 0 {
			mpThemePage = append(mpThemePage, model.MpThemePage{
				ThemeId:     saasTheme.Id,
				Mid:         mid,
				Title:       "首页",
				File:        "home",
				Home:        1,
				Style:       "{}",
				ConfigStyle: "{}",
				More:        "{}",
				CreateAt:    time.Now().Unix(),
			})
		} else {
			var pages []appModel.MpThemePage
			prefix := cmf.Conf().Database.Prefix
			cmf.Db().Debug().Table(prefix+"mp_theme t").Select("p.*").
				Joins("INNER JOIN  "+prefix+"mp_theme_page p ON t.id = p.theme_id").
				Where("t.id = ?", themeId).Scan(&pages)

			mpThemePage = make([]saasModel.MpThemePage, 0)
			for _, v := range pages {

				style := v.Style

				if style == "" {
					style = "{}"
				}

				spItem := saasModel.MpThemePage{
					ThemeId:     saasTheme.Id,
					Mid:         mid,
					Title:       v.Title,
					Home:        v.Home,
					File:        v.File,
					Style:       style,
					ConfigStyle: style,
					More:        v.More,
					ConfigMore:  v.More,
					CreateAt:    time.Now().Unix(),
					UpdateAt:    time.Now().Unix(),
				}
				mpThemePage = append(mpThemePage, spItem)
			}
		}

		fmt.Println("mpThemePage", mpThemePage)

		// 插入主题单页面
		if err := tx.Create(&mpThemePage).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}
		return nil

	})

	if err != nil {
		rest.rc.Error(c, "创建失败！", err.Error())
		return
	}

	// 初始化角色
	role := saasModel.Role{
		Db: db,
	}
	role.Init(mid)

	// 初始化门户
	pc := portalModel.PortalCategory{
		Db: db,
	}
	pc.Init(mid)

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

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mp := model.MpTheme{
		Id:       rewrite.Id,
		DeleteAt: time.Now().Unix(),
	}

	db.Updates(&mp)

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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	businessJson, err := saasModel.Options(db, "business_info", mid.(int))
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	bi := resModel.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)

	rest.rc.Success(c, "更新成功", bi)

}

// 解绑小程序授权关系
func (rest *MpTheme) UnOauth(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	tenant, err := model.CurrentTenant(c)
	if err != nil {
		rest.rc.Error(c, "该租户不存在！", nil)
		return
	}

	oauth := appModel.MpIsvAuth{}

	tx := cmf.Db().Where("tenant_id = ? AND mp_id = ? AND  id = ?", tenant.TenantId, mid, rewrite.Id).First(&oauth)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		cmfLog.Error(tx.Error.Error())
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "授权信息不存在或已删除", nil)
		return
	}

	// 删除版本信息
	tx = db.Where("mid = ? AND  type = ?", oauth.MpId, oauth.Type).Delete(&saasModel.MpThemeVersion{})
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if oauth.Type == "alipay" {
		// 删除小程序的加密aesKey
		tx = db.Debug().Model(saasModel.MpTheme{}).Where("mid = ?", oauth.MpId).Updates(map[string]interface{}{
			"encrypt_key":            "",
			"alipay_exp_qr_code_url": "",
		})
		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
	}

	if oauth.Type == "wechat" {

		// 删除微信相关信息
		tx = db.Model(&saasModel.MpTheme{}).Where("mid = ?", oauth.MpId).Updates(map[string]interface{}{
			"wechat_exp_qr_code_url": "",
			"sub_mchid":              "",
			"wechat_qr_code_url":     "",
		})
		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

	}

	tx = cmf.Db().Where("tenant_id = ? AND mp_id = ? AND  id = ?", tenant.TenantId, mid, rewrite.Id).Delete(&oauth)
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "解绑成功！", nil)

}
