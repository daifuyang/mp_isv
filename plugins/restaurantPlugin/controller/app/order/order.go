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
	gModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"math"
	"net/http"
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
	now.AddDate(0,0,-1)
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
		query = append(query,"fo.order_status = ?")
		queryArgs = append(queryArgs,orderStatus)
	}

	// 订单类型
	orderType := c.Query("order_type")
	if orderType != "" {
		query = append(query,"fo.order_type = ?")
		queryArgs = append(queryArgs,orderType)
	}

	mpUserId, exists := c.Get("mp_user_id")

	if exists {
		query = append(query,"fo.user_id = ?")
		queryArgs = append(queryArgs,mpUserId)
	}

	// 获取全部订单
	fo := model.FoodOrder{}
	data ,err := fo.IndexByStore(c,query,queryArgs)
	if err != nil && !errors.Is(err,gorm.ErrRecordNotFound) {
		rest.rc.Error(c,err.Error(),nil)
		return
	}
	rest.rc.Success(c,"获取成功！",data)

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
		CouponId        int           `json:"coupon_id"`
		CouponFee       float64       `json:"coupon_fee"`
		Remark          string        `json:"remark"`
		Name            string        `json:"name"`
		Address         string        `json:"address"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	fo := model.FoodOrder{
		StoreId: storeId.(int),
		UserId:  mpUserId.(int),
	}

	otInt := 0
	switch form.OrderType {

	case 1:
		otInt = 1
		// 如果的是堂食扫码点餐
		desk := form.DeskId // 桌号
		if desk == 0 {
			rest.rc.Error(c, "桌号不能为空！", nil)
			return
		}

	case 2:
		otInt = 2
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
		// 如果的是堂食打包外带
		AppointmentTime := form.AppointmentTime //预约时间
		fo.AppointmentTime = AppointmentTime

	case 4:
		otInt = 4
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


	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr

	appIdInt, _ := appId.(int)
	appIdStr := strconv.Itoa(appIdInt)

	insertKey := "mp_isv" + appIdStr + ":order:" + date
	// 设置当天失效时间
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
	cmf.NewRedisDb().ExpireAt(insertKey, today)
	val := util.SetIncr(insertKey)

	now := time.Unix(time.Now().Unix(), 0).Format("20060102")
	nStr := date + strconv.FormatInt(val, 10)

	t1 := time.Now()
	todayUnix := 86400 - today.Sub(t1).Seconds()
	n, _ := strconv.Atoi(nStr)

	n += int(todayUnix)

	nEncrypt := strconv.Itoa(util.EncodeId(uint64(n)))
	orderId := ident + now + nEncrypt


	// 遍历出全部菜品详情

	var foodOrderDetail = make([]model.FoodOrderDetail,0)

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

		foodOrderDetail = append(foodOrderDetail,fod)

		// 加料
		if foodData.UseMaterial == 1 {

			for _, item := range v.Material {

				m := model.FoodMaterialPost{}
				result := cmf.NewDb().Where("id = ?",item.Id).First(&m)
				if result.Error != nil {
					if errors.Is(result.Error,gorm.ErrRecordNotFound) {
						rest.rc.Error(c,item.MaterialName+ "加料已下架，请删除重新下单！",nil)
						return
					}
					rest.rc.Error(c,err.Error(),nil)
					return
				}

				if m.MaterialPrice != item.MaterialPrice {
					rest.rc.Error(c,item.MaterialName+ "商品价格变动，请重新下单！",nil)
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
	if form.BoxFee > 0 {
		fo.BoxFee = form.BoxFee
	}

	// 优惠券
	if form.CouponFee > 0 {
		fo.CouponFee = form.CouponFee
	}

	// 最终售价
	fmt.Println("fee", fee)
	fmt.Println("boxFee", fo.BoxFee)
	fmt.Println("CouponFee", fo.CouponFee)

	fee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", fee), 64)
	boxFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", form.BoxFee), 64)
	fo.BoxFee = boxFee
	couponFee, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", form.CouponFee), 64)
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

	// 支付宝小程序下单
	if mpType == "alipay" {

		common := payment.Common{}
		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = orderId
		//bizContent["total_amount"] = 0.01
		bizContent["total_amount"] = fo.Fee
		bizContent["discountable_amount"] = fo.CouponFee
		bizContent["subject"] = "测试下单小程序"
		bizContent["body"] = "测试下单小程序"
		bizContent["buyer_id"] = Openid
		bizContent["goods_detail"] = aliDetail
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
		rest.rc.Error(c,"保存订单失败！",tx.Error)
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

	fmt.Println("回调开始", "start")

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form

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

	ta := strings.Join(param["total_amount"], "")
	taFloat, err := strconv.ParseFloat(ta, 64)
	if err != nil {
		fmt.Println("taFloat 462", err.Error())
	}

	payLog := gModel.PayLog{
		OrderId:     strings.Join(param["out_trade_no"], ""),
		TradeNo:     strings.Join(param["trade_no"], ""),
		Type:        "alipay",
		AppId:       strings.Join(param["auth_app_id"], ""),
		TotalAmount: taFloat,
	}

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
		}else{
			number = unix
		}

		queueNo := strconv.Itoa(int(math.Floor(number + 0.5)))

		// 获取redis自增队列

		yearStr, monthStr, dayStr := util.CurrentDate()
		date := yearStr + monthStr + dayStr

		appId := payLog.AppId
		insertKey := "mp_isv" + appId + ":order_queue:" + date
		// 设置当天失效时间
		cmf.NewRedisDb().ExpireAt(insertKey, today)
		val := util.SetIncr(insertKey)
		number += float64(val)

		// 修改订单状态
		cmf.NewDb().Model(&model.FoodOrder{}).Where("order_id = ?", payLog.OrderId).Updates(map[string]interface{}{ "queue_no": queueNo,"order_status": "TRADE_SUCCESS"})

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

		payLog.BuyerId = strings.Join(param["buyer_id"], "")
		payLog.ReceiptAmount = raFloat
		payLog.InvoiceAmount = iaFloat
		payLog.BuyerPayAmount = bpaFloat
		payLog.PointAmount = paFloat
		payLog.Subject = strings.Join(param["subject"], "")
		payLog.Body = strings.Join(param["body"], "")

		gpUnix, err := time.ParseInLocation("2006-01-02 15:04:05", strings.Join(param["gmt_payment"], ""), time.Local)
		if err != nil {
			fmt.Println("gmtUnix", err.Error())
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
