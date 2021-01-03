/**
** @创建时间: 2020/12/18 8:58 下午
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

// 充值订单支付状态
type RechargeOrder struct {
	Id           int               `json:"id"`
	Mid          int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId      string            `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo      string            `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	UserId       int               `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	PayType      string            `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee          float64           `gorm:"type:decimal(7,2);comment:支付金额;default:0;not null" json:"fee"`
	ActualFee    float64           `gorm:"type:decimal(7,2);comment:实际金额;default:0;not null" json:"actual_fee"`
	SendFee      float64           `gorm:"type:decimal(7,2);comment:赠送金额;default:0;not null" json:"send_fee"`
	CreateAt     int64             `gorm:"type:int(11)" json:"create_at"`
	FinishedAt   int64             `gorm:"type:int(11)" json:"finished_at"`
	CreateTime   string            `gorm:"-" json:"create_time"`
	FinishedTime string            `gorm:"-" json:"finished_time"`
	OrderStatus  string            `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	paginate     cmfModel.Paginate `gorm:"-"`
}

func (model *RechargeOrder) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}

func (model *RechargeOrder) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var ro []RechargeOrder
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&ro).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&ro)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range ro {
		ro[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		ro[k].FinishedTime = time.Unix(v.FinishedAt, 0).Format(data.TimeLayout)
	}

	paginate := cmfModel.Paginate{Data: ro, Current: current, PageSize: pageSize, Total: total}
	if len(ro) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}
