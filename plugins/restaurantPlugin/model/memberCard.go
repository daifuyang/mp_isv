/**
** @创建时间: 2020/12/13 1:55 下午
** @作者　　: return
** @描述　　:
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

// 用户vip表
type MemberCard struct {
	Id        int    `json:"id"`
	Mid       int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	UserId    int    `gorm:"type:int(11);not null" json:"user_id"`
	VipNum    string `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	VipLevel  string `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	VipName   string `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	StartAt   int64  `gorm:"type:int(11);comment:起始时间;not null" json:"start_at"`
	EndAt     int64  `gorm:"type:int(11);comment:截止时间;not null" json:"end_at"`
	StartTime string `gorm:"-" json:"start_time"`
	EndTime   string `gorm:"-" json:"end_time"`
	CreateAt  int64  `gorm:"type:int(11);not null" json:"create_at"`
	UpdateAt  int64  `gorm:"type:int(11);not null" json:"update_at"`
	DeleteAt  int64  `gorm:"type:int(11);not null" json:"delete_at"`
	Status    int    `gorm:"type:tinyint(3);default:1;not null" json:"status"`
}

// 开卡订单
type MemberCardOrder struct {
	Id           int     `json:"id"`
	Mid          int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId      string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	VipNum       string  `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	TradeNo      string  `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	VipName      string  `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	VipLevel     string  `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	UserId       int     `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	PayType      string  `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee          float64 `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	CreateAt     int64   `gorm:"type:int(11)" json:"create_at"`
	FinishedAt   int64   `gorm:"type:int(11)" json:"finished_at"`
	CreateTime   string  `gorm:"-" json:"create_time"`
	FinishedTime string  `gorm:"-" json:"finished_time"`
	OrderStatus  string  `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	paginate     cmfModel.Paginate
}

func (model *MemberCard) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&MemberCardOrder{})

	cmf.NewDb().Exec("drop table if exists memberStatus")
	cmf.NewDb().Exec("CREATE EVENT memberStatus ON SCHEDULE EVERY 1 SECOND DO UPDATE cmf_member_card SET status = -1 WHERE end_at < UNIX_TIMESTAMP(NOW())")
}

func (model *MemberCard) Show(query []string, queryArgs []interface{}) (MemberCard, error) {

	mc := MemberCard{}
	queryStr := strings.Join(query, " AND ")
	tx := cmf.NewDb().Where(queryStr, queryArgs...).First(&mc)

	if tx.Error != nil {
		return mc, tx.Error
	}

	return mc, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取会员卡订单信息
 * @Date 2021/1/15 15:30:8
 * @Param
 * @return
 **/

func (model *MemberCardOrder) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var mco []MemberCardOrder

	cmf.NewDb().Where(queryStr, queryArgs...).Find(&mco).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&mco)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range mco {
		mco[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		mco[k].FinishedTime = time.Unix(v.FinishedAt, 0).Format("2006-01-02 15:04:05")
	}

	paginate := cmfModel.Paginate{Data: mco, Current: current, PageSize: pageSize, Total: total}
	if len(mco) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}
