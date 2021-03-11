/**
** @创建时间: 2020/11/28 8:41 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"fmt"
	isvModel "gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type FoodOrder struct {
	Id              int               `json:"id"`
	Mid             int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId         string            `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo         string            `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	QueueNo         string            `gorm:"type:varchar(10);comment:取餐队列号;not null" json:"queue_no"`
	PayType         string            `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	StoreId         int               `gorm:"type:int(11);comment:所属门店id;not null" json:"store_id"`
	StoreName       string            `gorm:"->" json:"store_name"`
	StoreNumber     string            `gorm:"->" json:"store_number,omitempty"`
	Longitude       float64           `gorm:"->" json:"longitude,omitempty"`
	Latitude        float64           `gorm:"->" json:"latitude,omitempty"`
	StoreProvince   string            `gorm:"->" json:"store_province,omitempty"`
	StoreCity       string            `gorm:"->" json:"store_city,omitempty"`
	StoreDistrict   string            `gorm:"->" json:"store_district,omitempty"`
	StoreAddress    string            `gorm:"->" json:"store_address,omitempty"`
	StorePhone      string            `gorm:"->" json:"store_phone,omitempty"`
	OrderType       int               `gorm:"type:tinyint(3);comment:订单类型（1 => 门店扫码就餐; 2 => 门店堂食就餐; 3 => 门店打包外带; 4 => 外卖;not null" json:"order_type"`
	AppointmentTime string            `gorm:"type:varchar(20);comment:预约取餐时间" json:"appointment_time"`
	OrderDetail     string            `gorm:"type:json;comment:订单详情;not null" json:"order_detail"`
	FoodDetail      []FoodOrderDetail `gorm:"-" json:"food_detail"`
	FoodCount       int               `gorm:"-" json:"food_count"`
	BoxFee          float64           `gorm:"type:decimal(3,2);comment:餐盒费;default:0;not null" json:"box_fee"`
	DeliveryFee     float64           `gorm:"type:decimal(3,2);comment:配送费;default:0;not null" json:"delivery_fee"`
	CouponFee       float64           `gorm:"type:decimal(7,2);comment:优惠金额;default:0;not null" json:"coupon_fee"`
	VoucherId       int               `gorm:"type:int(11);comment:优惠券id" json:"voucher_id"`
	Remark          string            `gorm:"type:varchar(255);comment:备注" json:"remark"`
	Fee             float64           `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	TotalAmount     float64           `gorm:"-" json:"total_amount"`
	DeskId          int               `gorm:"type:int(11);comment:桌号id" json:"desk_id"`
	DeskName        string            `gorm:"type:varchar(40);comment:桌位名称详情" json:"desk_name"`
	UserId          int               `gorm:"type:int(11);comment:下单人信息" json:"user_id"`
	Name            string            `gorm:"type:varchar(20);comment:用户预留姓名" json:"name"`
	Mobile          string            `gorm:"type:varchar(11);comment:用户预留手机号;not null" json:"mobile"`
	Address         string            `gorm:"type:varchar(255);comment:用户预留收货地址" json:"address"`
	AddressId       int               `gorm:"type:int(11);comment:选择地址id" json:"address_id"`
	CreateAt        int64             `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt      int64             `gorm:"type:int(11)" json:"finished_at"`
	CreateTime      string            `gorm:"-" json:"create_time"`
	FinishedTime    string            `gorm:"-" json:"finished_time"`
	TotalCount      int               `gorm:"-" json:"total_count"`
	OrderStatus     string            `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	paginate        cmfModel.Paginate `gorm:"-"`
}

// 定单明细表
type FoodOrderDetail struct {
	Id                int     `json:"id"`
	Code              string  `gorm:"type:varchar(32);comment:菜品唯一编号;not null" json:"code"`
	OrderId           string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	FoodId            int     `gorm:"type:int(11);comment:所属食物id;not null" json:"food_id"`
	FoodThumbnail     string  `gorm:"type:varchar(255);comment:菜品缩略图;not null" json:"food_thumbnail"`
	FoodThumbnailPrev string  `gorm:"-" json:"food_thumbnail_prev"`
	AlipayMaterialId  string  `gorm:"type:varchar(256);comment:阿里素材标识;not null" json:"alipay_material_id"`
	FoodName          string  `gorm:"type:varchar(255);comment:菜品名称;not null" json:"food_name"`
	SkuId             int     `gorm:"type:int(11);comment:所属食物规格id;not null" json:"sku_id"`
	SkuDetail         string  `gorm:"type:varchar(255);comment:规格详情;not null" json:"sku_detail"`
	FoodRemark        string  `gorm:"type:varchar(255);comment:最终拼接详情;not null" json:"food_remark"`
	UseMember         int     `gorm:"type:tinyint(3);comment:是否启用菜品会员价;not null" json:"use_member"`
	MemberPrice       float64 `gorm:"type:decimal(9,2);comment:菜品会员价;not null" json:"member_price"`
	Count             int     `gorm:"type:int(11);comment:购买数量;not null" json:"count"`
	Material          string  `gorm:"type:json;comment:加料;not null" json:"material"`
	Tasty             string  `gorm:"type:json;comment:口味;not null" json:"tasty"`
	DishType          string  `gorm:"type:varchar(40);comment:菜品类型;" json:"dish_type"`
	Flavor            string  `gorm:"type:varchar(40);comment:菜品口味;" json:"flavor"`
	CookingMethod     string  `gorm:"type:varchar(40);comment:菜品做法;" json:"cooking_method"`
	Price             float64 `gorm:"type:decimal(9,2);comment:菜品单价;not null" json:"price"`
	Total             float64 `gorm:"type:decimal(9,2);comment:菜品总价;not null" json:"total"`
	BoxFee            float64 `gorm:"type:decimal(9,2);comment:餐盒费;not null" json:"box_fee"`
}

func (model *FoodOrder) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&FoodOrderDetail{})

	prefix := cmf.Conf().Database.Prefix

	cmf.NewDb().Exec("drop event if exists orderCloseStatus")
	cmf.NewDb().Exec("drop event if exists orderFinishStatus")

	// 超时未支付和订单自动完成
	sql := "CREATE EVENT orderCloseStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600;"
	cmf.NewDb().Exec(sql)

	sql = "CREATE EVENT orderFinishStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > create_at + 43200;"
	cmf.NewDb().Exec(sql)

}

func (model FoodOrder) IndexByStore(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	queryStr := strings.Join(query, " AND ")
	var fo []FoodOrder

	prefix := cmf.Conf().Database.Prefix
	var total int64 = 0

	cmf.NewDb().Table(prefix+"food_order fo").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Order("fo.id desc").Count(&total)

	result := cmf.NewDb().Table(prefix+"food_order fo").Select("fo.*,s.store_name,l.total_amount").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("fo.id desc").Scan(&fo)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	for k, v := range fo {

		count := 0
		fo[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		fo[k].FinishedTime = time.Unix(v.FinishedAt, 0).Format(data.TimeLayout)

		var fod []FoodOrderDetail
		tx := cmf.NewDb().Where("order_id = ?", v.OrderId).Find(&fod)
		if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			return cmfModel.Paginate{}, result.Error
		}

		for dk, dv := range fod {

			if dv.FoodThumbnail == "" {
				dv.FoodThumbnail = "template/food.png"
			}

			fod[dk].FoodThumbnailPrev = util.GetFileUrl(dv.FoodThumbnail)
			count = count + dv.Count
		}

		fo[k].FoodDetail = fod
		fo[k].FoodCount = len(fod)
		fo[k].TotalCount = count
	}

	paginate := cmfModel.Paginate{Data: fo, Current: current, PageSize: pageSize, Total: total}
	if len(fo) == 0 {
		paginate.Data = make([]FoodOrder, 0)
	}

	return paginate, nil

}

func (model FoodOrder) ShowByStore(query []string, queryArgs []interface{}) (FoodOrder, error) {

	queryStr := strings.Join(query, " AND ")
	var fo FoodOrder

	prefix := cmf.Conf().Database.Prefix

	result := cmf.NewDb().Table(prefix+"food_order fo").Select("fo.*,s.store_name,s.store_number,s.longitude,s.latitude,s.province_name as store_province,s.city_name as store_city,s.district_name as store_district,s.address as store_address,s.phone as store_phone,l.total_amount").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Scan(&fo)

	if result.Error != nil {
		return fo, result.Error
	}

	if result.RowsAffected <= 0 {
		return fo, errors.New("该订单不存在！")
	}

	count := 0
	fo.CreateTime = time.Unix(fo.CreateAt, 0).Format(data.TimeLayout)
	var fod []FoodOrderDetail
	tx := cmf.NewDb().Where("order_id", fo.OrderId).Find(&fod)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return fo, result.Error
	}

	for dk, dv := range fod {

		if dv.FoodThumbnail == "" {
			dv.FoodThumbnail = "template/food.png"
		}

		fod[dk].FoodThumbnailPrev = util.GetFileUrl(dv.FoodThumbnail)
		count = count + dv.Count
	}

	fo.FoodDetail = fod
	fo.TotalCount = count

	return fo, nil

}

func (model FoodOrder) ByStore(current int, pageSize int, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	queryStr := strings.Join(query, " AND ")
	var fo []FoodOrder

	prefix := cmf.Conf().Database.Prefix
	var total int64 = 0

	cmf.NewDb().Table(prefix+"food_order fo").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Order("fo.id desc").Count(&total)

	result := cmf.NewDb().Table(prefix+"food_order fo").Select("fo.*,s.store_name,l.total_amount").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("fo.id desc").Scan(&fo)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	paginate := cmfModel.Paginate{Data: fo, Current: current, PageSize: pageSize, Total: total}
	if len(fo) == 0 {
		paginate.Data = make([]FoodOrder, 0)
	}

	return paginate, nil

}

func (model FoodOrder) List(query []string, queryArgs []interface{}) ([]FoodOrder, error) {

	queryStr := strings.Join(query, " AND ")
	var fd []FoodOrder
	result := cmf.NewDb().Where(queryStr, queryArgs...).Find(&fd)
	if result.Error != nil {
		return fd, result.Error
	}
	return fd, nil

}

func (model FoodOrder) Show(query []string, queryArgs []interface{}) (FoodOrder, error) {

	queryStr := strings.Join(query, " AND ")
	fd := FoodOrder{}
	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&fd)
	if result.Error != nil {
		return fd, result.Error
	}
	return fd, nil

}

func (model FoodOrder) Store() (FoodOrder, error) {

	o, err := model.Show([]string{"order_id = ?"}, []interface{}{model.OrderId})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return o, err
	}

	// 不存在
	if o.OrderId != "" {
		return o, errors.New("该订单已经存在，无需重复添加！")
	}

	result := cmf.NewDb().Create(&model)
	if result.Error != nil {
		return o, result.Error
	}

	return model, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 确认订单
 * @Date 2020/12/5 22:11:4
 * @Param
 * @return
 **/
func (model FoodOrder) Confirm(query []string, queryArgs []interface{}) error {

	data, err := model.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("订单不存在！")
		}
	}

	/*
	 判断当前订单状态
	 WAIT_BUYER_PAY => 用户未支付
	 TRADE_SUCCESS => 可以完成
	 TRADE_FINISHED => 订单状态已完成，无需重复完成
	 TRADE_CLOSED => 订单已关闭
	 TRADE_REFUND => 订单已经退款
	*/
	err = errors.New("订单状态非法！")
	switch data.OrderStatus {
	case "WAIT_BUYER_PAY":
		err = errors.New("用户未支付，无法确认订单！")
	case "TRADE_SUCCESS":
		result := cmf.NewDb().Model(&model).Where("order_id = ?", data.OrderId).Update("order_status", "TRADE_FINISHED")
		if result.Error != nil {
			err = errors.New(result.Error.Error())
		}
		err = nil
	case "TRADE_FINISHED":
		err = errors.New("该订单已完成，无法确认订单！")
	case "TRADE_CLOSED":
		err = errors.New("该订单已关闭，无法确认订单！")
	case "TRADE_REFUND":
		err = errors.New("该订单已退款，无法确认订单！")
	}

	return err

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 作废订单
 * @Date 2020/12/5 22:18:23
 * @Param
 * @return
 **/

func (model FoodOrder) Cancel(query []string, queryArgs []interface{}, appId string) error {

	data, err := model.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("订单不存在！")
		}
	}

	/*
	 判断当前订单状态
	 WAIT_BUYER_PAY => 用户未支付
	 TRADE_SUCCESS => 可以完成
	 TRADE_FINISHED => 订单状态已完成，无需重复完成
	 TRADE_CLOSED => 订单已关闭
	 TRADE_REFUND => 订单已经退款
	*/
	err = errors.New("订单状态非法！")
	switch data.OrderStatus {
	case "WAIT_BUYER_PAY":
		err = errors.New("用户未支付，无需取消订单！")
	case "TRADE_SUCCESS":
		// 进行退款逻辑
		// 查询pay_log的退款金额

		payLog := isvModel.PayLog{}
		result := cmf.NewDb().Where("order_id = ?", data.OrderId).First(&payLog)
		if result.Error != nil {
			if errors.Is(result.Error, gorm.ErrRecordNotFound) {
				return errors.New("订单支付日志不存在！")
			}
			return result.Error
		}

		common := payment.Common{}
		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = data.OrderId
		bizContent["refund_amount"] = payLog.ReceiptAmount
		bizContent["refund_currency"] = "CNY"
		rResult := common.Refund(bizContent)

		fmt.Println(result)

		if rResult.Response.Code == "10000" {
			result := cmf.NewDb().Model(&model).Where("order_id = ?", data.OrderId).Update("order_status", "TRADE_REFUND")
			if result.Error != nil {
				err = errors.New(result.Error.Error())
			}

			// 退款记录到payLog中
			payLog = isvModel.PayLog{
				OrderId:      data.OrderId,
				TradeNo:      data.TradeNo,
				Type:         "alipay",
				AppId:        appId,
				BuyerId:      "",
				FundBillList: "{}",
				TradeStatus:  "TRADE_REFUND",
				RefundFee:    payLog.ReceiptAmount,
				SendBackFee:  payLog.ReceiptAmount,
				GmtRefund:    time.Now().Unix(),
			}

			cmf.NewDb().Debug().Create(&payLog)

			err = nil
		} else {
			err = errors.New(rResult.Response.SubMsg)
		}

	case "TRADE_FINISHED":
		err = errors.New("该订单已完成，无需取消订单！")
	case "TRADE_CLOSED":
		err = errors.New("该订单已关闭，无需取消订单！")
	case "TRADE_REFUND":
		err = errors.New("该订单已退款，无需取消订单！")
	}
	return err

}
