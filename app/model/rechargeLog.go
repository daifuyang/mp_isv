/**
** @创建时间: 2021/1/2 9:47 上午
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

type RechargeLog struct {
	Id         int    `json:"id"`
	UserId     int    `gorm:"type:int(11);comment:所属用户id;not null" json:"user_id"`
	Type       int    `gorm:"type:tinyint(3);comment:(类型：0：增加，1：扣除);not null" json:"type"`
	Fee        string `gorm:"type:varchar(11);comment:(消费/充值)金额;default:0;not null" json:"fee"`
	Balance    string `gorm:"type:varchar(11);comment:剩余余额;default:0;not null" json:"balance"`
	Remark     string `gorm:"type:varchar(255);comment:备注" json:"remark"`
	CreateAt   int64  `gorm:"type:int(11);not nul" json:"create_at"`
	CreateTime string `gorm:"-" json:"create_time"`
	paginate   cmfModel.Paginate
}

// 订单日志
func (model *RechargeLog) Save() error {

	if model.CreateAt == 0 {
		model.CreateAt = time.Now().Unix()
	}

	if tx := cmf.NewDb().Create(&model); tx.Error != nil {
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
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&log).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&log)
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
	cmf.NewDb().AutoMigrate(&model)
}
