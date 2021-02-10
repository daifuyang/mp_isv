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
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
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
	Sku      []sku      `json:"sku"`
	Tasty    []tasty    `json:"tasty"`
	Material []material `json:"material"`
}

type sku struct {
	SkuId     int        `json:"sku_id"`
	SkuDetail string     `json:"sku_detail"`
	SkuFee    float64    `json:"sku_fee"`
	Count     int        `json:"count"`
	Tasty     []tasty    `json:"tasty"`
	Material  []material `json:"material"`
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
	var query = []string{"TO_DAYS(fo.create_at) = TO_DAYS(NOW())"}
	var queryArgs []interface{}

	now := time.Now()
	now.AddDate(0, 0, -1)
	yesterday := now.Unix()

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

	Openid, _ := c.Get("open_id")
	storeId, _ := c.Get("store_id")
	mpType, _ := c.Get("mp_type")
	appId, _ := c.Get("app_id")
	if appId == 0 {
		rest.rc.Error(c, "小程序app_id不正确！", nil)
		return
	}

	var form struct {
		OrderType       int           `json:"order_type"`
		DeskId          int           `json:"desk_id"`
		Mobile          string        `json:"mobile"`
		AppointmentTime string        `json:"appointment_time"`
		OrderDetail     []orderDetail `json:"order_detail"`
		BoxFee          float64       `json:"box_fee"`
		DeliveryFee     float64       `json:"delivery_fee"`
		VoucherId       int           `json:"voucher_id"`
		Remark          string        `json:"remark"`
		AddressId       int           `json:"address_id"`
		PayType         string        `json:"pay_type"` // balance 和 alipay
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
	tx := cmf.NewDb().Where("id = ?", storeId).First(&store)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	otInt := 0

	// 通知标题
	noticeTitle := ""

	// 订单类型标题
	orderType := "堂食"

	// 订单内容
	content := ""

	foodOrderType := "qr_order"
	switch form.OrderType {

	case 1:
		otInt = 1
		noticeTitle = "堂食订单通知"
		foodOrderType = "qr_order"
		// 如果的是堂食扫码点餐

		// 商家开启了桌号
		et, err := new(model.EatIn).Show(storeId.(int), mid.(int))

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		deskId := 0

		deskId = form.DeskId // 桌号
		if deskId == 0 {
			rest.rc.Error(c, "桌号不能为空！", nil)
			return
		}

		// 如果是餐前模式
		if et.SaleType == 0 {
			if et.EatType == 0 {

			}
		}

		// 添加桌号
		fo.DeskId = deskId

	case 2:
		otInt = 2
		noticeTitle = "堂食订单通知"
		foodOrderType = "pre_order"
		// 如果的是堂食到店就餐
		appointmentTime := form.AppointmentTime
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
		AppointmentTime := form.AppointmentTime //预约时间
		fo.AppointmentTime = AppointmentTime

	case 4:
		otInt = 4
		noticeTitle = "外卖订单通知"
		orderType = "外卖"
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

	content = "<CB>" + orderType + "</CB><BR>"
	content += "<C>**" + store.StoreName + "**</C><BR>"

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

	appIdInt, _ := appId.(int)
	appIdStr := strconv.Itoa(appIdInt)

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + appIdStr + ":order:" + date

	orderId := util.DateUuid(ident, insertKey, date)

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
		var materialFee float64

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

				price, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", m.MaterialPrice*count), 64)

				if price < 0 {
					rest.rc.Error(c, "商品结算价格非法！", nil)
					return
				}

				materialMap = append(materialMap, material{
					Id:            m.Id,
					Count:         item.Count,
					MaterialName:  m.MaterialName,
					MaterialPrice: price,
				})

				materialContent = append(materialContent, m.MaterialName)

				materialFee += price

				fee += price

			}
		}

		materialJson,err := json.Marshal(materialMap)
		fod.Material = string(materialJson)

		// 口味 (待完善)
		tastyJson,err := json.Marshal(v.Tasty)
		fod.Tasty = string(tastyJson)

		// 是否启用规格
		if foodData.UseSku == 1 {
			// 获取规格详情
			for _, skuItem := range v.Sku {

				// 打印单项详情
				var printOrderItem = make(map[string]string, 0)

				foodSku := model.FoodSku{}
				skuData, err := foodSku.Detail([]string{"sku_id = ?"}, []interface{}{skuItem.SkuId})

				if err != nil {
					if errors.Is(err, gorm.ErrRecordNotFound) {
						rest.rc.Error(c, v.Name+skuItem.SkuDetail+"不存在或已下架！", nil)
						return
					}
					rest.rc.Error(c, err.Error(), nil)
					return
				}

				if skuData.Inventory == 0 {
					rest.rc.Error(c, v.Name+skuItem.SkuDetail+"库存不足，请删除重新下单！", nil)
					return
				}

				if skuData.Price != skuItem.SkuFee {
					rest.rc.Error(c, "价格变动，请重新下单！", nil)
					return
				}

				code := skuData.Code
				if code == "" {
					code = strconv.Itoa(v.FoodId) + "-" + strconv.Itoa(skuItem.SkuId)
				}

				aliDetail = append(aliDetail, payment.GoodsDetail{
					GoodsId:   code,
					GoodsName: v.Name,
					Quantity:  strconv.Itoa(skuItem.Count),
					Price:     skuItem.SkuFee,
					Body:      skuItem.SkuDetail,
				})

				count := float64(skuItem.Count)

				price, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", skuData.Price*count), 64)

				if price < 0 {
					rest.rc.Error(c, "商品结算价格非法！", nil)
					return
				}

				// 订单规格
				fod.Code = code
				fod.SkuId = skuData.SkuId
				fod.SkuDetail = skuData.SkuDetail
				fod.Count = skuItem.Count
				fod.Fee = price

				printOrderItem["title"] = foodData.Name + "-" + skuData.SkuDetail
				printOrderItem["count"] = strconv.Itoa(fod.Count)

				// 判断菜品是否启用会员价
				if skuData.UseMember == 1 {
					fod.UseMember = 1
					fod.MemberPrice = skuData.MemberPrice

					// 判断会员是否拥有专属折扣
					if u.Level != nil && u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {
						fod.MemberPrice = fod.MemberPrice * (u.Level.Benefit.Discount / 100)
					}

					printOrderItem["fee"] = strconv.FormatFloat(fod.Fee, 'f', -1, 64)
					fee += fod.MemberPrice

				} else {

					printOrderItem["fee"] = strconv.FormatFloat(fod.Fee, 'f', -1, 64)
					fee += price

				}

				printOrderItem["food_id"] = strconv.Itoa(fod.FoodId)

				if len(materialContent) > 0 {
					printOrderItem["fee"] += strconv.FormatFloat(fod.Fee+materialFee, 'f', -1, 64)
					printOrderItem["title"] = printOrderItem["title"] + "[" + strings.Join(materialContent, "+") + "]"
				}

				foodOrderDetail = append(foodOrderDetail, fod)
				printOrder = append(printOrder, printOrderItem)
			}

		} else {

			// 打印单项详情
			var printOrderItem = make(map[string]string, 0)

			code := foodData.FoodCode
			if code == "" {
				code = strconv.Itoa(v.FoodId)
			}

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   code,
				GoodsName: v.Name,
				Quantity:  strconv.Itoa(v.Count),
				Price:     v.Fee,
				Body:      v.Name,
			})

			if foodData.Inventory == 0 {
				rest.rc.Error(c, v.Name+"库存不足，请删除重新下单！", nil)
				return
			}

			/*if foodData.Price != v.Fee {
				rest.rc.Error(c, v.Name+"价格变动，请重新下单！", nil)
				return
			}*/

			count := float64(v.Count)
			price, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", foodData.Price*count), 64)

			if price < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			fod.Code = code
			fod.Count = v.Count
			fod.Fee = price

			printOrderItem["title"] = foodData.Name
			printOrderItem["count"] = strconv.Itoa(fod.Count)

			// 判断菜品是否启用会员价
			if foodData.UseMember == 1 {
				fod.UseMember = 1
				fod.MemberPrice = foodData.MemberPrice

				// 判断会员是否拥有专属折扣
				if u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {
					fod.MemberPrice = fod.MemberPrice * (u.Level.Benefit.Discount / 100)
				}

				printOrderItem["fee"] = strconv.FormatFloat(fod.Fee, 'f', -1, 64)

				fee += fod.MemberPrice

			} else {

				printOrderItem["fee"] = strconv.FormatFloat(fod.Fee, 'f', -1, 64)
				// 总价
				fee += price

			}

			printOrderItem["food_id"] = strconv.Itoa(fod.FoodId)

			if len(materialContent) > 0 {
				printOrderItem["fee"] += strconv.FormatFloat(fod.Fee+materialFee, 'f', -1, 64)
				printOrderItem["title"] = printOrderItem["title"] + "[" + strings.Join(materialContent, "+") + "]"
			}

			foodOrderDetail = append(foodOrderDetail, fod)
			printOrder = append(printOrder, printOrderItem)
		}

		if otInt > 2 {
			// 餐盒费
			boxFee += foodData.BoxFee
		}
	}

	orderDetail, err := json.Marshal(od)

	// 餐盒费
	if form.BoxFee > 0 && otInt > 2 {
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

		if vpData.Status == 0 {
			rest.rc.Error(c, "优惠券已过期！", nil)
			return
		}

		if vpData.Status == 2 {
			rest.rc.Error(c, "优惠券已使用！", nil)
			return
		}

		couponFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", vpData.Amount), 64)

		if fee < couponFee {
			rest.rc.Error(c, "非法，该优惠券未达到使用门槛！", nil)
			return
		}

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
	bi := settings.BusinessInfo{}
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
	switch form.PayType {
	case "balance":

		content += "<CB>--余额支付--</CB><BR>"

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

		// 消费更改余额
		balance = balance - totalFee
		tx := cmf.NewDb().Model(&u).Where("id = ?", mpUserId).Updates(map[string]interface{}{
			"balance": balance,
		})

		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		if otInt > 1 {
			// 生成取餐号
			queueNo := model.QueueNo(appIdStr)
			content += "<CB>取餐号：" + queueNo + "</CB><BR>"
			fo.QueueNo = queueNo
		}

		// 标记优惠券为已使用
		cmf.NewDb().Model(&model.VoucherPost{}).Where("id = ?", form.VoucherId).Update("status", 2)

		nowUnix := time.Now().Unix()
		fo.PayType = "balance"
		fo.Fee = totalFee
		fo.CreateAt = nowUnix
		fo.FinishedAt = nowUnix
		fo.OrderStatus = "TRADE_SUCCESS"

		// 打印订单
		content += "--------------------------------<BR>"
		pContent := new(base.Printer).Format58Printer(printOrder)
		if pContent != "" {
			content += pContent
		}

		content += "--------------------------------<BR>"

		// 优惠券
		content += "<RIGHT><BOLD>优惠券：￥" + strconv.FormatFloat(couponFee, 'f', -1, 64) + "</BOLD></RIGHT>"

		// 总价
		content += "<RIGHT>原价：￥" + strconv.FormatFloat(originalFee, 'f', -1, 64) + "</RIGHT>"
		content += "<RIGHT>(余额支付)：<B>￥" + strconv.FormatFloat(fo.Fee, 'f', -1, 64) + "</B></RIGHT>"

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

			address := addr.Address + addr.Room

			nameRune := []rune(addr.Name)
			name := string(nameRune[:1])
			content += "--------------------------------<BR>"
			content += "<B>" + address + "</B><BR>"
			content += "<B>[" + name + "**]</B><BR>"
			content += "<B>" + form.Mobile + "</B><BR>"
		}

		// 获取门店打印机状态
		p := model.Printer{}
		p, err = p.Show([]string{"store_id = ? AND mid = ?"}, []interface{}{storeId, mid})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		//new(base.Printer).Printer(p.Sn, content, "1")

		// 支付日志

		fee := strconv.FormatFloat(totalFee, 'f', -1, 64)
		balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

		rechargeLog := appModel.RechargeLog{
			UserId:   userId,
			Type:     1,
			Fee:      fee,
			Balance:  balanceStr,
			Remark:   "余额支付",
			CreateAt: nowUnix,
		}

		cmf.NewDb().Create(&rechargeLog)

		audio := ""
		if otInt < 4 {
			audio = "https://v.hji5.com/codecloud/n1.mp3"
		} else {
			audio = "https://v.hji5.com/codecloud/n2.mp3"
		}

		// 创建通知提醒
		_, err = new(appModel.AdminNotice).Save(noticeTitle, "", 0, audio)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
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
			bizContent["total_amount"] = 0.01
			//bizContent["total_amount"] = totalFee
			bizContent["timeout_express"] = "10m"
			bizContent["discountable_amount"] = couponFee

			if store.StoreNumber != 0 {
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

	if data == nil {

		if vpData.SyncToAlipay == 1 {
			storeData.TotalAmount = storeData.TotalAmount - vpData.Amount
		}

		data = storeData
	}

	// 保存到订单详情表
	tx = cmf.NewDb().Create(&foodOrderDetail)
	if tx.Error != nil {
		rest.rc.Error(c, "保存订单失败！", tx.Error)
		return
	}

	rest.rc.Success(c, msg, data)
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
	)

	switch prefix {
	case "vip":
		// 支付开卡
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 获取订单号
			co := model.MemberCardOrder{}
			tx := cmf.NewDb().Where("order_id = ?", orderId).First(&co)
			if tx.Error != nil {
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
			mc := model.MemberCard{}
			cmf.NewDb().Where("order_id", orderId).First(&mc)

			// 获取用户id
			userId = mc.UserId

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
				tPoint         = 0 // 成长值
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
				tPoint = int(frequency) * (maxGear.Point) //

				// 排除最高档次后的符合档次
				remainder := totalFloat - (frequency * maxGear.Gear)
				remainder, repoint := rechargeSend(remainder, userId, recharge)
				if remainder > 0 {
					tMoney += remainder
					tPoint += repoint
				}
			} else {
				tMoney, tPoint = rechargeSend(totalFloat, userId, recharge)
			}

			// 开启充值送
			if maxGear.EnabledMoney == 1 {
				money = tMoney
			}

			if maxGear.EnabledPoint == 1 {
				rPoint = tPoint
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
	case "T":
		audio = "https://v.hji5.com/codecloud/n1.mp3"
		noticeTitle = "堂食订单通知"
		fallthrough
	case "W":
		// 支付成功
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 生成取餐号
			queueNo := model.QueueNo(appId)

			// 修改订单状态
			cmf.NewDb().Model(&model.FoodOrder{}).Where("order_id = ?", orderId).Updates(map[string]interface{}{"queue_no": queueNo, "order_status": "TRADE_SUCCESS"})

			// 查询订单
			var fo model.FoodOrder
			cmf.NewDb().Where("order_id", orderId).First(&fo)
			userId = fo.UserId

			// 获取订单门店
			storeId := fo.StoreId
			// 获取门店信息
			store := model.Store{}
			tx := cmf.NewDb().Where("id = ?", storeId).First(&store)
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
					"unit_price": v.Fee,
					"quantity":   v.Count,
					"ext_info":   fodExtInfo,
				}

				if v.SkuId == 0 {
					ioInfo["sku_id"] = v.FoodId
				}
				itemOrderInfo = append(itemOrderInfo, ioInfo)

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
					"ext_value": "pages/order/index",
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

			// 门店信息
			bizContent["shop_info"] = map[string]interface{}{
				"merchant_shop_id": store.StoreNumber,
				"name":             store.StoreName,
				"address":          store.Address,
				"phone_num":        store.Phone,
			}

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

		score := u.Score
		tScore := 0
		scoreJson := saasModel.Options("score", mid.(int))
		scoreMap := model.Score{}
		_ = json.Unmarshal([]byte(scoreJson), &scoreMap)

		totalFee, _ := strconv.Atoi(ta)

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
			if u.Level.Benefit.EnabledPoint == 1 {
				point = u.Level.Benefit.Point * totalFee
			}
		}

		exp += point

		// 报错到数据库
		sLog := appModel.ScoreLog{
			UserId: u.Id,
			Score:  tScore,
			Fee:    ta,
			Remark: remark,
		}

		// 达到消费门槛1元
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
			if v.EnabledPoint == 1 {
				point = v.Point
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
