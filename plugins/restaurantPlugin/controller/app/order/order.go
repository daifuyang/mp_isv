/**
** @创建时间: 2020/11/25 1:40 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	feieModel "gincmf/plugins/feiePlugin/model"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	"github.com/gincmf/alipayEasySdk/merchant"
	"github.com/gincmf/alipayEasySdk/payment"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gincmf/feieSdk/base"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
	"math"
	"net/http"
	"regexp"
	"strconv"
	"strings"
	"time"
)

type Order struct {
	rc controller.RestController
}

type orderDetail struct {
	Name     string     `json:"name"`
	FoodId   int        `json:"food_id"`
	Count    int        `json:"count"`
	Fee      float64    `json:"fee"`
	SkuId    int        `json:"sku_id"`
	Tasty    []tasty    `json:"tasty"`
	Material []material `json:"material"`
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

type balancePay struct {
	orderType    int     `json:"order_type"`
	alipayUserId int     `json:"alipay_user_id"`
	voucherId    int     `json:"voucher_id"`
	totalFee     float64 `json:"total_fee"`
	sn           string  `json:"sn"`
	content      string  `json:"content"`
	noticeTitle  string  `json:"notice_title"`
	audio        string  `json:"audio"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部订单列表
 * @Date 2020/12/6 21:39:32
 * @Param
 * @return
 **/

func (rest *Order) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	// 默认获取当天的，history获取历史的
	var query = []string{"TO_DAYS(from_unixtime(fo.create_at)) = TO_DAYS(NOW())"}
	var queryArgs []interface{}

	currentTime := time.Now()
	time := time.Date(currentTime.Year(), currentTime.Month(), currentTime.Day()-1, 23, 59, 59, 0, currentTime.Location())
	yesterday := time.Unix()

	// 历史订单
	history := c.Query("history")
	if history == "1" {
		query = []string{"fo.create_at < ?"}
		queryArgs = []interface{}{yesterday}
	}

	query = append(query, "fo.mid = ?")
	queryArgs = append(queryArgs, mid)

	// 订单状态
	orderStatus := c.Query("order_status")
	if orderStatus != "" {
		query = append(query, "fo.order_status = ?")
		queryArgs = append(queryArgs, orderStatus)
	}

	// 订单类型
	orderType := c.Query("order_type")
	if orderType != "" {
		query = append(query, "fo.order_type = ?")
		queryArgs = append(queryArgs, orderType)
	}

	mpUserId, exists := c.Get("mp_user_id")

	if exists {
		query = append(query, "fo.user_id = ?")
		queryArgs = append(queryArgs, mpUserId)
	}

	// 获取全部订单
	fo := model.FoodOrder{}
	data, err := fo.IndexByStore(c, query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取单个订单详情
 * @Date 2021/1/7 8:44:38
 * @Param
 * @return
 **/
func (rest *Order) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	// 默认获取当天的，history获取历史的
	var query = []string{"fo.mid = ? AND fo.id = ?"}
	var queryArgs = []interface{}{mid, rewrite.Id}

	mpUserId, exists := c.Get("mp_user_id")

	if exists {
		query = append(query, "fo.user_id = ?")
		queryArgs = append(queryArgs, mpUserId)
	}

	data, err := new(model.FoodOrder).ShowByStore(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 预创建订单
 * @Date 2020/11/30 19:36:5
 * @Param
 * @return
 **/
func (rest *Order) PreCreate(c *gin.Context) {

	/*
	 *订单类型 1 => 门店就餐; 2 => 打包外带；3 => 外卖
	 *1.有桌位 => 扫码选择桌位号就餐
	 *  无桌位 => 直接下单，获取取餐号
	 *2.打包 => 获取取餐号，并备注类型为打包外带
	 *3.外卖 => 类型为外卖订单
	 */

	// todo 会员逻辑

	mpUserId, _ := c.Get("mp_user_id")
	mid, _ := c.Get("mid")

	midStr := strconv.Itoa(mid.(int))

	Openid, _ := c.Get("open_id")
	storeId, _ := c.Get("store_id")
	mpType, _ := c.Get("mp_type")
	appId, _ := c.Get("app_id")

	var form struct {
		Scene       string        `json:"scene"`
		DeskId      int           `json:"desk_id"`
		Mobile      string        `json:"mobile"`
		Appointment string        `json:"appointment"`
		OrderDetail []orderDetail `json:"order_detail"`
		BoxFee      float64       `json:"box_fee"`
		DeliveryFee float64       `json:"delivery_fee"`
		VoucherId   int           `json:"voucher_id"`
		Remark      string        `json:"remark"`
		AddressId   int           `json:"address_id"`
		PayType     string        `json:"pay_type"` // balance 和 alipay
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 获取当前会员信息
	u, err := new(model.User).GetMpUser(mpUserId.(int))
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	userId := mpUserId.(int)
	fo := model.FoodOrder{
		Mid:     mid.(int),
		StoreId: storeId.(int),
		UserId:  userId,
	}

	store := model.Store{}
	store, err = store.Show([]string{"id = ?", "delete_at = ?"}, []interface{}{storeId, 0})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if store.Id == 0 {
		rest.rc.Error(c, "该门店不存在或以关闭！", nil)
		return
	}

	otInt := 0

	// 通知标题
	noticeTitle := ""

	foodOrderType := "qr_order"

	orderType := 0
	switch form.Scene {
	case "eatin":
		if store.EatIn.Status == 0 {
			rest.rc.Error(c, "该门店未开启堂食功能！", nil)
			return
		}

		if store.EatIn.EnabledAppointment == 0 && form.Appointment != "" {
			rest.rc.Error(c, "该门店未开启预约功能！", nil)
			return
		}

		// 堂食类型
		if store.EatIn.EatType == 0 {
			// 有桌位
			orderType = 1
		} else {
			// 无桌位
			orderType = 2
		}

	case "pack":
		if store.EatIn.Status == 0 {
			rest.rc.Error(c, "该门店未开启堂食功能！", nil)
			return
		}
		orderType = 3
	case "takeout":
		if store.TakeOut.Status == 0 {
			rest.rc.Error(c, "该门店未开启外卖功能！", nil)
			return
		}
		orderType = 4
	}

	// 判断预约时间是否过近
	if form.Appointment != "" {
		tmp, err := time.ParseInLocation("2006-01-02 15:04", form.Appointment, time.Local)
		if err != nil {
			rest.rc.Error(c, "预约时间格式错误！", nil)
			return
		}

		if time.Now().Unix()+10*60 > tmp.Unix() {
			rest.rc.Error(c, "您选的预约时间过于接近，请调整时间！", nil)
			return
		}

	}

	switch orderType {

	case 1:
		otInt = 1
		noticeTitle = "堂食订单通知"
		foodOrderType = "qr_order"
		// 如果的是堂食扫码点餐
		// 商家开启了桌号
		if form.Appointment == "" {
			deskId := 0
			deskId = form.DeskId // 桌号
			if deskId == 0 {
				rest.rc.Error(c, "桌号不能为空！", nil)
				return
			}
			// 添加桌号
			fo.DeskId = deskId
		}

		// 如果是餐前模式
		if store.EatIn.SaleType == 0 {
			if store.EatIn.EatType == 0 {

			}
		}

	case 2:
		otInt = 2
		noticeTitle = "堂食订单通知"
		foodOrderType = "pre_order"
		// 如果的是堂食到店就餐
		appointmentTime := form.Appointment
		if appointmentTime == "" {
			dateTime := time.Unix(time.Now().Unix(), 0).Format("15:04")
			appointmentTime = dateTime
		}

		//预约时间
		fo.AppointmentTime = appointmentTime

	case 3:
		otInt = 3
		noticeTitle = "堂食订单通知"
		foodOrderType = "qr_order"
		// 如果的是堂食打包外带
		AppointmentTime := form.Appointment //预约时间
		fo.AppointmentTime = AppointmentTime

	case 4:
		otInt = 4
		noticeTitle = "外卖订单通知"
		foodOrderType = "home_delivery"
		// 如果是外卖
		//运费
		if form.DeliveryFee > 0 {
			fo.DeliveryFee = form.DeliveryFee
		}

		addr := model.Address{}
		tx := cmf.NewDb().Where("id = ?", form.AddressId).First(&addr)

		if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			cmfLog.Error(err.Error())
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		if tx.RowsAffected == 0 {
			rest.rc.Error(c, "地址不存在！", nil)
			return
		}

		name := addr.Name
		if name == "" {
			rest.rc.Error(c, "收货人姓名不能为空！", nil)
			return
		}

		fo.Name = name

		address := addr.Address + addr.Room
		geo := model.GeoAddress(address)

		if len(geo.MapGeoCodes) == 0 {
			rest.rc.Error(c, "该地址不存在", nil)
			return
		}

		if len(geo.MapGeoCodes) > 1 {
			rest.rc.Error(c, "该地址不够详细，请补全详细地址", nil)
			return
		}

		location := geo.MapGeoCodes[0].Location

		lMap := strings.Split(location, ",")

		longitude, _ := strconv.ParseFloat(lMap[0], 64)
		latitude, _ := strconv.ParseFloat(lMap[1], 64)

		store := model.Store{
			Id:        storeId.(int),
			Mid:       mid.(int),
			Longitude: longitude,
			Latitude:  latitude,
		}

		outRange, err := store.OutRangeStatus()
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if outRange {
			rest.rc.Error(c, "超过配送距离！", nil)
			return
		}

		fo.Address = address
		fo.AddressId = form.AddressId

	default:
		rest.rc.Error(c, "订单类型参数错误！", nil)
		return
	}

	fo.OrderType = otInt

	mobile := form.Mobile
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	fo.Mobile = mobile

	// 菜品详情
	od := form.OrderDetail

	var aliDetail []payment.GoodsDetail

	var fee float64 = 0
	var boxFee float64 = 0
	var couponFee float64 = 0

	/*
		创建订单号

		取餐号：当天的时间戳+随机数+redis自增

		生成规则：T（堂食）W（外卖）当天时间 + 当天的时间戳+随机数+redis自增
	*/

	ident := "T"
	if otInt == 4 {
		ident = "W"
	}

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + midStr + ":order:" + date

	orderId := util.DateUuid(ident, insertKey, date, mid.(int))

	if orderId == "" {
		rest.rc.Error(c, "订单号生成出错！", nil)
		return
	}

	// 遍历出全部菜品详情
	var foodOrderDetail = make([]model.FoodOrderDetail, 0)

	// 打印机订单
	var printOrder = make([]map[string]string, 0)

	// 用户传递进来的购物详情

	for _, v := range od {

		fod := model.FoodOrderDetail{}

		foodId := v.FoodId
		food := model.Food{}
		foodData, err := food.Show([]string{"mid = ? AND id = ? AND delete_at = ?"}, []interface{}{mid, foodId, 0})
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, v.Name+"商品不存在或已下架！", nil)
				return
			}
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		remark := ""

		fod.FoodId = foodData.Id
		fod.FoodName = foodData.Name
		fod.OrderId = orderId
		fod.DishType = foodData.DishType
		fod.Flavor = foodData.Flavor
		fod.CookingMethod = foodData.CookingMethod

		if foodData.Thumbnail != "" {
			fod.FoodThumbnail = foodData.Thumbnail
			// 上传缩略图到阿里支付宝
			file := util.GetAbsPath(foodData.Thumbnail)
			bizContent := make(map[string]string, 0)
			fileResult, err := new(merchant.File).Upload(bizContent, file)

			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
			fod.AlipayMaterialId = fileResult.Response.MaterialId
		}

		var materialContent []string
		var materialMap []material

		// 加料
		var materialTotalFee float64

		// 启用加料功能
		mJson := "{}"
		materialRemark := ""
		if foodData.UseMaterial == 1 {
			for _, item := range v.Material {
				m := model.FoodMaterialPost{}
				result := cmf.NewDb().Where("id = ? AND mid = ?", item.Id, mid).First(&m)
				if result.Error != nil {
					if errors.Is(result.Error, gorm.ErrRecordNotFound) {
						rest.rc.Error(c, item.MaterialName+"加料已下架，请删除重新下单！", item)
						return
					}
					rest.rc.Error(c, result.Error.Error(), nil)
					return
				}

				if m.MaterialPrice != item.MaterialPrice {
					rest.rc.Error(c, item.MaterialName+"商品价格变动，请重新下单！", nil)
					return
				}

				count := float64(item.Count)

				// 家来哦价格
				mDecimal := decimal.NewFromFloat(m.MaterialPrice).Mul(decimal.NewFromFloat(count))
				tempMatPrice, _ := mDecimal.Float64()

				mPrice, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", tempMatPrice), 64)
				if mPrice < 0 {
					rest.rc.Error(c, "商品结算价格非法！", nil)
					return
				}

				// 增加加料描述
				materialRemark += "|" + m.MaterialName
				materialMap = append(materialMap, material{
					Id:            m.Id,
					Count:         item.Count,
					MaterialName:  m.MaterialName,
					MaterialPrice: mPrice,
				})

				materialContent = append(materialContent, m.MaterialName)

				materialFeeDecimal := decimal.NewFromFloat(materialTotalFee).Add(decimal.NewFromFloat(tempMatPrice))
				materialTotalFee, _ = materialFeeDecimal.Round(2).Float64()
			}

			// 保存加料信息
			materialJson, err := json.Marshal(materialMap)
			if err != nil {
				rest.rc.Error(c, "加料参数错误！", nil)
				return
			}
			mJson = string(materialJson)

		}

		fod.Material = mJson

		// 口味
		tastyRemark := ""

		for _, item := range v.Tasty {
			tastyRemark = "|" + item.AttrValue
		}

		tastyJson, err := json.Marshal(v.Tasty)
		fod.Tasty = string(tastyJson)

		// 单个订单总计
		var odTotal float64 = 0
		// 是否启用规格
		if foodData.UseSku == 1 {

			if v.SkuId == 0 {
				rest.rc.Error(c, "规格参数不能为空！", nil)
				return
			}

			// 获取规格详情

			// 打印单项详情
			var printOrderItem = make(map[string]string, 0)

			foodSku := model.FoodSku{}
			skuData, err := foodSku.Detail([]string{"sku_id = ?"}, []interface{}{v.SkuId})

			if err != nil {
				if errors.Is(err, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, v.Name+skuData.SkuDetail+"不存在或已下架！", nil)
					return
				}
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			if skuData.Inventory == 0 {
				rest.rc.Error(c, v.Name+skuData.SkuDetail+"库存不足，请删除重新下单！", nil)
				return
			}

			code := skuData.Code
			if code == "" {
				code = strconv.Itoa(v.FoodId) + "-" + strconv.Itoa(skuData.SkuId)
			}

			// 增加规格描述
			remark = skuData.SkuDetail + materialRemark + tastyRemark

			count := float64(v.Count)

			totalPriceDecimal := decimal.NewFromFloat(skuData.Price).Mul(decimal.NewFromFloat(count))
			tempTotalPrice, _ := totalPriceDecimal.Round(2).Float64()

			// 单个规格总价
			odTotal, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", tempTotalPrice), 64)

			if odTotal < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			// 订单规格
			fod.Code = code
			fod.SkuId = skuData.SkuId
			fod.SkuDetail = remark
			fod.Count = v.Count       // 数量
			fod.Price = skuData.Price // 单价

			printOrderItem["title"] = foodData.Name + "-" + remark
			printOrderItem["count"] = strconv.Itoa(fod.Count)

			// 判断菜品是否启用会员价
			if skuData.UseMember == 1 {

				fod.UseMember = 1
				fod.MemberPrice = skuData.MemberPrice

				// 判断会员是否拥有专属折扣
				if u.Level != nil && u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {
					mPriceDecimal := decimal.NewFromFloat(fod.MemberPrice).Mul(decimal.NewFromFloat(u.Level.Benefit.Discount).Div(decimal.NewFromInt(100)))
					fod.MemberPrice, _ = mPriceDecimal.Round(2).Float64()
				}

				totalPriceDecimal := decimal.NewFromFloat(fod.MemberPrice).Mul(decimal.NewFromFloat(count))
				odTotal, _ = totalPriceDecimal.Round(2).Float64()

				// 单个总价
				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)

			} else {
				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)
			}

			printOrderItem["food_id"] = strconv.Itoa(fod.FoodId)

			// 加料价格
			if len(materialContent) > 0 {
				feeDecimal := decimal.NewFromFloat(odTotal).Add(decimal.NewFromFloat(materialTotalFee))
				odTotal, _ = feeDecimal.Float64()
				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)
			}

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   code,
				GoodsName: foodData.Name + "-" + remark,
				Quantity:  strconv.Itoa(v.Count),
				Price:     odTotal,
				Body:      skuData.SkuDetail,
			})

			// 包含加料等额外的总价
			fod.Total = odTotal

			foodOrderDetail = append(foodOrderDetail, fod)
			printOrder = append(printOrder, printOrderItem)

		} else {

			// 打印单项详情
			var printOrderItem = make(map[string]string, 0)

			code := foodData.FoodCode
			if code == "" {
				code = strconv.Itoa(v.FoodId)
			}

			// 增加规格描述
			// 增加规格描述
			remark = materialRemark + tastyRemark

			if foodData.Inventory == 0 {
				rest.rc.Error(c, v.Name+"库存不足，请删除重新下单！", nil)
				return
			}

			/*if foodData.Price != v.Fee {
				rest.rc.Error(c, v.Name+"价格变动，请重新下单！", nil)
				return
			}*/

			count := float64(v.Count)

			tempDecimal := decimal.NewFromFloat(foodData.Price).Mul(decimal.NewFromFloat(count))
			tempTotalPrice, _ := tempDecimal.Round(2).Float64()

			totalPrice, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", tempTotalPrice), 64)

			if totalPrice < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			fod.Code = code
			fod.Count = v.Count
			fod.Price = foodData.Price

			printOrderItem["title"] = foodData.Name + "-" + remark
			printOrderItem["count"] = strconv.Itoa(fod.Count)

			// 判断菜品是否启用会员价
			if foodData.UseMember == 1 {
				fod.UseMember = 1
				fod.MemberPrice = foodData.MemberPrice

				// 判断会员是否拥有专属折扣
				if u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {

					mPriceDecimal := decimal.NewFromFloat(fod.MemberPrice).Mul(decimal.NewFromFloat(u.Level.Benefit.Discount).Div(decimal.NewFromInt(100)))
					fod.MemberPrice, _ = mPriceDecimal.Round(2).Float64()

				}

				odDecimal := decimal.NewFromFloat(fod.MemberPrice).Mul(decimal.NewFromFloat(count))
				odTotal, _ = odDecimal.Float64()

				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)

			} else {

				// 总价
				odDecimal := decimal.NewFromFloat(odTotal).Add(decimal.NewFromFloat(totalPrice))
				odTotal, _ = odDecimal.Float64()
				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)

			}

			printOrderItem["food_id"] = strconv.Itoa(fod.FoodId)

			if len(materialContent) > 0 {

				feeDecimal := decimal.NewFromFloat(odTotal).Add(decimal.NewFromFloat(materialTotalFee))
				odTotal, _ := feeDecimal.Float64()
				printOrderItem["total"] = strconv.FormatFloat(odTotal, 'f', -1, 64)

			}

			if otInt > 2 {
				fod.BoxFee = foodData.BoxFee
			}

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   code,
				GoodsName: foodData.Name + "-" + remark,
				Quantity:  strconv.Itoa(v.Count),
				Price:     odTotal,
				Body:      v.Name,
			})

			fod.Total = odTotal

			feeDecimal := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(odTotal))
			fee, _ = feeDecimal.Float64()

			foodOrderDetail = append(foodOrderDetail, fod)
			printOrder = append(printOrder, printOrderItem)
		}

		if otInt > 2 {
			// 餐盒费
			boxFeeDecimal := decimal.NewFromFloat(boxFee).Add(decimal.NewFromFloat(foodData.BoxFee))
			boxFee, _ = boxFeeDecimal.Float64()
		}
	}

	orderDetail, err := json.Marshal(od)

	// 餐盒费
	if otInt > 2 {
		fo.BoxFee = boxFee
	}

	var vpData model.VoucherResult

	if form.VoucherId > 0 {
		// 优惠券 先判断优惠券是否存在
		vp := model.VoucherPost{}
		vpData, err = vp.Show([]string{"p.user_id = ? AND p.mid = ? AND p.id = ?"}, []interface{}{mpUserId, mid, form.VoucherId})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if vpData.Id == 0 {
			rest.rc.Error(c, "优惠券不存在！", nil)
			return
		}

		if vpData.Status == 2 {
			rest.rc.Error(c, "优惠券已过期！", nil)
			return
		}

		if vpData.Status == 1 {
			rest.rc.Error(c, "优惠券已使用！", nil)
			return
		}

		couponFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", vpData.Amount), 64)

		if fee < couponFee {
			rest.rc.Error(c, "非法，该优惠券未达到使用门槛！", nil)
			return
		}

		fo.VoucherId = vpData.Id

	}

	// 最终售价
	fmt.Println("fee", fee)
	fmt.Println("boxFee", boxFee)
	fmt.Println("CouponFee", couponFee)

	fee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", fee), 64)
	fo.BoxFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", fo.BoxFee), 64)

	fo.CouponFee = couponFee
	fo.Fee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", fee+boxFee-couponFee), 64)

	fo.Remark = form.Remark

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	fo.OrderDetail = string(orderDetail)

	currentTime := time.Now().Unix()

	fo.CreateAt = currentTime

	fo.OrderId = orderId

	// 企业主体
	businessJson := saasModel.Options("business_info", mid.(int))
	bi := model.BusinessInfo{}
	_ = json.Unmarshal([]byte(businessJson), &bi)

	originalFee := fee + boxFee
	totalFee := fee + boxFee - couponFee

	/*
	 * 判断用户是否开通会员
	 * 1.享受会员卡优惠
	 * 2.增送增加积分
	 * 3.赠送增加经验
	 */

	msg := ""
	var data interface{}

	var rechargeLog appModel.RechargeLog
	var pf feieModel.PrinterFormat
	var bp balancePay

	switch form.PayType {
	case "balance":

		// 完成余额支付 (菜品 + 餐盒费 + 运费 - 优惠券)
		balance := u.Balance

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if balance < totalFee {
			rest.rc.Error(c, "余额不足，请先充值！", nil)
			return
		}

		nowUnix := time.Now().Unix()
		fo.PayType = "balance"
		fo.Fee = totalFee
		fo.CreateAt = nowUnix
		fo.FinishedAt = nowUnix
		fo.OrderStatus = "TRADE_SUCCESS"

		address := ""
		name := ""
		mobile := form.Mobile
		if otInt == 4 {

			addr := model.Address{}
			tx := cmf.NewDb().Where("id = ?", form.AddressId).First(&addr)

			if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			if tx.RowsAffected == 0 {
				rest.rc.Error(c, "地址不存在！", nil)
				return
			}

			address = addr.Address + addr.Room
			nameRune := []rune(addr.Name)
			name = string(nameRune[:1])
			mobile = strconv.Itoa(addr.Mobile)

		}

		queueNo := ""
		if otInt > 1 {
			// 生成取餐号
			queueNo = model.QueueNo(appId.(string))
		}

		fo.QueueNo = queueNo

		pContent := new(base.Printer).Format58Printer(printOrder)

		pf = feieModel.PrinterFormat{
			OrderType:   otInt,
			StoreName:   store.StoreName,
			PayType:     "balance",
			QueueNo:     queueNo,
			OrderDetail: pContent,
			CouponFee:   strconv.FormatFloat(couponFee, 'f', -1, 64),
			OriginalFee: strconv.FormatFloat(originalFee, 'f', -1, 64),
			Fee:         strconv.FormatFloat(fo.Fee, 'f', -1, 64),
			Address:     address,
			Name:        name,
			Mobile:      mobile,
		}

		content := pf.Format("58mm")

		cmfLog.LogSave(content, "/log/test.log")

		// 获取门店打印机状态
		p, err := new(model.Printer).Show([]string{"store_id = ? AND mid = ?"}, []interface{}{storeId, mid})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		// 支付日志

		fee := strconv.FormatFloat(totalFee, 'f', -1, 64)
		balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

		rechargeLog = appModel.RechargeLog{
			UserId:   userId,
			Type:     1,
			Fee:      fee,
			Balance:  balanceStr,
			Remark:   "余额支付",
			CreateAt: nowUnix,
		}

		audio := ""
		if otInt < 4 {
			audio = "https://v.hji5.com/codecloud/n1.mp3"
		} else {
			audio = "https://v.hji5.com/codecloud/n2.mp3"
		}

		bp = balancePay{
			orderType:    otInt,
			alipayUserId: mpUserId.(int),
			voucherId:    form.VoucherId,
			totalFee:     totalFee,
			sn:           p.Sn,
			content:      content,
			noticeTitle:  noticeTitle,
			audio:        audio,
		}

		msg = "支付成功"

	case "alipay":

		if vpData.SyncToAlipay == 1 {
			// 使用卡券优惠金额
			totalFee = fee + boxFee
		}

		if mpType == "alipay" {
			common := payment.Common{}
			bizContent := make(map[string]interface{}, 0)
			bizContent["out_trade_no"] = orderId

			// 测试模板
			flag := new(appModel.TestAppId).InList(appId.(string))
			if flag {
				bizContent["total_amount"] = 0.01
			} else {
				bizContent["total_amount"] = totalFee
			}

			// bizContent["discountable_amount"] = couponFee  //https://opensupport.alipay.com/support/helpcenter/99/201602508884?ant_source=zsearch
			bizContent["timeout_express"] = "10m"

			if store.StoreNumber > 0 {
				bizContent["store_id"] = store.StoreNumber
			}

			bizContent["subject"] = bi.BrandName
			bizContent["body"] = bi.BrandName + "点餐"
			bizContent["buyer_id"] = Openid
			bizContent["goods_detail"] = aliDetail
			bizContent["product_code"] = "FACE_TO_FACE_PAYMENT"

			extendParams := map[string]string{
				"food_order_type": foodOrderType,
			}

			bizContent["extend_params"] = extendParams

			result := common.Create(bizContent)

			if result.Response.Code == "10000" {
				fo.PayType = "alipay"
				fo.TradeNo = result.Response.TradeNo
				msg = "创建成功！"
			} else {
				rest.rc.Error(c, "创建失败！", result.Response)
				return
			}
		} else {
			rest.rc.Error(c, "环境异常，非支付宝小程序！", nil)
			return
		}

	default:
		rest.rc.Error(c, "支付类型错误！", nil)
		return
	}

	storeData, err := fo.Store()
	if err != nil {
		rest.rc.Error(c, "创建失败！", err.Error())
		return
	}

	if fo.PayType == "balance" {

		err := bp.submit()
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		rechargeLog.TargetId = storeData.Id
		rechargeLog.TargetType = 0
		cmf.NewDb().Create(&rechargeLog)

	}

	if data == nil {
		if vpData.SyncToAlipay == 1 {
			storeData.TotalAmount = storeData.TotalAmount - vpData.Amount
		}
		data = storeData
	}

	// 保存到订单详情表
	tx := cmf.NewDb().Create(&foodOrderDetail)
	if tx.Error != nil {
		rest.rc.Error(c, "保存订单失败！", tx.Error)
		return
	}

	rest.rc.Success(c, msg, data)
}

func (b balancePay) submit() error {

	// 获取当前会员信息
	u, err := new(model.User).GetMpUser(b.alipayUserId)
	if err != nil {
		cmfLog.Error(err.Error())
		return err
	}

	balance := u.Balance

	// 消费更改余额
	balanceDecimal := decimal.NewFromFloat(balance).Sub(decimal.NewFromFloat(b.totalFee))
	balance, _ = balanceDecimal.Round(2).Float64()

	tx := cmf.NewDb().Model(&u).Where("id = ?", b.alipayUserId).Updates(map[string]interface{}{
		"balance": balance,
	})

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

	// 标记优惠券为已使用
	cmf.NewDb().Model(&model.VoucherPost{}).Where("id = ?", b.voucherId).Update("status", 1)

	//new(base.Printer).Printer(b.sn, b.content, "1")
	// 创建通知提醒
	_, err = new(appModel.AdminNotice).Save(b.noticeTitle, "", 0, b.audio)

	if err != nil {
		return tx.Error
	}

	return nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 订单支付成功回调
 * @Date 2020/11/30 19:36:5
 * @Param
 * @return
 **/

func (rest *Order) ReceiveNotify(c *gin.Context) {

	mid, _ := c.Get("mid")

	req := c.Request
	_ = req.ParseForm()

	// 获取订单id
	param := req.Form
	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	getParams = getParams[:len(getParams)-1]
	cmfLog.Info(getParams)

	inParam := make(map[string]string, 0)

	for k, v := range param {
		item := strings.Join(v, "")
		if k == "sign" || k == "sign_type" || item == "" {
			continue
		}
		inParam[k] = item
	}

	sign := strings.ReplaceAll(strings.Join(param["sign"], ""), " ", "+")

	encode := easyUtil.SortParam(inParam)

	err := easyUtil.AliVerifySign(encode, sign)

	if err != nil {
		rest.rc.Error(c, "非法访问！", err.Error())
		return
	}

	// 解析回调参数
	orderId := strings.Join(param["out_trade_no"], "")
	tradeNo := strings.Join(param["trade_no"], "")
	appId := strings.Join(param["auth_app_id"], "")

	ra := strings.Join(param["receipt_amount"], "")
	raFloat, err := strconv.ParseFloat(ra, 64)
	if err != nil {
		fmt.Println("raFloat", err.Error())
	}

	ia := strings.Join(param["invoice_amount"], "")
	iaFloat, err := strconv.ParseFloat(ia, 64)
	if err != nil {
		fmt.Println("iaFloat", err.Error())
	}

	bpa := strings.Join(param["buyer_pay_amount"], "")
	bpaFloat, err := strconv.ParseFloat(bpa, 64)
	if err != nil {
		fmt.Println("bpaFloat", err.Error())
	}

	pa := strings.Join(param["point_amount"], "")
	paFloat, err := strconv.ParseFloat(pa, 64)
	if err != nil {
		fmt.Println("paFloat", err.Error())
	}

	ta := strings.Join(param["total_amount"], "")
	taFloat, err := strconv.ParseFloat(ta, 64)
	if err != nil {
		fmt.Println("taFloat 462", err.Error())
	}

	reg := regexp.MustCompile(`[a-zA-Z]+`)
	prefix := reg.FindString(orderId)

	buyerId := strings.Join(param["buyer_id"], "")
	sellerId := strings.Join(param["seller_id"], "")

	var (
		audio       string
		noticeTitle string
		userId      int
		rPoint      int // 设置的成长值返点 1.储值 => 2.消费
		fo          model.FoodOrder
	)

	switch prefix {
	case "vip":
		// 支付开卡
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 获取订单号
			co := model.MemberCardOrder{}
			tx := cmf.NewDb().Where("order_id = ?", orderId).First(&co)
			if tx.Error != nil {
				cmfLog.Error(tx.Error.Error())
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 获取会员
			card := model.CardTemplate{}
			cmf.NewDb().Where("id = ? AND status  = ?", "1", "1").First(&card)

			validPeriod := card.ValidPeriod
			validPeriodUnix := validPeriod * 86400

			vip := model.MemberCard{
				EndAt:  time.Now().Unix() + int64(validPeriodUnix),
				Status: 1,
			}

			cmf.NewDb().Where("vip_num = ?", co.VipNum).Updates(vip)

			// 修改订单状态
			cmf.NewDb().Where("order_id = ?", orderId).Updates(&model.MemberCardOrder{
				FinishedAt:  time.Now().Unix(),
				OrderStatus: "TRADE_FINISHED",
			})

			// 订单
			mco := model.MemberCardOrder{}
			cmf.NewDb().Where("order_id", orderId).First(&mco)

			// 获取用户id
			userId = mco.UserId

			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["amount"] = taFloat
			bizContent["pay_amount"] = bpaFloat

			var itemOrderInfo []map[string]interface{}

			ioInfo := map[string]interface{}{
				"item_id":    "vipCard",
				"item_name":  "会员服务",
				"unit_price": taFloat,
				"quantity":   "1",
			}

			itemOrderInfo = append(itemOrderInfo, ioInfo)
			bizContent["item_order_list"] = itemOrderInfo

			extInfo := []map[string]string{
				{
					"ext_key":   "tiny_app_id",
					"ext_value": appId,
				},
				{
					"ext_key":   "merchant_order_status",
					"ext_value": "MERCHANT_PAID",
				},
				{
					"ext_key":   "merchant_order_link_page", // 小程序订单详情页
					"ext_value": "pages/mine/index",
				},
				{
					"ext_key":   "business_info",
					"ext_value": `{"rebate_pid":"2088831869964613"}`, // 返佣pid
				},
				{
					"ext_key":   "merchant_biz_type",
					"ext_value": "qr_food_order",
				},
			}
			bizContent["ext_info"] = extInfo

			result := new(merchant.Order).Sync(bizContent)
			if result.Response.Code != "10000" {
				rest.rc.Error(c, "同步小程序订单失败！"+result.Response.SubMsg, nil)
				return
			}

		}

	case "recharge":
		// 支付充值
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 获取订单号
			ro := model.RechargeOrder{}
			tx := cmf.NewDb().Where("order_id = ?", orderId).First(&ro)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			userId = ro.UserId

			totalFloat := ro.Fee

			fmt.Println("totalFloat", totalFloat)

			recJson := saasModel.Options("recharge", mid.(int))
			if json.Valid([]byte(recJson)) {

			}

			var recharge []model.Recharge
			_ = json.Unmarshal([]byte(recJson), &recharge)

			// 充值规则
			if len(recharge) == 0 {

			}

			maxGear := recharge[len(recharge)-1]

			// 充值档次
			var (
				money  float64 = 0
				tMoney float64 = 0
				tScore         = 0 // 成长值
			)

			// 最高档
			if totalFloat > maxGear.Gear {

				// 符合最高档次的次数
				frequency := totalFloat / maxGear.Gear
				frequency = math.Floor(frequency)
				if frequency == 0 {
					frequency = 1
				}

				tMoney = frequency * (maxGear.Money)      //
				tScore = int(frequency) * (maxGear.Score) //

				// 排除最高档次后的符合档次
				remainder := totalFloat - (frequency * maxGear.Gear)
				remainder, reScore := rechargeSend(remainder, userId, recharge)
				if remainder > 0 {
					tMoney += remainder
					tScore += reScore
				}
			} else {
				tMoney, tScore = rechargeSend(totalFloat, userId, recharge)
			}

			// 开启充值送
			if maxGear.EnabledMoney == 1 {
				money = tMoney
			}

			if maxGear.EnabledScore == 1 {
				rPoint = tScore
			}

			money += totalFloat

			tx = cmf.NewDb().Model(&ro).Where("order_id = ?", orderId).Updates(&model.RechargeOrder{
				ActualFee:   money,
				SendFee:     tMoney,
				OrderStatus: "TRADE_FINISHED",
			})
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 充值余额
			user := model.User{}
			tx = cmf.NewDb().Where("id = ?", ro.UserId).First(&user)
			if tx.Error != nil {
				cmfLog.Error(tx.Error.Error())
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}
			user.Id = ro.UserId
			// 增加余额
			balance := user.Balance + money
			user.Balance = balance

			tx = cmf.NewDb().Updates(&user)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 余额日志
			moneyStr := strconv.FormatFloat(money, 'f', -1, 64)
			tMoneyStr := strconv.FormatFloat(tMoney, 'f', -1, 64)
			balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

			rechargeLog := appModel.RechargeLog{
				UserId:   userId,
				Type:     0,
				Fee:      moneyStr,
				Balance:  balanceStr,
				Remark:   "余额储值（含赠送" + tMoneyStr + "元）",
				CreateAt: time.Now().Unix(),
			}

			cmf.NewDb().Create(&rechargeLog)

			// 根据订单号获取支付日志
			orderId := orderId
			tradeNo := tradeNo

			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["seller_id"] = sellerId
			bizContent["amount"] = taFloat
			bizContent["pay_amount"] = bpaFloat

			var itemOrderInfo []map[string]interface{}

			ioInfo := map[string]interface{}{
				"item_id":    "recharge",
				"item_name":  "钱包充值",
				"unit_price": totalFloat,
				"quantity":   "1",
			}

			itemOrderInfo = append(itemOrderInfo, ioInfo)
			bizContent["item_order_list"] = itemOrderInfo

			extInfo := []map[string]string{
				{
					"ext_key":   "tiny_app_id",
					"ext_value": appId,
				},
				{
					"ext_key":   "merchant_order_status",
					"ext_value": "MERCHANT_PAID",
				},
				{
					"ext_key":   "merchant_order_link_page", // 小程序订单详情页
					"ext_value": "pages/order/recharge/index",
				},
				{
					"ext_key":   "business_info",
					"ext_value": `{"rebate_pid":"2088831869964613"}`, // 返佣pid
				},
				{
					"ext_key":   "merchant_biz_type",
					"ext_value": "qr_food_order",
				},
			}
			bizContent["ext_info"] = extInfo

			result := new(merchant.Order).Sync(bizContent)
			if result.Response.Code != "10000" {
				rest.rc.Error(c, "同步小程序订单失败！"+result.Response.SubMsg, nil)
				return
			}
		}
	case "T":
		audio = "https://v.hji5.com/codecloud/n1.mp3"
		noticeTitle = "堂食订单通知"
		fallthrough
	case "W":
		// 支付成功
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 生成取餐号
			queueNo := model.QueueNo(appId)

			fmt.Println("queueNo", queueNo)

			// 查询订单
			tx := cmf.NewDb().Where("order_id", orderId).First(&fo)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 修改订单状态
			cmf.NewDb().Model(&model.FoodOrder{}).Where("order_id = ?", orderId).Updates(map[string]interface{}{"queue_no": queueNo, "order_status": "TRADE_SUCCESS"})

			userId = fo.UserId
			orderType := fo.OrderType

			// 获取订单门店
			storeId := fo.StoreId
			// 获取门店信息
			store := model.Store{}
			tx = cmf.NewDb().Where("id = ?", storeId).First(&store)
			if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 查询订单列表
			var fod []model.FoodOrderDetail
			cmf.NewDb().Where("order_id", orderId).Find(&fod)

			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["seller_id"] = sellerId
			bizContent["amount"] = taFloat
			bizContent["pay_amount"] = bpaFloat

			var itemOrderInfo []map[string]interface{}
			var printOrder = make([]map[string]string, 0)

			for _, v := range fod {

				var fodExtInfo = []map[string]string{
					{
						"ext_key":   "image_material_id",
						"ext_value": v.AlipayMaterialId,
					},
					{
						"ext_key":   "flavor",
						"ext_value": v.Flavor,
					},
					{
						"ext_key":   "dish_type",
						"ext_value": v.DishType,
					},
					{
						"ext_key":   "cooking_method",
						"ext_value": v.CookingMethod,
					},
				}

				ioInfo := map[string]interface{}{
					"item_id":    v.Code,
					"item_name":  v.FoodName,
					"unit_price": v.Price,
					"quantity":   v.Count,
					"ext_info":   fodExtInfo,
				}

				if v.SkuId == 0 {
					ioInfo["sku_id"] = v.FoodId
				}
				itemOrderInfo = append(itemOrderInfo, ioInfo)

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
			bizContent["item_order_list"] = itemOrderInfo

			extInfo := []map[string]string{
				{
					"ext_key":   "tiny_app_id",
					"ext_value": appId,
				},
				{
					"ext_key":   "merchant_order_status",
					"ext_value": "MERCHANT_PAID",
				},
				{
					"ext_key":   "merchant_order_link_page", // 小程序订单详情页
					"ext_value": "pages/order/detail?id=" + strconv.Itoa(fo.Id),
				},
				{
					"ext_key":   "business_info",
					"ext_value": `{"rebate_pid":"2088831869964613"}`, // 返佣pid
				},
				{
					"ext_key":   "merchant_biz_type",
					"ext_value": "qr_food_order",
				},
			}
			bizContent["ext_info"] = extInfo

			shopInfo := map[string]interface{}{
				"name":      store.StoreName,
				"address":   store.Address,
				"phone_num": store.Phone,
			}

			if store.ShopId != "" {
				shopInfo["merchant_shop_id"] = store.ShopId
			}

			// 门店信息
			bizContent["shop_info"] = shopInfo

			result := new(merchant.Order).Sync(bizContent)
			if result.Response.Code != "10000" {
				rest.rc.Error(c, "同步小程序订单失败！"+result.Response.SubMsg, nil)
				return
			}

			if noticeTitle == "" {
				audio = "https://v.hji5.com/codecloud/n2.mp3"
				noticeTitle = "外卖订单提醒"
			}

			// 保存通知
			_, err = new(appModel.AdminNotice).Save(noticeTitle, "", 0, audio)

			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			// 打印机打印订单
			pContent := new(base.Printer).Format58Printer(printOrder)

			pf := feieModel.PrinterFormat{
				OrderType:   orderType,
				StoreName:   store.StoreName,
				PayType:     "alipay",
				QueueNo:     queueNo,
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

			cmfLog.LogSave(content, "/log/test.log")

			// 获取门店打印机状态
			p := model.Printer{}
			p, err = p.Show([]string{"store_id = ? AND mid = ?"}, []interface{}{storeId, mid})
			if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			if p.Id > 0 {
				/*myResult := new(base.Printer).Printer(p.Sn, content, "1")
				fmt.Println("myResult", myResult)*/
			} else {
				fmt.Println("请先绑定打印机！")
			}

		}
	}

	if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

		// 获取当前会员信息

		u, err := new(model.User).GetMpUser(userId)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		/*
			1.积分
			2.经验
			判断用户的会员卡状态
			是否开启了消费送经验
		*/

		if prefix != "vip" {

			score := u.Score
			tScore := 0
			scoreJson := saasModel.Options("score", mid.(int))
			scoreMap := model.Score{}
			_ = json.Unmarshal([]byte(scoreJson), &scoreMap)

			totalFee, _ := strconv.Atoi(ta)

			if totalFee == 0 {
				totalFee = int(fo.Fee)
			}

			// 启用消费返积分
			if scoreMap.EnabledPay == 1 {
				tScore = scoreMap.PayScore * totalFee
			}

			score += tScore

			/* -- 经验 -- */
			exp := u.Exp

			point := 0
			remark := ""

			// 储值还是消费
			if prefix == "recharge" {
				remark = "储值"
				point = rPoint
			} else {
				remark = "消费"

				if u.Level != nil && u.Level.Benefit.EnabledPoint == 1 {
					point = u.Level.Benefit.Point * totalFee
				}
			}

			exp += point

			// 保存到数据库
			sLog := appModel.ScoreLog{
				UserId: u.Id,
				Score:  tScore,
				Fee:    ta,
				Remark: remark,
			}

			// 达到消费门槛1元
			fmt.Println("totalFee", totalFee)
			if totalFee > 1 {
				err = sLog.Save()
				if err != nil {
					rest.rc.Error(c, err.Error(), nil)
					cmfLog.Error(err.Error())
					return
				}
			}

			eLog := appModel.ExpLog{
				UserId: u.Id,
				Exp:    point,
				Fee:    ta,
				Remark: remark,
			}

			if score > 0 {
				err = eLog.Save()
				if err != nil {
					rest.rc.Error(c, err.Error(), nil)
					return
				}
			}

			tx := cmf.NewDb().Model(&u).Where("id = ?", u.Id).Updates(map[string]interface{}{
				"score": score,
				"exp":   exp,
			})

			if tx.Error != nil {
				cmfLog.Error(tx.Error.Error())
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}
		}

		payLog := appModel.PayLog{
			OrderId:     orderId,
			TradeNo:     tradeNo,
			Type:        "alipay",
			AppId:       appId,
			TotalAmount: taFloat,
		}

		payLog.UserId = userId
		payLog.BuyerId = buyerId
		payLog.ReceiptAmount = raFloat
		payLog.InvoiceAmount = iaFloat
		payLog.BuyerPayAmount = bpaFloat
		payLog.PointAmount = paFloat
		payLog.Subject = strings.Join(param["subject"], "")
		payLog.Body = strings.Join(param["body"], "")

		gpUnix, err := time.ParseInLocation("2006-01-02 15:04:05", strings.Join(param["gmt_payment"], ""), time.Local)
		if err != nil {
			fmt.Println("gmtUnixErr", err.Error())
			return
		}
		payLog.GmtPayment = gpUnix.Unix()

		payLog.TradeStatus = strings.Join(param["trade_status"], "")

		fbl := strings.Join(param["fund_bill_list"], "")

		if fbl == "" {
			fbl = "{}"
		}

		payLog.FundBillList = fbl

		// 存入
		cmf.NewDb().Create(&payLog)
	}

	c.String(http.StatusOK, "success")
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 计算充值送金额
 * @Date 2021/1/2 10:13:1
 * @Param
 * @return
 **/
func rechargeSend(totalFloat float64, userId int, recharge []model.Recharge) (money float64, point int) {

	var vPost []model.VoucherPost
	nowUnix := time.Now().Unix()
	for _, v := range recharge {
		if totalFloat >= v.Gear {
			money = 0
			point = 0
			// 赠送余额
			if v.EnabledMoney == 1 {
				money = v.Money
			}

			// 增送积分
			if v.EnabledScore == 1 {
				point = v.Score
			}

			// 赠送优惠券
			if v.EnabledVoucher == 1 {
				vPost = make([]model.VoucherPost, 0)
				for _, voucher := range v.Voucher {
					mv := model.Voucher{}
					vp := marketing.VoucherValidPeriod{}
					data, err := mv.Show([]string{"id = ? AND status = ?"}, []interface{}{voucher.VoucherId, 1})
					if err != nil {
						cmfLog.Error("rechargeSend" + err.Error())
						return 0, 0
					}
					_ = json.Unmarshal([]byte(data.VoucherValidPeriod), &vp)
					var validEndAt int64
					if vp.Type == "ABSOLUTE" {
						tmp, _ := time.ParseInLocation("2006-01-02 15:04:05", vp.End, time.Local)
						validEndAt = tmp.Unix()
					} else {
						unix := 0
						switch vp.Unit {
						case "MINUTE":
							unix = 60 * vp.Duration
						case "HOUR":
							unix = 3600 * vp.Duration
						case "DAY":
							unix = 86400 * vp.Duration
						}

						validEndAt = nowUnix + int64(unix)
					}

					vPost = append(vPost, model.VoucherPost{
						VoucherId:    data.Id,
						TemplateId:   data.TemplateId,
						VoucherName:  data.VoucherName,
						ValidStartAt: nowUnix,
						ValidEndAt:   validEndAt,
						UserId:       userId,
						CreateAt:     nowUnix,
						UpdateAt:     nowUnix,
					})
				}
			}
		}
	}

	//发送优惠券
	cmf.NewDb().Create(&vPost)
	// 推送到支付宝卡包
	for _, v := range vPost {
		tp := appModel.UserPart{}
		tpData, err := tp.Show([]string{"u.id = ? AND tp.type = ? AND u.user_status = ?"}, []interface{}{v.UserId, "alipay-mp", 1})
		if err != nil {
			cmfLog.Error("rechargeSend" + err.Error())
			return 0, 0
		}
		new(model.Voucher).Send(v.TemplateId, tpData.OpenId, v.VoucherName)
	}

	return money, point
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 取消订单
 * @Date 2021/2/19 22:49:39
 * @Param
 * @return
 **/

func (rest *Order) Cancel(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	// 默认获取当天的，history获取历史的
	var query = []string{"mid = ?", "id = ?", "order_status = ?"}
	var queryArgs = []interface{}{mid, rewrite.Id, "WAIT_BUYER_PAY"}

	order := model.FoodOrder{}
	_, err := order.Show(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 更新订单状态

	foodOrder := model.FoodOrder{
		OrderStatus: "TRADE_CLOSED",
	}

	queryStr := strings.Join(query, " AND ")

	tx := cmf.NewDb().Debug().Where(queryStr, queryArgs...).Updates(foodOrder)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "取消成功！", nil)

}
