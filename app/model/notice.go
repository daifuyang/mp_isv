/**
** @创建时间: 2020/12/31 1:21 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type AdminNotice struct {
	Id         int    `json:"id"`
	Title      string `gorm:"type:varchar(40);comment:通知标题;not null" json:"title"`
	Desc       string `gorm:"type:varchar(255);comment:通知描述" json:"desc"`
	CreateAt   int64  `gorm:"type:bigint(20);comment:创建时间;default:0" json:"create_at"`
	CreateTime string `gorm:"-" json:"create_time"`
	Type       int    `gorm:"type:tinyint(3);comment:类型（0 => 订单）;default:0" json:"type"`
	Status     int    `gorm:"type:tinyint(3);comment:状态（0 => 未读，1 => 已读）;default:0" json:"status"`
	Audio      string `gorm:"type:varchar(255);comment:通知提示音" json:"audio"`
	paginate   cmfModel.Paginate
}

func (model *AdminNotice) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}

// 查询消息列表
func (model *AdminNotice) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	paginationData, err := model.PaginateGet(current, pageSize, query, queryArgs)
	return paginationData, err

}

func (model *AdminNotice) PaginateGet(current int, pageSize int, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var notice []AdminNotice

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&notice).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&notice)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range notice {
		notice[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
	}

	paginationData := cmfModel.Paginate{Data: notice, Current: current, PageSize: pageSize, Total: total}
	if len(notice) == 0 {
		paginationData.Data = make([]string, 0)
	}

	return paginationData, nil

}

func (model *AdminNotice) Show(query []string, queryArgs []interface{}) (AdminNotice, error) {

	notice := AdminNotice{}
	queryStr := strings.Join(query, " AND ")
	tx := cmf.NewDb().Where(queryStr, queryArgs...).First(&notice)

	if tx.Error != nil {
		return notice, tx.Error
	}

	return notice, nil
}

// 新增一条消息
func (model *AdminNotice) Save(title string, desc string, t int, audio string) (AdminNotice, error) {

	notice := AdminNotice{
		Title:    title,
		Desc:     desc,
		CreateAt: time.Now().Unix(),
		Type:     t,
		Status:   0,
		Audio:    audio,
	}

	tx := cmf.NewDb().Create(&notice)

	if tx.Error != nil {
		return AdminNotice{}, nil
	}

	return notice, nil

}
