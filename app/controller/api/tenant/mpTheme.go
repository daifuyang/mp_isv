/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序列表
 */
package tenant

import (
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type MpThemeController struct {
	rc controller.RestController
}

func (rest *MpThemeController) Get(c *gin.Context) {
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
	cmf.Db.First(&mpTheme).Count(&total)
	result := cmf.Db.Debug().Limit(intPageSize).Offset((intCurrent - 1) * intPageSize).Order("id desc").Find(&mpTheme)

	type tempStruct struct {
		model.MpTheme
		HomeId int `json:"home_id"`
	}

	var temp []tempStruct
	for _, v := range mpTheme {

		mpThemeFile := model.MpThemePage{}
		result := cmf.Db.Where("theme_id = ? and home = 1", v.Id).First(&mpThemeFile)

		// 对外加密id
		number := util.EncodeId(uint64(mpThemeFile.Id))

		if result.Error != nil {
			themeFile := model.MpThemePage{
				ThemeId:  v.Id,
				Title:    "首页",
				Home:     1,
				CreateAt: time.Now().Unix(),
			}
			cmf.Db.Create(&themeFile)

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

	paginationData := &model.Paginate{Data: temp, Current: current, PageSize: pageSize, Total: total}
	if len(temp) == 0 {
		paginationData.Data = make([]string, 0)
	}

	rest.rc.Success(c, "获取成功！", paginationData)
}

func (rest *MpThemeController) Store(c *gin.Context) {
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "name不能为空！", nil)
		return
	}
	themeIdStr := c.PostForm("theme_id")
	themeId, _ := strconv.Atoi(themeIdStr)
	tenantIdStr, _ := c.Get("user_id")
	tenantId, _ := strconv.Atoi(tenantIdStr.(string))

	mpTheme := model.MpTheme{
		Name:     name,
		ThemeId:  themeId,
		TenantId: tenantId,
		CreateAt: time.Now().Unix(),
	}

	var mpThemeFile []model.MpThemePage

	err := cmf.Db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(&mpTheme).Error; err != nil {
			// 返回任何错误都会回滚事务
			return err
		}

		number := util.EncodeId(uint64(mpTheme.Id))
		tx.Model(mpTheme).Update("number", number)

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
