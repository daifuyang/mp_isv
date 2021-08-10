/**
** @创建时间: 2021/1/2 9:47 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type ScoreLog struct {
	Id         int      `json:"id"`
	UserId     int      `gorm:"type:int(11);comment:所属用户id;not null" json:"user_id"`
	Type       int      `gorm:"type:tinyint(3);comment:(类型：0：增加，1：扣除);not null" json:"type"`
	Score      int      `gorm:"type:int(11);comment:增加积分;not null" json:"score"`
	Fee        string   `gorm:"type:varchar(11);comment:合计金额;default:0;not null" json:"fee"`
	Remark     string   `gorm:"type:varchar(255);comment:备注" json:"remark"`
	CreateAt   int64    `gorm:"type:bigint(20);not nul" json:"create_at"`
	CreateTime string   `gorm:"-" json:"create_time"`
	Db         *gorm.DB `gorm:"-" json:"-"`
	paginate   cmfModel.Paginate
}

// 订单日志
func (model *ScoreLog) Save() error {

	db := model.Db

	if model.CreateAt == 0 {
		model.CreateAt = time.Now().Unix()
	}

	if tx := db.Create(&model); tx.Error != nil {
		return tx.Error
	}

	return nil

}

func (model *ScoreLog) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	db := model.Db
	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var log []ScoreLog
	db.Where(queryStr, queryArgs...).Find(&log).Count(&total)
	tx := db.Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&log)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range log {
		log[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
	}

	paginate := cmfModel.Paginate{Data: log, Current: current, PageSize: pageSize, Total: total}
	if len(log) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

func (model *ScoreLog) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}
