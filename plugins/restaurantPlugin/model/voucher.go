/**
** @创建时间: 2020/12/11 1:09 下午
** @作者　　: return
** @描述　　: 优惠券列表
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

// 优惠券
type Voucher struct {
	Id                   int     `json:"id"`
	Mid                  int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
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

// 优惠券所属门店列表
type VoucherStorePost struct {
	Id        int   `json:"id"`
	VoucherId int   `gorm:"type:int(11);comment:魔板id;not null" json:"voucher_id"`
	StoreId   int   `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	CreateAt  int64 `gorm:"type:int(11);comment:创建时间;not null" json:"create_at"`
}

// 优惠券发放表
type VoucherPost struct {
	Id              int    `json:"id"`
	Mid             int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	VoucherId       int    `gorm:"type:int(11);comment:所属优惠券模板id;not null" json:"voucher_id"`
	VoucherType     int    `gorm:"type:tinyint(3);comment:优惠券类型(0 => 全场: 1=> 单品);not null" json:"voucher_type"`
	TemplateId      string `gorm:"-" json:"template_id,omitempty"`
	VoucherName     string `gorm:"-" json:"voucher_name,omitempty"`
	ValidStartAt    int64  `gorm:"type:int(11);comment:发放开始时间;not null" json:"valid_start_at"`
	ValidEndAt      int64  `gorm:"type:int(11);comment:有效截止时间;not null" json:"valid_end_at"`
	ValidStartTime  string `gorm:"-" json:"valid_start_time,omitempty"`
	ValidEndTime    string `gorm:"-" json:"valid_end_time,omitempty"`
	UserId          int    `gorm:"type:int(11);comment:所属人信息" json:"user_id"`
	AlipayVoucherId string `gorm:"type:varchar(28);comment:支付宝券id" json:"alipay_voucher_id"`
	CreateAt        int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt        int64  `gorm:"type:int(11)" json:"update_at"`
	CreateTime      string `gorm:"-" json:"create_time,omitempty"`
	UpdateTime      string `gorm:"-" json:"update_time,omitempty"`
	Status          int    `gorm:"type:tinyint(2);default:1;comment:状态;not null" json:"status"`
	paginate        cmfModel.Paginate
}

type VoucherResult struct {
	VoucherPost
	VoucherName          string  `gorm:"type:varchar(30);comment:优惠券名称，仅供商家可查看;not null" json:"voucher_name"`
	Type                 int     `gorm:"type:tinyint(2);default:0;comment:0.全场优惠券，1.单品优惠券;not null" json:"type"`
	VoucherType          string  `gorm:"type:varchar(64);comment:券类型，详见支付宝微信;not null" json:"voucher_type"`
	VoucherValidPeriod   string  `gorm:"type:json;comment:券有效期;not null" json:"voucher_valid_period"`
	VoucherAvailableTime string  `gorm:"type:json;comment:券可用时段;not null" json:"voucher_available_time"`
	VoucherDescription   string  `gorm:"type:json;comment:券使用说明;not null" json:"voucher_description"`
	VoucherQuantity      int     `gorm:"type:int(10);comment:拟发行券的数量。单位为张" json:"voucher_quantity"`
	Amount               float64 `gorm:"type:decimal(10,2);comment:面额。每张代金券可以抵扣的金额。币种为人民币，单位为元。" json:"amount"`
	TotalAmount          float64 `gorm:"type:decimal(12,2);comment:券总金额（仅用于不定额券）" json:"total_amount"`
	FloorAmount          float64 `gorm:"type:decimal(12,2);comment:最低额度。设置券使用门槛，只有订单金额大于等于最低额度时券才能使用。" json:"floor_amount"`
	TemplateId           string  `gorm:"type:varchar(28);comment:模板ID;" json:"template_id"`
	SyncToAlipay         int     `gorm:"type:tinyint(2);default:0;comment:同步到支付宝卡包;not null" json:"sync_to_alipay"`
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
	cmf.NewDb().AutoMigrate(&VoucherStorePost{})
	cmf.NewDb().AutoMigrate(&VoucherPost{})
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

		voucher[k].CreateTime = time.Unix(v.CreateAt, 0).Format(layout)
		voucher[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(layout)
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

// app用户优惠券列表
func (model *VoucherPost) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var voucherResult []VoucherResult

	prefix := cmf.Conf().Database.Prefix

	cmf.NewDb().Table(prefix+"voucher_post p").Select("p.*,v.voucher_name,v.type,v.amount,v.total_amount,v.floor_amount,v.sync_to_alipay").
		Joins("INNER JOIN "+prefix+"voucher v ON v.id = p.voucher_id").
		Where(queryStr, queryArgs...).Count(&total)

	tx := cmf.NewDb().Table(prefix+"voucher_post p").Select("p.*,v.voucher_name,v.type,v.amount,v.total_amount,v.floor_amount,v.sync_to_alipay").
		Joins("INNER JOIN "+prefix+"voucher v ON v.id = p.voucher_id").
		Where(queryStr, queryArgs...).Scan(&voucherResult)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range voucherResult {
		voucherResult[k].ValidStartTime = time.Unix(v.ValidStartAt, 0).Format(data.TimeLayout)
		voucherResult[k].ValidEndTime = time.Unix(v.ValidEndAt, 0).Format(data.TimeLayout)
		voucherResult[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		voucherResult[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(data.TimeLayout)
	}

	paginate := cmfModel.Paginate{Data: voucherResult, Current: current, PageSize: pageSize, Total: total}
	if len(voucherResult) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

// 获取个人优惠券详情
func (model *VoucherPost) Show(query []string, queryArgs []interface{}) (VoucherResult, error) {

	queryStr := strings.Join(query, " AND ")

	var voucherResult VoucherResult
	prefix := cmf.Conf().Database.Prefix
	tx := cmf.NewDb().Table(prefix+"voucher_post p").Select("p.*,v.voucher_name,v.type,v.amount,v.total_amount,v.floor_amount,v.sync_to_alipay").
		Joins("INNER JOIN "+prefix+"voucher v ON v.id = p.voucher_id").
		Where(queryStr, queryArgs...).Scan(&voucherResult)

	if tx.Error != nil {
		return voucherResult, tx.Error
	}

	return voucherResult, nil

}

func (model *Voucher) Send(templateId string, openId string, voucherName string) marketing.VoucherSendResponse {
	nowUnix := time.Now().Unix()
	outNo := strconv.FormatInt(nowUnix, 10)
	bizContent := make(map[string]interface{}, 0)
	bizContent["template_id"] = templateId
	bizContent["user_id"] = openId
	bizContent["out_biz_no"] = outNo
	bizContent["memo"] = voucherName
	result := new(marketing.CashlessVoucher).Send(bizContent)
	return result
}

func (model *VoucherStorePost) Store(storeIds []string) error {

	// 1,2,3 => 4,5
	voucherId := model.VoucherId
	// 获取源库拥有的
	var storePost []VoucherStorePost
	tx := cmf.NewDb().Where("voucher_id = ?", voucherId).Find(&storePost)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return tx.Error
	}

	// 遍历存在的优惠券，查找需要添加的
	var addPost []VoucherStorePost
	for _, v := range storeIds {
		storeId, _ := strconv.Atoi(v)
		if !model.inStoreArray(storeId, storePost) || len(storePost) == 0 {
			addPost = append(addPost, VoucherStorePost{
				VoucherId: voucherId,
				StoreId:   storeId,
				CreateAt:  time.Now().Unix(),
			})
		}
	}

	// 添加待添加的
	tx = cmf.NewDb().Create(&addPost)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return tx.Error
	}
	return nil

}

func (model *VoucherStorePost) inStoreArray(storeId int, stores []VoucherStorePost) bool {
	for _, v := range stores {
		if storeId == v.StoreId {
			return true
		}
	}
	return false
}
