/**
** @创建时间: 2021/3/19 12:56 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	appModel "gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"time"
)

type AdminNotice struct {
	Mid int `gorm:"type:bigint(20);comment:小程序加密编号;not null" json:"mid"`
	appModel.AdminNotice
	Db *gorm.DB `gorm:"-" json:"-"`
}

func (model *AdminNotice) Index(c *gin.Context) (cmfModel.Paginate, error) {

	db := model.Db

	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	var total int64 = 0

	var noticeMap []AdminNotice
	tx := db.Where("mid = ?", model.Mid).Order("id desc").Find(&noticeMap).Count(&total)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	tx = db.Where("mid = ?", model.Mid).Order("id desc").Limit(pageSize).Offset((current - 1) * pageSize).Find(&noticeMap)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: noticeMap, Current: current, PageSize: pageSize, Total: total}
	if len(noticeMap) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

func (model *AdminNotice) Save(mid int, title string, desc string, id int, t int, audio string) (AdminNotice, error) {

	db := model.Db

	notice := AdminNotice{
		Mid: mid,
		AdminNotice: appModel.AdminNotice{
			Title:    title,
			Desc:     desc,
			TargetId: id,
			CreateAt: time.Now().Unix(),
			Type:     t,
			Status:   0,
			Audio:    audio,
		},
	}

	tx := db.Create(&notice)

	if tx.Error != nil {
		return AdminNotice{}, nil
	}

	return notice, nil

}
