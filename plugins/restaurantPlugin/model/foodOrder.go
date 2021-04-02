/**
** @创建时间: 2020/11/28 8:41 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	feieModel "gincmf/plugins/feiePlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"github.com/gincmf/feieSdk/base"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
	"strconv"
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
	OriginalFee     float64           `gorm:"type:decimal(7,2);comment:原价金额;default:0;not null" json:"original_fee"`
	TotalAmount     float64           `gorm:"->" json:"total_amount"`
	BuyerPayAmount  float64           `gorm:"->" json:"buyer_pay_amount"`
	DeskId          int               `gorm:"type:int(11);comment:桌号id" json:"desk_id"`
	DeskName        string            `gorm:"type:varchar(40);comment:桌位名称详情" json:"desk_name"`
	UserId          int               `gorm:"type:bigint(20);comment:下单人信息" json:"user_id"`
	Name            string            `gorm:"type:varchar(20);comment:用户预留姓名" json:"name"`
	Mobile          string            `gorm:"type:varchar(11);comment:用户预留手机号;not null" json:"mobile"`
	Address         string            `gorm:"type:varchar(255);comment:用户预留收货地址" json:"address"`
	AddressId       int               `gorm:"type:int(11);comment:选择地址id" json:"address_id"`
	CreateAt        int64             `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt      int64             `gorm:"type:int(11)" json:"finished_at"`
	CreateTime      string            `gorm:"-" json:"create_time"`
	FinishedTime    string            `gorm:"-" json:"finished_time"`
	TotalCount      int               `gorm:"-" json:"total_count"`
	OrderStatus     string            `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用/已支付，TRADE_FINISHED=> 已完成，TRADE_REFUSED => 已拒绝，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	DeliveryStatus  string            `gorm:"type:varchar(20);comment:运输状态（TRADE_RECEIVED => 已接单，TRADE_DELIVERY => 运输中" json:"delivery_status"`
	paginate        cmfModel.Paginate `gorm:"-"`
	Db              *gorm.DB          `gorm:"-" json:"-"`
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
func (model *FoodOrder) Refund() error {

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

		reFee, err := decimal.NewFromString(rLog.Fee)

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
		bizContent["refund_amount"] = log.TotalAmount
		refundResult := new(payment.Common).Refund(bizContent)

		if refundResult.Response.Code != "10000" {
			return errors.New("退款失败！")
		}
	}

	tx := db.Model(&FoodOrder{}).Where("id = ?", model.Id).Update("order_status", "TRADE_REFUND")
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
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

	fmt.Println("store",store)

	// 打印机打印订单
	pContent := new(base.Printer).Format58Printer(printOrder)

	pf := feieModel.PrinterFormat{
		OrderType:   fo.OrderType,
		StoreName:   store.StoreName,
		PayType:     fo.PayType,
		QueueNo:     fo.QueueNo,
		OrderDetail: pContent,
		CouponFee:   strconv.FormatFloat(fo.CouponFee, 'f', -1, 64),
		OriginalFee: strconv.FormatFloat(fo.Fee+fo.BoxFee, 'f', -1, 64),
		Fee:         strconv.FormatFloat(fo.Fee, 'f', -1, 64),
		BoxFee:      strconv.FormatFloat(fo.BoxFee, 'f', -1, 64),
		Address:     fo.Address,
		Name:        fo.Name,
		Mobile:      fo.Mobile,
	}

	content := pf.Format("58mm")

	// 获取门店打印机状态
	p := Printer{}
	p, err = p.Show([]string{"store_id = ? AND mid = ?"}, []interface{}{fo.StoreId, fo.Mid})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return err
	}

	if p.Id > 0 {
		myResult := new(base.Printer).Printer(p.Sn, content, "1")
		fmt.Println("myResult", myResult)
	} else {
		fmt.Println("请先绑定打印机！")
	}

	return nil

}
