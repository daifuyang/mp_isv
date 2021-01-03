/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序列表
 */
package tenant

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"runtime"
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

		mpThemeFile := model.MpThemePage{}
		result := cmf.NewDb().Where("theme_id = ? and home = 1", v.Id).First(&mpThemeFile)

		// 对外加密id
		number := util.EncodeId(uint64(mpThemeFile.Id))

		if result.Error != nil {
			themeFile := model.MpThemePage{
				ThemeId:  v.Id,
				Title:    "首页",
				Home:     1,
				CreateAt: time.Now().Unix(),
			}
			cmf.NewDb().Create(&themeFile)

			number = util.EncodeId(uint64(themeFile.Id))
		}

		temp = append(temp, tempStruct{
			MpTheme: v,
			HomeId:  number,
		})

	}

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	paginationData := &model.Paginate{Data: temp, Current: intCurrent, PageSize: intPageSize, Total: total}
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
	cmf.NewDb().Where("id = ?",rewrite.Id).First(&mp)

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

	mp := model.MpTheme{}
	tx := cmf.NewDb().Where("id = ?",rewrite.Id).First(&mp)

	if tx.RowsAffected == 0 {
		rest.rc.Error(c,"该小程序不存在！",nil)
		return
	}

	mp.Name = name

	cmf.NewDb().Save(&mp)

	rest.rc.Success(c,"修改成功！",nil)

}

func (rest *MpTheme) Store(c *gin.Context) {

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "name不能为空！", nil)
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
		rest.rc.Error(c,"体验用户最多可以生成三个小程序！",nil)
		return
	}

	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */

	year, month, day := time.Now().Date()
	yearStr := strconv.Itoa(year)
	monthStr := strconv.Itoa(int(month))
	if month < 10 {
		monthStr = "0" + monthStr
	}
	dayStr := strconv.Itoa(day)
	if day < 10 {
		dayStr = "0" + dayStr
	}

	insertKey := "mp_isv:mp_theme:" + yearStr + monthStr + dayStr
	val, err := cmf.NewRedisDb().Incr(insertKey).Result()

	// 设置当天失效时间
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
	cmf.NewRedisDb().ExpireAt(insertKey, today)

	if err != nil {
		_, _, line, _ := runtime.Caller(0)
		fmt.Println("redis err"+strconv.Itoa(line), err.Error())
	}

	nStr := yearStr + monthStr + dayStr + strconv.FormatInt(val, 10)
	n, _ := strconv.Atoi(nStr)
	number := util.EncodeId(uint64(n))

	mpTheme := model.MpTheme{
		Number:   number,
		Name:     name,
		ThemeId:  themeId,
		TenantId: tenantId,
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
				Title:    "首页",
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
		Id: rewrite.Id,
		DeleteAt: time.Now().Unix(),
	}
	cmf.NewDb().Updates(&mp)

	rest.rc.Success(c,"删除成功！",nil)

}
