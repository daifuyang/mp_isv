/**
** @创建时间: 2020/12/11 1:09 下午
** @作者　　: return
** @描述　　: 优惠券列表
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type Voucher struct {
	Id                   int     `json:"id"`
	VoucherName          string  `gorm:"type:varchar(30);comment:优惠券名称，仅供商家可查看;not null" json:"voucher_name"`
	Type                 int     `gorm:"type:tinyint(2);default:0;comment:0.全场优惠券，1.单品优惠券;not null" json:"type"`
	VoucherType          string  `gorm:"type:varchar(64);comment:券类型，详见支付宝微信;not null" json:"voucher_type"`
	PublishStartTime     string  `gorm:"type:datetime;comment:发放开始时间;not null" json:"publish_start_time"`
	PublishEndTime       string  `gorm:"type:datetime;comment:发放结束时间;not null" json:"publish_end_time"`
	VoucherValidPeriod   string  `gorm:"type:json;comment:券有效期;not null" json:"voucher_valid_period"`
	VoucherAvailableTime string  `gorm:"type:json;comment:券可用时段;not null" json:"voucher_available_time"`
	VoucherDescription   string  `gorm:"type:json;comment:券使用说明;not null" json:"voucher_description"`
	VoucherQuantity      int     `gorm:"type:int(10);comment:拟发行券的数量。单位为张" json:"voucher_quantity"`
	Amount               float64 `gorm:"type:decimal(10,2);comment:面额。每张代金券可以抵扣的金额。币种为人民币，单位为元。" json:"amount"`
	TotalAmount          float64 `gorm:"type:decimal(12,2);comment:券总金额（仅用于不定额券）" json:"total_amount"`
	FloorAmount          float64 `gorm:"type:decimal(12,2);comment:最低额度。设置券使用门槛，只有订单金额大于等于最低额度时券才能使用。" json:"floor_amount"`
	CreateAt             int64   `gorm:"type:int(11)" json:"create_at"`
	UpdateAt             int64   `gorm:"type:int(11)" json:"update_at"`
	DeleteAt             int64   `gorm:"type:int(10);comment:'删除时间';default:0" json:"delete_at"`
	CreateTime           string  `gorm:"-" json:"create_time"`
	UpdateTime           string  `gorm:"-" json:"update_time"`
	TemplateId           string  `gorm:"type:varchar(28);comment:模板ID;" json:"template_id"`
	SyncToAlipay         int     `gorm:"type:tinyint(2);default:0;comment:同步到支付宝卡包;not null" json:"sync_to_alipay"`
	Status               int     `gorm:"type:tinyint(2);default:1;comment:状态;not null" json:"status"`
	paginate             cmfModel.Paginate
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/11/2 11:28:13
 * @Param
 * @return
 **/
func (model *Voucher) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2020/12/11 21:39:26
 * @Param
 * @return
 **/
func (model *Voucher) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var voucher []Voucher
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&voucher).Count(&total)
	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&voucher)

	const layout = "2006-01-02 15:04:05"
	for k, v := range voucher {

		pstUnix, _ := time.Parse("2006-01-02T15:04:05+08:00", v.PublishStartTime)

		publishStartTime := pstUnix.Format(layout)

		voucher[k].PublishStartTime = publishStartTime

		petUnix, _ := time.Parse("2006-01-02T15:04:05+08:00", v.PublishEndTime)
		publishEndTime := petUnix.Format(layout)
		voucher[k].PublishEndTime = publishEndTime

		voucher[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		voucher[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	paginate := cmfModel.Paginate{Data: voucher, Current: current, PageSize: pageSize, Total: total}
	if len(voucher) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取单张卡券
 * @Date 2020/12/11 21:4:8
 * @Param
 * @return
 **/

func (model *Voucher) Show(query []string, queryArgs []interface{}) (Voucher, error) {

	v := Voucher{}
	queryStr := strings.Join(query, " AND ")

	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&v)

	const layout = "2006-01-02 15:04:05"
	pstUnix, _ := time.Parse("2006-01-02T15:04:05+08:00", v.PublishStartTime)
	publishStartTime := pstUnix.Format(layout)
	v.PublishStartTime = publishStartTime

	petUnix, _ := time.Parse("2006-01-02T15:04:05+08:00", v.PublishEndTime)
	publishEndTime := petUnix.Format(layout)
	v.PublishEndTime = publishEndTime

	v.CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
	v.UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")

	if result.Error != nil {
		return v, result.Error
	}

	return v, nil

}
