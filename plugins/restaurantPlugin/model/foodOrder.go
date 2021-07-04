/**
** @创建时间: 2020/11/28 8:41 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	printerPlugin "gincmf/plugins/printerPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	wechatModel "gincmf/plugins/wechatPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/gincmf/feieSdk/base"
	wechatEasySdkOpen "github.com/gincmf/wechatEasySdk/open"
	"github.com/gincmf/wechatEasySdk/pay"
	wechatUtil "github.com/gincmf/wechatEasySdk/util"
	xpyunYun "github.com/gincmf/xpyunSdk/base"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
	"math"
	"strconv"
	"strings"
	"time"
)

type FoodOrder struct {
	Id              int                        `json:"id"`
	Mid             int                        `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId         string                     `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo         string                     `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	QueueNo         string                     `gorm:"type:varchar(10);comment:取餐队列号;not null" json:"queue_no"`
	PayType         string                     `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	StoreId         int                        `gorm:"type:int(11);comment:所属门店id;not null" json:"store_id"`
	FormId          string                     `gorm:"type:varchar(64);comment:支付宝推送formId;not null" json:"form_id"`
	StoreName       string                     `gorm:"->" json:"store_name"`
	StoreNumber     string                     `gorm:"->" json:"store_number,omitempty"`
	Longitude       float64                    `gorm:"->" json:"longitude,omitempty"`
	Latitude        float64                    `gorm:"->" json:"latitude,omitempty"`
	StoreProvince   string                     `gorm:"->" json:"store_province,omitempty"`
	StoreCity       string                     `gorm:"->" json:"store_city,omitempty"`
	StoreDistrict   string                     `gorm:"->" json:"store_district,omitempty"`
	StoreAddress    string                     `gorm:"->" json:"store_address,omitempty"`
	StorePhone      string                     `gorm:"->" json:"store_phone,omitempty"`
	OrderType       int                        `gorm:"type:tinyint(3);comment:订单类型（1 => 门店扫码就餐; 2 => 门店堂食就餐; 3 => 门店打包外带; 4 => 外卖;not null" json:"order_type"`
	AppointmentTime string                     `gorm:"->" json:"appointment_time"`
	AppointmentAt   int64                      `gorm:"type:bigint(20);comment:预约取餐时间" json:"appointment_at"`
	AppointmentType int64                      `gorm:"type:tinyint(3);comment:是否预约单" json:"appointment_type"`
	OrderDetail     string                     `gorm:"type:json;comment:订单详情;not null" json:"order_detail"`
	FoodDetail      []FoodOrderDetail          `gorm:"-" json:"food_detail"`
	FoodCount       int                        `gorm:"-" json:"food_count"`
	BoxFee          float64                    `gorm:"type:decimal(3,2);comment:餐盒费;default:0;not null" json:"box_fee"`
	DeliveryFee     float64                    `gorm:"type:decimal(3,2);comment:配送费;default:0;not null" json:"delivery_fee"`
	CouponFee       float64                    `gorm:"type:decimal(7,2);comment:优惠金额;default:0;not null" json:"coupon_fee"`
	VoucherId       int                        `gorm:"type:int(11);comment:优惠券id" json:"voucher_id"`
	Remark          string                     `gorm:"type:varchar(255);comment:备注" json:"remark"`
	Fee             float64                    `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	OriginalFee     float64                    `gorm:"type:decimal(7,2);comment:原价金额;default:0;not null" json:"original_fee"`
	RefundFee       float64                    `gorm:"type:decimal(7,2);comment:剩余可退金额;default:0;not null" json:"refund_fee"`
	TotalAmount     float64                    `gorm:"->" json:"total_amount"`
	BuyerPayAmount  float64                    `gorm:"->" json:"buyer_pay_amount"`
	DeskId          int                        `gorm:"type:int(11);comment:桌号id" json:"desk_id"`
	DeskName        string                     `gorm:"type:varchar(40);comment:桌位名称详情" json:"desk_name"`
	UserId          int                        `gorm:"type:bigint(20);comment:下单人信息" json:"user_id"`
	Name            string                     `gorm:"type:varchar(20);comment:用户预留姓名" json:"name"`
	Mobile          string                     `gorm:"type:varchar(11);comment:用户预留手机号;not null" json:"mobile"`
	Address         string                     `gorm:"type:varchar(255);comment:用户预留收货地址" json:"address"`
	AddressId       int                        `gorm:"type:int(11);comment:选择地址id" json:"address_id"`
	CreateAt        int64                      `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt      int64                      `gorm:"type:int(11)" json:"finished_at"`
	CreateTime      string                     `gorm:"-" json:"create_time"`
	FinishedTime    string                     `gorm:"-" json:"finished_time"`
	TotalCount      int                        `gorm:"-" json:"total_count"`
	OrderStatus     string                     `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用/已支付，TRADE_FINISHED=> 已完成，TRADE_REFUSED => 已拒绝，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	DeliveryStatus  string                     `gorm:"type:varchar(20);comment:运输状态（TRADE_RECEIVED => 已接单，TRADE_DELIVERY => 运输中" json:"delivery_status"`
	paginate        cmfModel.Paginate          `gorm:"-"`
	Call            string                     `gorm:"-" json:"call"`
	Db              *gorm.DB                   `gorm:"-" json:"-"`
	AppId           string                     `gorm:"-" json:"app_id"`
	RequestPayment  wechatModel.RequestPayment `gorm:"-" json:"request_payment"`
	OpenId          string                     `gorm:"-" json:"open_id"`
	AccessToken     string                     `gorm:"-" json:"access_token"`
	GoodsWeight     float64                    `gorm:"-" json:"goods_weight"`
	DeliveryToken   string                     `gorm:"-" json:"delivery_token"`
	DeliveryId      string                     `gorm:"-" json:"delivery_id"`
	DeliveryName    string                     `gorm:"-" json:"delivery_name"`
	DeliveryFree    float64                    `gorm:"-" json:"delivery_free"`
	ShopOrderId     string                     `gorm:"-" json:"shop_order_id"`
}

// 退款明细
type FoodOrderRefund struct {
	Id      int     `json:"id"`
	Mid     int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	Fee     float64 `gorm:"type:decimal(7,2);comment:退款金额;default:0;not null" json:"fee"`
	Reason  string  `gorm:"type:varchar(255);comment:退款理由" json:"reason"`
}

// 定单明细表
type FoodOrderDetail struct {
	Id                int     `json:"id"`
	Code              string  `gorm:"type:varchar(32);comment:菜品唯一编号;not null" json:"code"`
	OrderId           string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	FoodId            int     `gorm:"type:int(11);comment:所属食物id;not null" json:"food_id"`
	Food              Food    `gorm:"-" json:"food"`
	CategoryId        int     `gorm:"-" json:"category_id"`
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

type tasty struct {
	AttrKey   string `json:"attr_key"`
	AttrValue string `json:"attr_value"`
}

type material struct {
	Id            int     `json:"id,omitempty"`
	Count         int     `json:"count,omitempty"`
	MaterialName  string  `json:"material_name,omitempty"`
	MaterialPrice float64 `json:"material_price,omitempty"`
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

	result := cmf.NewDb().Table(prefix+"food_order fo").Select("fo.*,s.store_name,l.total_amount,buyer_pay_amount").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).
		Order("case WHEN fo.order_status = 'TRADE_SUCCESS' then 1 WHEN fo.order_status = 'TRADE_SUCCESS' then 1 else 99 end asc, appointment_at desc, fo.id desc").Scan(&fo)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	domain := cmf.Conf().App.Domain

	appId, exist := c.Get("app_id")

	for k, v := range fo {
		if exist {
			appIdStr := appId.(string)
			if v.PayType == "wxpay" {
				fo[k].RequestPayment.AppId = appIdStr
				fo[k].RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
				fo[k].RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
				fo[k].RequestPayment.Package = "prepay_id=" + v.TradeNo
				fo[k].RequestPayment.SignType = "RSA"
			}

			encryptData := []string{
				fo[k].RequestPayment.AppId,
				fo[k].RequestPayment.TimeStamp,
				fo[k].RequestPayment.NonceStr,
				fo[k].RequestPayment.Package,
			}

			signature := wechatUtil.Sign(encryptData)
			fo[k].RequestPayment.PaySign = signature
		}

		fo[k].Call = domain + "/call/" + v.Mobile

		count := 0
		fo[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		fo[k].AppointmentTime = time.Unix(v.AppointmentAt, 0).Format(data.TimeLayout)
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

			fcp := FoodCategoryPost{}
			cmf.NewDb().Where("food_id = ?", dv.FoodId).First(&fcp)
			categoryId := fcp.FoodCategoryId

			food := Food{}
			cmf.NewDb().Where("food_id = ?", dv.FoodId).First(&food)

			fod[dk].CategoryId = categoryId
			fod[dk].Food = food

			fod[dk].FoodThumbnailPrev = util.GetFileUrl(dv.FoodThumbnail, "thumbnail500x500")
			count = count + dv.Count

			var material []material
			json.Unmarshal([]byte(dv.Material), &material)

			// 增加加料描述
			materialRemark := ""
			for _, item := range material {
				materialRemark += item.MaterialName + "|"
			}

			var tasty []tasty
			json.Unmarshal([]byte(dv.Tasty), &tasty)

			tastyRemark := ""

			for _, item := range tasty {
				tastyRemark += item.AttrValue + "|"
			}

			title := dv.FoodName

			if dv.SkuDetail != "" {
				title += "-" + dv.SkuDetail
			}

			remark := materialRemark + tastyRemark

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			if remark != "" {
				title += "-" + remark
			}

			fod[dk].FoodName = title

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

func (model FoodOrder) AppIndexByStore(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

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

	result := cmf.NewDb().Table(prefix+"food_order fo").Select("fo.*,s.store_name,l.total_amount,buyer_pay_amount").
		Joins("INNER JOIN "+prefix+"store s ON s.id = fo.store_id").
		Joins("LEFT JOIN "+prefix+"pay_log l ON l.order_id = fo.order_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).
		Order("case WHEN fo.order_status = 'WAIT_BUYER_PAY' then 1 WHEN fo.order_status = 'WAIT_BUYER_PAY' then 1 else 99 end asc, appointment_at desc, fo.id desc").Scan(&fo)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	domain := cmf.Conf().App.Domain

	appId, exist := c.Get("app_id")

	for k, v := range fo {
		if exist {
			appIdStr := appId.(string)
			if v.PayType == "wxpay" {
				fo[k].RequestPayment.AppId = appIdStr
				fo[k].RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
				fo[k].RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
				fo[k].RequestPayment.Package = "prepay_id=" + v.TradeNo
				fo[k].RequestPayment.SignType = "RSA"
			}

			encryptData := []string{
				fo[k].RequestPayment.AppId,
				fo[k].RequestPayment.TimeStamp,
				fo[k].RequestPayment.NonceStr,
				fo[k].RequestPayment.Package,
			}

			signature := wechatUtil.Sign(encryptData)
			fo[k].RequestPayment.PaySign = signature
		}

		fo[k].Call = domain + "/call/" + v.Mobile

		count := 0
		fo[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		fo[k].AppointmentTime = time.Unix(v.AppointmentAt, 0).Format(data.TimeLayout)
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

			fcp := FoodCategoryPost{}
			cmf.NewDb().Where("food_id = ?", dv.FoodId).First(&fcp)
			categoryId := fcp.FoodCategoryId

			food := Food{}
			cmf.NewDb().Where("food_id = ?", dv.FoodId).First(&food)

			fod[dk].CategoryId = categoryId
			fod[dk].Food = food

			fod[dk].FoodThumbnailPrev = util.GetFileUrl(dv.FoodThumbnail, "thumbnail500x500")
			count = count + dv.Count

			var material []material
			json.Unmarshal([]byte(dv.Material), &material)

			// 增加加料描述
			materialRemark := ""
			for _, item := range material {
				materialRemark += item.MaterialName + "|"
			}

			var tasty []tasty
			json.Unmarshal([]byte(dv.Tasty), &tasty)

			tastyRemark := ""

			for _, item := range tasty {
				tastyRemark += item.AttrValue + "|"
			}

			title := dv.FoodName

			if dv.SkuDetail != "" {
				title += "-" + dv.SkuDetail
			}

			remark := materialRemark + tastyRemark

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			if remark != "" {
				title += "-" + remark
			}

			fod[dk].FoodName = title

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
	fo.AppointmentTime = time.Unix(fo.AppointmentAt, 0).Format(data.TimeLayout)
	fo.CreateTime = time.Unix(fo.CreateAt, 0).Format(data.TimeLayout)
	var fod []FoodOrderDetail
	tx := cmf.NewDb().Where("order_id", fo.OrderId).Find(&fod)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return fo, result.Error
	}

	domain := cmf.Conf().App.Domain
	fo.Call = domain + "/call/" + fo.Mobile

	for dk, dv := range fod {

		fcp := FoodCategoryPost{}
		cmf.NewDb().Where("food_id = ?", dv.FoodId).First(&fcp)
		categoryId := fcp.FoodCategoryId

		food := Food{}
		cmf.NewDb().Where("id = ?", dv.FoodId).First(&food)
		food.PrevPath = util.GetFileUrl(food.Thumbnail, "thumbnail500x500")

		fod[dk].CategoryId = categoryId
		fod[dk].Food = food

		if dv.FoodThumbnail == "" {
			dv.FoodThumbnail = "template/food.png"
		}

		fod[dk].FoodThumbnailPrev = util.GetFileUrl(dv.FoodThumbnail, "thumbnail500x500")
		count = count + dv.Count

		var material []material
		json.Unmarshal([]byte(dv.Material), &material)

		// 增加加料描述
		materialRemark := ""
		for _, item := range material {
			materialRemark += item.MaterialName + "|"
		}

		var tasty []tasty
		json.Unmarshal([]byte(dv.Tasty), &tasty)

		tastyRemark := ""

		for _, item := range tasty {
			tastyRemark += item.AttrValue + "|"
		}

		title := dv.FoodName

		if dv.SkuDetail != "" {
			title += "-" + dv.SkuDetail
		}

		remark := materialRemark + tastyRemark

		remarkRune := []rune(remark)

		if len(remarkRune) > 1 {
			remark = string(remarkRune[0 : len(remarkRune)-1])
		}

		if remark != "" {
			title += "-" + remark
		}

		fod[dk].FoodName = title

	}

	fo.FoodDetail = fod
	fo.TotalCount = count

	if fo.PayType == "wxpay" {
		fo.RequestPayment.AppId = model.AppId
		fo.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
		fo.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
		fo.RequestPayment.Package = "prepay_id=" + fo.TradeNo
		fo.RequestPayment.SignType = "RSA"

		encryptData := []string{
			fo.RequestPayment.AppId,
			fo.RequestPayment.TimeStamp,
			fo.RequestPayment.NonceStr,
			fo.RequestPayment.Package,
		}

		signature := wechatUtil.Sign(encryptData)
		fo.RequestPayment.PaySign = signature
	}

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

func (model FoodOrder) Store() (fo FoodOrder, err error) {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	o, err := model.Show([]string{"order_id = ?"}, []interface{}{model.OrderId})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return o, err
	}

	// 不存在
	if o.OrderId != "" {
		return o, errors.New("该订单已经存在，无需重复添加！")
	}

	tx := db.Create(&model)
	if tx.Error != nil {
		return o, tx.Error
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

		payLog := appModel.PayLog{}
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
			payLog = appModel.PayLog{
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

// 减库存
func (model *FoodOrder) ReduceInventory() {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	var fod []FoodOrderDetail
	db.Where("order_id = ?", model.OrderId).Find(&fod)
	for _, v := range fod {

		var food Food
		tx := cmf.NewDb().Where("id = ?", v.FoodId).First(&food)
		if tx.Error != nil {
			continue
		}

		foodInventory := food.Inventory
		if foodInventory != -1 {
			foodInventory -= v.Count
			if foodInventory < 0 {
				foodInventory = 0
			}
		}

		// 更新商品库存
		db.Model(&food).Where("id = ?", v.FoodId).Update("inventory", foodInventory)

		if v.SkuId > 0 {
			var foodSku FoodSku

			tx = db.Where("sku_id = ?", v.SkuId).First(&foodSku)

			if tx.Error != nil {
				continue
			}

			skuInventory := foodSku.Inventory

			if skuInventory != -1 {
				skuInventory -= v.Count
				if skuInventory < 0 {
					skuInventory = 0
				}
			}

			// 更新商品规格库存
			tx = db.Model(&foodSku).Update("inventory", skuInventory)
			if tx.Error != nil {
				continue
			}

		}

	}
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 统一退款
 * @Date 2021/3/30 11:59:18
 * @Param
 * @return
 **/
func (model *FoodOrder) Refund(refundFee float64, refundReason string, authorizerAccessToken string) error {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	// 如果是余额支付
	if model.PayType == "balance" {

		rLog := appModel.RechargeLog{}
		tx := db.Where("target_id = ? AND target_type = ?", model.Id, 0).First(&rLog)
		if tx.Error != nil {
			return tx.Error
		}

		userData, err := new(User).Show([]string{"u.id = ?", "u.mid = ?", "user_type = 0", "u.delete_at = 0"}, []interface{}{model.UserId, model.Mid})
		if err != nil {
			return err
		}

		balance := userData.Balance

		reFee := decimal.NewFromFloat(refundFee)

		if err != nil {
			return err
		}

		balanceDecimal := decimal.NewFromFloat(balance).Add(reFee)
		balance, _ = balanceDecimal.Round(2).Float64()

		tx = db.Model(&User{}).Where("id = ?", userData.Id).Updates(map[string]interface{}{
			"balance": balance,
		})

		if tx.Error != nil {
			return err
		}

		balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

		rechargeLog := appModel.RechargeLog{
			UserId:     userData.Id,
			TargetId:   model.Id,
			TargetType: 0,
			Type:       0,
			Fee:        rLog.Fee,
			Balance:    balanceStr,
			Remark:     "订单退款",
			CreateAt:   time.Now().Unix(),
		}

		tx = db.Create(&rechargeLog)
		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			return err
		}
	}

	userMpType := ""
	// 如果是支付宝支付
	if model.PayType == "alipay" {

		log := appModel.PayLog{}
		tx := db.Where("order_id = ?", model.OrderId).First(&log)

		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			return tx.Error
		}

		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = model.OrderId
		bizContent["trade_no"] = model.TradeNo
		bizContent["refund_amount"] = refundFee
		bizContent["out_request_no"] = time.Now().Unix()
		bizContent["refund_reason"] = refundReason
		refundResult := new(payment.Common).Refund(bizContent)

		if refundResult.Response.Code != "10000" {
			fmt.Println("refundResult.Response", refundResult.Response)
			return errors.New("退款失败！")
		}

		userMpType = "alipay-mp"

	}

	// 如果是微信支付
	if model.PayType == "wxpay" {

		log := appModel.PayLog{}
		tx := db.Where("order_id = ?", model.OrderId).First(&log)

		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				return errors.New("支付日志不存在！")
			}
			return tx.Error
		}

		theme := saasModel.MpTheme{}
		tx = cmf.NewDb().Where("mid = ?", model.Mid).First(&theme)
		if tx.Error != nil {
			return tx.Error
		}

		if theme.SubMchid == "" {
			return errors.New("请先绑定微信支付")
		}

		bizContent := make(map[string]interface{}, 0)

		refund := decimal.NewFromFloat(refundFee).Round(2).Mul(decimal.NewFromInt(100)).IntPart()
		total := decimal.NewFromFloat(model.OriginalFee).Round(2).Mul(decimal.NewFromInt(100)).IntPart()

		bizContent["sub_mchid"] = theme.SubMchid
		bizContent["out_trade_no"] = model.OrderId
		bizContent["out_refund_no"] = "refund_" + strconv.FormatInt(time.Now().Unix(), 10)
		bizContent["amount"] = map[string]interface{}{
			"refund":   refund,
			"total":    total,
			"currency": "CNY",
		}
		bizContent["reason"] = refundReason

		refundsResponse := new(pay.PartnerPay).Refunds(bizContent)

		if refundsResponse.Code != "" {
			return errors.New(refundsResponse.Message)
		}

		userMpType = "wechat-mp"

	}

	var (
		u   User
		err error
	)
	// 退款通知
	if model.FormId != "" || authorizerAccessToken != "" {

		wxSubscribe := Subscribe{
			Id:          model.Id,
			Mid:         model.Mid,
			AccessToken: model.FormId,
			StoreName:   model.StoreName,
			OrderId:     model.OrderId,
			Fee:         strconv.FormatFloat(refundFee, 'f', -1, 64),
			Remark:      refundReason,
		}

		if model.FormId != "" {
			userMpType = "alipay-mp"
			wxSubscribe.Type = "alipay"
			wxSubscribe.AccessToken = model.FormId
		} else {
			userMpType = "wechat-mp"
			wxSubscribe.Type = "wechat"
			wxSubscribe.AccessToken = authorizerAccessToken
		}

		// 获取当前会员信息
		u, err = new(User).GetMpUser(model.UserId, userMpType)
		if err != nil {
			cmfLog.Error(err.Error())
			return err
		}

		wxSubscribe.OpenId = u.OpenId

		wxSubscribe.TradeRefund()

	}

	rFee, _ := decimal.NewFromFloat(model.RefundFee).Sub(decimal.NewFromFloat(refundFee)).Round(2).Float64()

	rfParams := map[string]interface{}{
		"refund_fee": rFee,
	}

	if rFee == 0 {
		rfParams["order_status"] = "TRADE_REFUND"
	}

	tx := db.Model(&FoodOrder{}).Where("id = ?", model.Id).Updates(rfParams)
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

	// 增加退款到退款订单日志
	db.Create(&FoodOrderRefund{
		Mid:     model.Mid,
		OrderId: model.OrderId,
		Fee:     refundFee,
		Reason:  refundReason,
	})

	// 修改支付日志为已退款
	payLog := &appModel.PayLog{}
	tx = db.Where("order_id = ?", model.OrderId).First(&payLog)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}
	if tx.RowsAffected > 0 {

		totalAmount := payLog.TotalAmount
		refundFee := payLog.RefundFee

		if payLog.Type == "wxpay" {
			totalAmount, _ = decimal.NewFromFloat(payLog.TotalAmount).Sub(decimal.NewFromFloat(refundFee).Mul(decimal.NewFromInt(100))).Round(2).Float64()
			refundFee, _ = decimal.NewFromFloat(refundFee).Add(decimal.NewFromFloat(refundFee).Mul(decimal.NewFromInt(100))).Round(2).Float64()
		}

		if payLog.Type == "alipay" {
			totalAmount, _ = decimal.NewFromFloat(payLog.TotalAmount).Sub(decimal.NewFromFloat(refundFee)).Round(2).Float64()
			refundFee, _ = decimal.NewFromFloat(refundFee).Add(decimal.NewFromFloat(refundFee).Mul(decimal.NewFromInt(100))).Round(2).Float64()
		}

		payLog.TotalAmount = totalAmount
		payLog.RefundFee = refundFee

		if rFee == 0 {
			payLog.TradeStatus = "TRADE_REFUND"
		}

		cmf.NewDb().Where("order_id = ?", model.OrderId).Updates(&payLog)
	}

	// 收回已发放的积分
	if model.PayType == "alipay" || model.PayType == "wxpay" {

		scoreJson := saasModel.Options("score", model.Mid)
		scoreMap := Score{}
		_ = json.Unmarshal([]byte(scoreJson), &scoreMap)

		// 启用消费返积分
		if scoreMap.EnabledPay == 1 {

			score := u.Score
			tScore := scoreMap.PayScore * int(refundFee)
			score = score - tScore
			remark := "退款"

			// 保存到数据库
			sLog := appModel.ScoreLog{
				UserId: u.Id,
				Type:   1,
				Score:  tScore,
				Fee:    strconv.FormatFloat(refundFee, 'f', 2, 64),
				Remark: remark,
			}

			// 达到消费门槛1元
			if refundFee > 1 {
				err = sLog.Save()
				if err != nil {
					return err
				}
			}

			u.Score = score
			tx := db.Where("id = ?", u.Id).Updates(&u)

			if tx.Error != nil {
				cmfLog.Error(tx.Error.Error())
				return tx.Error
			}

		}

	}

	return nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description //查询订单并打印
 * @Date 2021/3/30 11:47:35
 * @Param
 * @return
 **/

func (model *FoodOrder) Printer() error {

	id := model.Id

	if id == 0 {
		return errors.New("订单号不能为空！")
	}

	fo := FoodOrder{}
	// 查询订单
	tx := cmf.NewDb().Where("id = ?", id).First(&fo)
	if tx.Error != nil {
		return tx.Error
	}

	// 查询订单列表
	var fod = make([]FoodOrderDetail, 0)
	tx = cmf.NewDb().Where("order_id", fo.OrderId).Find(&fod)
	if tx.Error != nil {
		return tx.Error
	}

	var printOrder = make([]map[string]string, 0)

	for _, v := range fod {

		// 打印订单详情信息
		var printOrderItem = make(map[string]string, 0)

		title := v.FoodName
		if v.SkuDetail != "" {
			title += "-" + v.SkuDetail
		}

		printOrderItem["title"] = title
		printOrderItem["count"] = strconv.Itoa(v.Count)
		printOrderItem["food_id"] = strconv.Itoa(v.FoodId)
		printOrderItem["total"] = strconv.FormatFloat(v.Total, 'f', -1, 64)
		printOrder = append(printOrder, printOrderItem)

	}

	// 获取订单门店
	storeId := fo.StoreId

	// 获取门店信息
	store := Store{}
	store, err := store.Show([]string{"id = ?", "delete_at = ?"}, []interface{}{storeId, 0})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return err
	}

	if store.Id == 0 {
		return errors.New("该门店不存在或以关闭！")
	}

	appointmentTime := time.Unix(fo.AppointmentAt, 0).Format(data.TimeLayout)

	// 获取门店打印机状态
	_, err = new(FoodOrder).SendPrinter(fo, printOrder, store.StoreName, appointmentTime, true)

	return err

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取预付费订单
 * @Date 2021/6/15 14:11:1
 * @Param
 * @return
 **/
func (model *FoodOrder) GetDeliveryFee(store Store, deliveryGoods []DeliveryGoods) (foodOrder FoodOrder, err error) {

	addr := Address{}
	tx := cmf.NewDb().Where("id = ?", model.AddressId).First(&addr)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return foodOrder, tx.Error
	}

	if tx.RowsAffected == 0 {
		return foodOrder, errors.New("地址不存在！")
	}

	name := addr.Name
	if name == "" {
		return foodOrder, errors.New("收货人姓名不能为空！")
	}

	model.Name = name
	model.Mobile = strconv.Itoa(addr.Mobile)

	address := addr.Address + addr.Room
	geo := GeoAddress(address)

	if len(geo.MapGeoCodes) == 0 {
		return foodOrder, errors.New("该地址不存在")
	}

	if len(geo.MapGeoCodes) > 1 {
		return foodOrder, errors.New("该地址不够详细，请补全详细地址")
	}

	city := geo.MapGeoCodes[0].City
	location := geo.MapGeoCodes[0].Location

	lMap := strings.Split(location, ",")

	longitude, _ := strconv.ParseFloat(lMap[0], 64)
	latitude, _ := strconv.ParseFloat(lMap[1], 64)

	// 获取当前外卖配置
	takeJson := saasModel.Options("takeout", store.Mid)

	var takeOut TakeOut
	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	distance := util.EarthDistance(latitude, longitude, store.Latitude, store.Longitude)

	// 超出距离
	if distance > takeOut.DeliveryDistance {
		return foodOrder, errors.New("超过配送距离！")
	}

	// 企业主体
	businessJson := saasModel.Options("business_info", model.Mid)
	bi := BusinessInfo{}
	_ = json.Unmarshal([]byte(businessJson), &bi)

	// 获取微信三方平台的预订单价格

	var partnerDeliveryFee float64 = 0

	// 开启外卖功能

	deliveryName := "商家配送"
	deliveryId := "self"

	// 查询是否开通第三方配送
	var immediateDelivery []ImmediateDelivery
	tx = cmf.NewDb().Where("status", 1).Find(&immediateDelivery)
	if tx.Error != nil {
		return foodOrder, tx.Error
	}

	var (
		deliveryItem    ImmediateDelivery
		deliveryPercent = takeOut.DeliveryPercent
	)

	for _, v := range immediateDelivery {
		if v.IsMain == 1 {
			deliveryItem = v
			deliveryName = v.DeliveryName
			deliveryId = v.DeliveryId
			break
		}
	}

	deliveryTimes := takeOut.DeliveryTimes
	canUse := new(ImmediateDelivery).CanUseTime(deliveryTimes)

	var (
		shopOrderId string
	)

	if canUse && model.AccessToken != "" && takeOut.Status == 1 && deliveryItem.Id > 0 {

		yearStr, monthStr, dayStr := util.CurrentDate()
		insertKey := "mp_isv" + strconv.Itoa(model.Mid) + ":immDelivery:" + yearStr + monthStr + dayStr
		date := yearStr + monthStr + dayStr
		shopOrderId = util.DateUuid("DADA", insertKey, date, model.Mid)

		bizContent := make(map[string]interface{}, 0)
		bizContent["shopid"] = deliveryItem.Shopid
		bizContent["shop_order_id"] = shopOrderId
		bizContent["shop_no"] = store.StoreNumber

		dSign := bizContent["shopid"].(string) + bizContent["shop_order_id"].(string) + deliveryItem.AppSecret
		bizContent["delivery_sign"] = cmfUtil.GetSha1(dSign)
		bizContent["delivery_id"] = deliveryItem.DeliveryId
		bizContent["openid"] = model.OpenId

		imgUrl := bi.BrandLogo

		if imgUrl == "" {
			imgUrl = "https://cdn.mashangdian.cn/default/20210309/ebe1b4a577be63063872eff0dc98a287.jpg!clipper"
		}

		bizContent["shop"] = map[string]interface{}{
			"wxa_path":    "/page/order/detail",
			"img_url":     imgUrl,
			"goods_name":  deliveryGoods[0].GoodName,
			"goods_count": len(deliveryGoods),
		}

		bizContent["sender"] = map[string]interface{}{
			"name":            store.ContactPerson,
			"city":            store.CityName,
			"address":         store.Address,
			"address_detail":  store.Address,
			"phone":           store.Phone,
			"lng":             store.Longitude,
			"lat":             store.Latitude,
			"coordinate_type": 0,
		}

		bizContent["receiver"] = map[string]interface{}{
			"name":            addr.Name,
			"city":            city,
			"address":         addr.Address,
			"address_detail":  addr.Room,
			"phone":           addr.Mobile,
			"lng":             addr.Longitude,
			"lat":             addr.Latitude,
			"coordinate_type": 0,
		}

		bizContent["cargo"] = map[string]interface{}{
			"goods_value":        model.TotalAmount,
			"goods_weight":       model.GoodsWeight,
			"cargo_first_class":  takeOut.FirstClass,
			"cargo_second_class": takeOut.SecondClass,
			"goods_detail": map[string][]DeliveryGoods{
				"goods": deliveryGoods,
			},
		}

		data := new(wechatEasySdkOpen.Delivery).PreAdd(model.AccessToken, bizContent)

		if data.Errcode != 0 {

			if data.Errcode == 40001 {
				cmf.NewRedisDb().Set("accessToken", "", 0)
				cmf.NewRedisDb().Set("authorizerAccessToken", "", 0)
			}

			return *model, errors.New(data.Errmsg)
		}

		if data.Resultcode != 0 {
			return *model, errors.New(data.Resultmsg)
		}

		model.DeliveryToken = data.DeliveryToken
		partnerDeliveryFee = data.Fee

	}

	model.DeliveryId = deliveryId
	model.DeliveryName = deliveryName
	model.Address = address

	// 起送费（start_fee）
	sf := takeOut.StartFee
	// 剩余配送距离

	lastKm, _ := decimal.NewFromFloat(distance - takeOut.StartKm).Round(0).Float64()

	if lastKm <= 0 {
		lastKm = 0
	}

	lastFee := lastKm * takeOut.StepFee

	deliveryFee := sf + lastFee
	deliveryFee, _ = decimal.NewFromFloat(deliveryFee).Round(2).Float64()

	totalAmount := partnerDeliveryFee

	// 出资最大比例(开启第三方配送)
	var freeFee float64 = 0
	if takeOut.Status == 1 && deliveryItem.Id > 0 {
		maxAmount, _ := decimal.NewFromFloat(model.TotalAmount).Mul(decimal.NewFromFloat(deliveryPercent)).Mul(decimal.NewFromFloat(0.01)).Float64()
		if partnerDeliveryFee > maxAmount {
			partnerDeliveryFee = partnerDeliveryFee - maxAmount
			freeFee = maxAmount
		} else {
			freeFee = partnerDeliveryFee
			partnerDeliveryFee = 0
		}
	} else {
		// 自配送
		partnerDeliveryFee = deliveryFee
	}

	model.DeliveryFee = math.Floor(partnerDeliveryFee)

	wipeOff, _ := decimal.NewFromFloat(partnerDeliveryFee).Sub(decimal.NewFromFloat(model.DeliveryFee)).Float64()

	model.DeliveryFree = freeFee + wipeOff

	if shopOrderId != "" {

		var deliveryMap = DeliveryMap{
			ShopOrderId:   shopOrderId,
			DeliveryToken: model.DeliveryToken,
			DeliveryId:    model.DeliveryId,
			DeliveryName:  model.DeliveryName,
			TotalAmount:   totalAmount,
			DeliveryFee:   model.DeliveryFee,
			DeliveryFree:  model.DeliveryFree,
		}

		deliveryData, _ := json.Marshal(deliveryMap)

		fmt.Println("deliveryData", string(deliveryData))

		cmf.NewRedisDb().Set(model.DeliveryToken, string(deliveryData), time.Minute*5)
	}

	return *model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 下正式单
 * @Date 2021/6/15 14:14:22
 * @Param
 * @return
 **/
func (model *FoodOrder) AddOrder(store Store, deliveryGoods []DeliveryGoods) (foodOrder FoodOrder, err error) {

	addr := Address{}
	tx := cmf.NewDb().Where("id = ?", model.AddressId).First(&addr)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return foodOrder, tx.Error
	}

	if tx.RowsAffected == 0 {
		return foodOrder, errors.New("地址不存在！")
	}

	name := addr.Name
	if name == "" {
		return foodOrder, errors.New("收货人姓名不能为空！")
	}

	model.Name = name
	model.Mobile = strconv.Itoa(addr.Mobile)

	address := addr.Address + addr.Room
	geo := GeoAddress(address)

	if len(geo.MapGeoCodes) == 0 {
		return foodOrder, errors.New("该地址不存在")
	}

	if len(geo.MapGeoCodes) > 1 {
		return foodOrder, errors.New("该地址不够详细，请补全详细地址")
	}

	city := geo.MapGeoCodes[0].City
	location := geo.MapGeoCodes[0].Location

	lMap := strings.Split(location, ",")

	longitude, _ := strconv.ParseFloat(lMap[0], 64)
	latitude, _ := strconv.ParseFloat(lMap[1], 64)

	// 获取当前外卖配置
	takeJson := saasModel.Options("takeout", store.Mid)

	var takeOut TakeOut
	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	distance := util.EarthDistance(latitude, longitude, store.Latitude, store.Longitude)

	// 超出距离
	if distance > takeOut.DeliveryDistance {
		return foodOrder, errors.New("超过配送距离！")
	}

	// 企业主体
	businessJson := saasModel.Options("business_info", model.Mid)
	bi := BusinessInfo{}
	_ = json.Unmarshal([]byte(businessJson), &bi)

	// 查询是否开通第三方配送
	var immediateDelivery []ImmediateDelivery
	tx = cmf.NewDb().Where("status", 1).Find(&immediateDelivery)
	if tx.Error != nil {
		return foodOrder, tx.Error
	}

	var (
		deliveryItem ImmediateDelivery
	)

	for _, v := range immediateDelivery {
		if v.IsMain == 1 {
			deliveryItem = v
			break
		}
	}

	ido := ImmediateDeliveryOrder{
		Mid:     model.Mid,
		OrderId: model.OrderId,
	}

	fmt.Println("model.AccessToken", model.AccessToken)
	fmt.Println("model.DeliveryToken", model.DeliveryToken)

	if model.AccessToken != "" && model.DeliveryToken != "" && takeOut.Status == 1 && deliveryItem.Id > 0 {

		shopOrderId := model.ShopOrderId

		ido.OrderId = model.OrderId
		ido.DeliveryId = deliveryItem.Shopid
		ido.DeliveryName = deliveryItem.DeliveryName

		bizContent := make(map[string]interface{}, 0)
		bizContent["delivery_token"] = model.DeliveryToken
		bizContent["shopid"] = deliveryItem.Shopid
		bizContent["shop_order_id"] = shopOrderId
		bizContent["shop_no"] = store.StoreNumber

		dSign := bizContent["shopid"].(string) + bizContent["shop_order_id"].(string) + deliveryItem.AppSecret
		bizContent["delivery_sign"] = cmfUtil.GetSha1(dSign)
		bizContent["delivery_id"] = deliveryItem.DeliveryId
		bizContent["openid"] = model.OpenId

		imgUrl := bi.BrandLogo

		if imgUrl == "" {
			imgUrl = "https://cdn.mashangdian.cn/default/20210309/ebe1b4a577be63063872eff0dc98a287.jpg!clipper"
		}

		bizContent["shop"] = map[string]interface{}{
			"wxa_path":    "/page/order/detail",
			"img_url":     imgUrl,
			"goods_name":  deliveryGoods[0].GoodName,
			"goods_count": len(deliveryGoods),
		}

		bizContent["sender"] = map[string]interface{}{
			"name":            store.ContactPerson,
			"city":            store.CityName,
			"address":         store.Address,
			"address_detail":  store.Address,
			"phone":           store.Phone,
			"lng":             store.Longitude,
			"lat":             store.Latitude,
			"coordinate_type": 0,
		}

		bizContent["receiver"] = map[string]interface{}{
			"name":            addr.Name,
			"city":            city,
			"address":         addr.Address,
			"address_detail":  addr.Room,
			"phone":           addr.Mobile,
			"lng":             addr.Longitude,
			"lat":             addr.Latitude,
			"coordinate_type": 0,
		}

		bizContent["cargo"] = map[string]interface{}{
			"goods_value":        model.TotalAmount,
			"goods_weight":       model.GoodsWeight,
			"cargo_first_class":  takeOut.FirstClass,
			"cargo_second_class": takeOut.SecondClass,
			"goods_detail": map[string][]DeliveryGoods{
				"goods": deliveryGoods,
			},
		}

		data := new(wechatEasySdkOpen.Delivery).OrderAdd(model.AccessToken, bizContent)

		if data.Errcode != 0 {
			return *model, errors.New(data.Errmsg)
		}

		ido.DeliveryToken = model.DeliveryToken
		ido.ShopOrderId = shopOrderId
		ido.WaybillId = data.WaybillId
		ido.DeliveryFee, _ = decimal.NewFromInt(int64(data.Fee)).Round(2).Float64()
		ido.DeliveryFree, _ = decimal.NewFromFloat(ido.DeliveryFee).Sub(decimal.NewFromFloat(model.DeliveryFee)).Round(2).Float64()
		ido.BuyerPayAmount = model.DeliveryFee
		ido.OrderStatus = data.OrderStatus
		ido.CreateAt = time.Now().Unix()

		cmf.NewDb().Create(&ido)

	}

	return *model, nil
}

type Content struct {
	Printer `json:"printer"`
	Content string `json:"content"`
	Count   int    `json:"count"`
}

// 发送打印订单请求
func (model *FoodOrder) SendPrinter(fo FoodOrder, printOrder []map[string]string, storeName string, appointmentTime string, canPrinter bool) (content []Content, err error) {
	// 获取门店打印机状态
	var printers []Printer

	tx := cmf.NewDb().Where("store_id = ? AND mid = ?", fo.StoreId, fo.Mid).Find(&printers)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return content, tx.Error
	}

	if tx.RowsAffected == 0 {
		return content, errors.New("请先绑定至少一台打印机！")
	}

	content = make([]Content, 0)

	for _, p := range printers {
		printer := printerPlugin.Printer{}
		if p.Brand == "feie" {
			// 打印机打印订单
			printer.Type = "feie"
		} else if p.Brand == "xprinter" {
			printer.Type = "xprinter"
		} else {
			return content, errors.New("打印机类型错误")
		}

		pf := printerPlugin.PrinterFormat{
			Brand:           p.Brand,
			OrderType:       fo.OrderType,
			StoreName:       storeName,
			PayType:         fo.PayType,
			DeskName:        fo.DeskName,
			QueueNo:         fo.QueueNo,
			CouponFee:       strconv.FormatFloat(fo.CouponFee, 'f', -1, 64),
			OriginalFee:     strconv.FormatFloat(fo.OriginalFee, 'f', -1, 64),
			Fee:             strconv.FormatFloat(fo.Fee, 'f', -1, 64),
			BoxFee:          strconv.FormatFloat(fo.BoxFee, 'f', -1, 64),
			DeliveryFee:     strconv.FormatFloat(fo.DeliveryFee, 'f', -1, 64),
			Address:         fo.Address,
			Name:            fo.Name,
			Mobile:          fo.Mobile,
			AppointmentTime: appointmentTime,
			OutTradeNo:      fo.OrderId,
			TradeNo:         fo.TradeNo,
			Remark:          fo.Remark,
		}

		// 整单打印
		if p.Pattern == 0 {
			pContent := printer.FormatPrinter(printOrder, "58mm")

			pf.OrderDetail = pContent
			pItemContent := pf.Format("58mm")

			content = append(content, Content{
				Printer: p,
				Content: pItemContent,
				Count:   p.Count,
			})

			cmfLog.Save(pItemContent, "test-整单.log")

			if p.Id > 0 && canPrinter {
				if p.Brand == "feie" {
					myResult := new(base.Printer).Printer(p.Sn, pItemContent, p.Count)
					fmt.Println("myResult", myResult)

					if myResult.Ret > 0 {
						new(Printer).NsqProducer(fo.Mid, fo.Id)
					}

				}

				if p.Brand == "xprinter" {
					myResult := new(xpyunYun.Printer).Printer(p.Sn, pItemContent, p.Count)
					fmt.Println("myResult", myResult.Content)

					if myResult.Content.Code > 0 {
						new(Printer).NsqProducer(fo.Mid, fo.Id)
					}

				}
			}
		}

		// 一菜一单
		if p.Pattern == 1 {
			fmt.Println("一菜一单")
			for k, v := range printOrder {
				var po []map[string]string
				po = append(po, v)
				pContent := printer.FormatPrinter(po, "58mm")

				pf.OrderDetail = pContent
				pf.Pattern = 1 // 标记为一菜一单
				complete := false
				if len(printOrder)-1 == k {
					complete = true
				}
				pf.Complete = complete
				pItemContent := pf.Format("58mm")

				cmfLog.Save(pItemContent, "test-一菜.log")

				content = append(content, Content{
					Printer: p,
					Content: pItemContent,
					Count:   p.Count,
				})

				if p.Id > 0 && canPrinter {
					if p.Brand == "feie" {
						myResult := new(base.Printer).Printer(p.Sn, pItemContent, p.Count)
						fmt.Println("myResult", myResult)

						if myResult.Ret > 0 {
							new(Printer).NsqProducer(fo.Mid, fo.Id)
						}

					}

					if p.Brand == "xprinter" {
						myResult := new(xpyunYun.Printer).Printer(p.Sn, pItemContent, p.Count)
						fmt.Println("myResult", myResult.Content)
						if myResult.Content.Code > 0 {
							new(Printer).NsqProducer(fo.Mid, fo.Id)
						} else {
							fmt.Println("nsq err", err)
						}
					}
				}

			}
		}

	}

	return content, nil
}
