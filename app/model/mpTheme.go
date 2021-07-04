/**
** @创建时间: 2021/3/28 8:55 下午
** @作者　　: return
** @描述　　: 主题预设
 */
package model

import (
	"errors"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

// 小程序主题
type MpTheme struct {
	Id            int    `json:"id"`
	Name          string `gorm:"type:varchar(20);comment:主题名称;not null" json:"name"`
	Thumbnail     string `gorm:"type:varchar(255);comment:主题缩略图;not null" json:"thumbnail"`
	ThumbnailPrev string `gorm:"-" json:"thumbnail_prev"`
	CreateAt      int64  `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt      int64  `gorm:"type:bigint(20)" json:"update_at"`
	CreateTime    string `gorm:"-" json:"create_time"`
	UpdateTime    string `gorm:"-" json:"update_time"`
	Status        int    `gorm:"type:tinyint(3);not null;comment:活码状态（0 => 停用，1 => 启用）;default:1" json:"status"`
}

// 主题预设
type MpThemePage struct {
	Id       int    `json:"id"`
	ThemeId  int    `gorm:"type:bigint(20);;comment:主题id;not null;default:0" json:"theme_id"`
	Home     int    `gorm:"type:tinyint(3);comment:是否为首页;not null;default:0" json:"home"`
	Title    string `gorm:"type:varchar(20);comment:页面名称;not null" json:"title"`
	File     string `gorm:"type:varchar(20);comment:页面路径;not null" json:"file"`
	Style    string `gorm:"type:text;comment:主题文件用户公共样式" json:"style"`
	More     string `gorm:"type:text;comment:主题文件用户配置文件" json:"more"`
	CreateAt int64  `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt int64  `gorm:"type:bigint(20)" json:"update_at"`
}

func (model *MpTheme) AutoMigrate() {
	cmf.Db().AutoMigrate(&MpTheme{})
	cmf.Db().AutoMigrate(&MpThemePage{})
}

func (model *MpTheme) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var mpTheme []MpTheme
	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	cmf.Db().Where(queryStr, queryArgs...).Find(&mpTheme).Count(&total)
	tx := cmf.Db().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&mpTheme)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range mpTheme {
		prev := util.GetFileUrl(v.Thumbnail, "clipper")
		mpTheme[k].ThumbnailPrev = prev
		mpTheme[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		mpTheme[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(data.TimeLayout)
	}

	paginate := cmfModel.Paginate{Data: mpTheme, Current: current, PageSize: pageSize, Total: total}
	if len(mpTheme) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}
