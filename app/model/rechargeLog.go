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

type RechargeLog struct {
	Id         int    `json:"id"`
	TargetId   int    `gorm:"type:bigint(20);comment:所属目标订单id;not null" json:"target_id"`
	TargetType int    `gorm:"type:tinyint(3);comment:(目标类型：0：订单);default:0;not null" json:"target_type"`
	UserId     int    `gorm:"type:bigint(20);comment:所属用户id;not null" json:"user_id"`
	Type       int    `gorm:"type:tinyint(3);comment:(类型：0：增加，1：扣除);not null" json:"type"`
	Fee        string `gorm:"type:varchar(11);comment:(消费/充值)金额;default:0;not null" json:"fee"`
	Balance    string `gorm:"type:varchar(11);comment:剩余余额;default:0;not null" json:"balance"`
	Remark     string `gorm:"type:varchar(255);comment:备注" json:"remark"`
	CreateAt   int64  `gorm:"type:bigint(20);not nul" json:"create_at"`
	CreateTime string `gorm:"-" json:"create_time"`
	paginate   cmfModel.Paginate
	Db         *gorm.DB `gorm:"-" json:"-"`
}

// 订单日志
func (model *RechargeLog) Save() error {

	if model.CreateAt == 0 {
		model.CreateAt = time.Now().Unix()
	}

	if tx := model.Db.Create(&model); tx.Error != nil {
		return tx.Error
	}

	return nil

}

func (model *RechargeLog) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var log []RechargeLog
	model.Db.Where(queryStr, queryArgs...).Find(&log).Count(&total)
	tx := model.Db.Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&log)
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

func (model *RechargeLog) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}
