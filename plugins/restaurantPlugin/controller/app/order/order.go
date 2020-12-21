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
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	"github.com/gincmf/alipayEasySdk/merchant"
	"github.com/gincmf/alipayEasySdk/payment"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
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
	SkuId     int     `json:"sku_id"`
	SkuDetail string  `json:"sku_detail"`
	SkuFee    float64 `json:"sku_fee"`
	Count     int     `json:"count"`
}

type tasty struct {
	AttrKey   string `json:"attr_key"`
	AttrValue string `json:"attr_value"`
}

type material struct {
	Id            int     `json:"id"`
	Count         int     `json:"count"`
	MaterialName  string  `json:"material_name"`
	MaterialPrice float64 `json:"material_price"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部订单列表
 * @Date 2020/12/6 21:39:32
 * @Param
 * @return
 **/

func (rest *Order) Get(c *gin.Context) {

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
		Name            string        `json:"name"`
		Address         string        `json:"address"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	fo := model.FoodOrder{
		StoreId: storeId.(int),
		UserId:  mpUserId.(int),
	}

	otInt := 0

	foodOrderType := "qr_order"
	switch form.OrderType {

	case 1:
		otInt = 1
		foodOrderType = "qr_order"
		// 如果的是堂食扫码点餐
		desk := form.DeskId // 桌号
		if desk == 0 {
			rest.rc.Error(c, "桌号不能为空！", nil)
			return
		}

	case 2:
		otInt = 2
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
		foodOrderType = "qr_order"
		// 如果的是堂食打包外带
		AppointmentTime := form.AppointmentTime //预约时间
		fo.AppointmentTime = AppointmentTime

	case 4:
		otInt = 4
		foodOrderType = "home_delivery"
		// 如果是外卖
		//运费
		if form.DeliveryFee > 0 {
			fo.DeliveryFee = form.DeliveryFee
		}

		name := form.Name
		if name == "" {
			rest.rc.Error(c, "收货人姓名不能为空！", nil)
			return
		}

		fo.Name = name
		address := form.Address
		if address == "" {
			rest.rc.Error(c, "收货人地址不能为空！", nil)
			return
		}
		fo.Address = address

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

	for _, v := range od {

		fod := model.FoodOrderDetail{}

		foodId := v.FoodId
		food := model.Food{}
		foodData, err := food.Show([]string{"id = ? AND delete_at = ?"}, []interface{}{foodId, 0})
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

		// 是否启用规格
		if foodData.UseSku == 1 {
			// 获取规格详情
			for _, skuItem := range v.Sku {

				foodSku := model.FoodSku{}
				skuData, err := foodSku.Show([]string{"sku_id = ?"}, []interface{}{skuItem.SkuId})
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
				fmt.Println("count", count)
				price, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", skuData.Price*count), 64)

				if price < 0 {
					rest.rc.Error(c, "商品结算价格非法！", nil)
					return
				}

				// 订单规格
				fod.Code = code
				fod.SkuId = skuData.SkuId
				fod.SkuDetail = skuItem.SkuDetail
				fod.Count = skuItem.Count
				fod.Fee = price

				fee += price
			}

		} else {

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

			if foodData.Price != v.Fee {
				rest.rc.Error(c, v.Name+"价格变动，请重新下单！", nil)
				return
			}

			count := float64(v.Count)
			price, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", foodData.Price*count), 64)

			if price < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			fod.Code = code
			fod.Count = v.Count
			fod.Fee = price

			fee += price
		}

		foodOrderDetail = append(foodOrderDetail, fod)

		// 加料
		if foodData.UseMaterial == 1 {

			for _, item := range v.Material {

				m := model.FoodMaterialPost{}
				result := cmf.NewDb().Where("id = ?", item.Id).First(&m)
				if result.Error != nil {
					if errors.Is(result.Error, gorm.ErrRecordNotFound) {
						rest.rc.Error(c, item.MaterialName+"加料已下架，请删除重新下单！", nil)
						return
					}
					rest.rc.Error(c, err.Error(), nil)
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

				fee += price

			}
		}

		if otInt > 2 {
			// 餐盒费
			boxFee += foodData.BoxFee
		}

	}

	orderDetail, err := json.Marshal(od)

	// 餐盒费
	fmt.Println("otInt", otInt)
	if form.BoxFee > 0 && otInt > 2 {
		fo.BoxFee = form.BoxFee
	}

	if form.VoucherId > 0 {
		// 优惠券 先判断优惠券是否存在
		vp := model.VoucherPost{}
		vpData, err := vp.Show([]string{"p.user_id = ? AND p.id = ?"}, []interface{}{mpUserId, form.VoucherId})
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		couponFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", vpData.Amount), 64)
		if vpData.SyncToAlipay == 1 {
			couponFee = 0
		}
	}

	// 最终售价
	fmt.Println("fee", fee)
	fmt.Println("boxFee", fo.BoxFee)
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
	businessJson := appModel.Options("business_info")
	bi := settings.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)
	// 支付宝小程序下单
	if mpType == "alipay" {

		common := payment.Common{}
		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = orderId
		//bizContent["total_amount"] = 0.01
		bizContent["total_amount"] = fo.Fee
		bizContent["discountable_amount"] = fo.CouponFee
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

		} else {
			rest.rc.Error(c, "创建失败！", result.Response)
			return
		}
	}

	data, err := fo.Store()
	if err != nil {
		rest.rc.Error(c, "创建失败！", err.Error())
		return
	}

	// 保存到订单详情表
	tx := cmf.NewDb().Create(&foodOrderDetail)
	if tx.Error != nil {
		rest.rc.Error(c, "保存订单失败！", tx.Error)
		return
	}

	rest.rc.Success(c, "创建成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 订单支付成功回调
 * @Date 2020/11/30 19:36:5
 * @Param
 * @return
 **/

func (rest *Order) ReceiveNotify(c *gin.Context) {

	req := c.Request
	req.ParseForm()

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
			cmf.NewDb().Where("id = ?", "1").First(&card)

			validPeriod := card.ValidPeriod
			validPeriodUnix := validPeriod * 86400

			vip := model.MemberCard{
				EndAt:  time.Now().Unix() + int64(validPeriodUnix),
				Status: 1,
			}

			cmf.NewDb().Where("vip_num", co.VipNum).Updates(vip)

			// 修改订单状态
			cmf.NewDb().Where("order_id = ?", orderId).Updates(&model.MemberCardOrder{
				FinishedAt:  time.Now().Unix(),
				OrderStatus: "TRADE_FINISHED",
			})

			// 订单
			mc := model.MemberCard{}
			cmf.NewDb().Where("order_id", orderId).First(&mc)

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
				"unit_price": mc.VipName,
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

			userId := ro.UserId

			total := strings.Join(param["total_amount"], "")
			totalFloat, _ := strconv.ParseFloat(total, 64)

			recJson := appModel.Options("recharge")
			if json.Valid([]byte(recJson)) {

			}

			var recharge []model.Recharge
			json.Unmarshal([]byte(recJson), &recharge)

			if len(recharge) == 0 {

			}

			maxGear := recharge[len(recharge)-1]

			// 充值档次
			var money float64 = 0

			// 最高档
			if totalFloat > maxGear.Gear {
				if maxGear.MoneyEnabled == 1 {

					// 符合最高档次的次数
					frequency := totalFloat / maxGear.Gear
					frequency = math.Floor(frequency)
					if frequency == 0 {
						frequency = 1
					}
					money = frequency * (maxGear.Money)

					// 排除最高档次后的符合档次
					remainder := totalFloat - (frequency * maxGear.Gear)
					remainder = rechargeSend(remainder, userId, recharge)
					if remainder > 0 {
						money += remainder
					}

				}
			} else {
				money = rechargeSend(totalFloat, userId, recharge)
			}

			tx = cmf.NewDb().Model(&ro).Where("id = ?", ro.Id).Update("order_status", "TRADE_FINISHED")
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
			user.Balance += totalFloat

			tx = cmf.NewDb().Updates(&user)
			if tx.Error != nil {
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			// 根据订单号获取支付日志
			orderId := orderId
			tradeNo := tradeNo

			payLog := appModel.PayLog{}
			cmf.NewDb().Where("order_id", orderId).First(&payLog)

			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = payLog.BuyerId
			bizContent["amount"] = payLog.TotalAmount
			bizContent["pay_amount"] = payLog.BuyerPayAmount

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
					"ext_value": payLog.AppId,
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
		fallthrough
	case "W":
		// 支付成功
		if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

			// 生成取餐号
			var number float64 = 10000

			now := time.Now()
			year, month, day := time.Now().Date()
			today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)

			unix := 86400 - today.Sub(now).Seconds()

			if unix < number {
				number += number
			} else {
				number = unix
			}

			queueNo := strconv.Itoa(int(math.Floor(number + 0.5)))

			// 获取redis自增队列

			yearStr, monthStr, dayStr := util.CurrentDate()
			date := yearStr + monthStr + dayStr

			insertKey := "mp_isv" + appId + ":order_queue:" + date
			// 设置当天失效时间
			cmf.NewRedisDb().ExpireAt(insertKey, today)
			val := util.SetIncr(insertKey)
			number += float64(val)

			// 修改订单状态
			cmf.NewDb().Model(&model.FoodOrder{}).Where("order_id = ?", orderId).Updates(map[string]interface{}{"queue_no": queueNo, "order_status": "TRADE_SUCCESS"})

			// 查询订单
			var fo model.FoodOrder
			cmf.NewDb().Where("order_id", orderId).First(&fo)

			// 获取订单门店
			storeId := fo.StoreId
			// 获取门店信息
			store := model.Store{}
			cmf.NewDb().Where("id = ?", storeId).First(&store)

			// 查询订单列表
			var fod []model.FoodOrderDetail
			cmf.NewDb().Where("order_id", orderId).Find(&fod)

			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
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

		}
	}

	if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {
		payLog := appModel.PayLog{
			OrderId:     orderId,
			TradeNo:     strings.Join(param["trade_no"], ""),
			Type:        "alipay",
			AppId:       appId,
			TotalAmount: taFloat,
		}

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

func rechargeSend(totalFloat float64, userId int, recharge []model.Recharge) (money float64) {

	var vPost []model.VoucherPost
	nowUnix := time.Now().Unix()
	for _, v := range recharge {
		if totalFloat > v.Gear {
			money = 0
			// 赠送余额
			if v.MoneyEnabled == 1 {
				money = v.Money
			}

			// 赠送优惠券
			if v.VoucherEnabled == 1 {
				vPost = make([]model.VoucherPost, 0)
				for _, voucher := range v.Voucher {
					mv := model.Voucher{}
					vp := marketing.VoucherValidPeriod{}
					data, err := mv.Show([]string{"id = ? AND status = ?"}, []interface{}{voucher.VoucherId, 1})
					if err != nil {
						cmfLog.Error("rechargeSend" + err.Error())
						return 0
					}
					json.Unmarshal([]byte(data.VoucherValidPeriod), &vp)
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
			return 0
		}
		new(model.Voucher).Send(v.TemplateId, tpData.OpenId, v.VoucherName)
	}

	return money
}
