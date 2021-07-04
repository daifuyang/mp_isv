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
	alipayModel "gincmf/plugins/alipayPlugin/model"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	"github.com/gincmf/alipayEasySdk/merchant"
	"github.com/gincmf/alipayEasySdk/payment"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfData "github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/gincmf/feieSdk/base"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/open"
	"github.com/gincmf/wechatEasySdk/pay"
	wechatUtil "github.com/gincmf/wechatEasySdk/util"
	xpyunYun "github.com/gincmf/xpyunSdk/base"
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
	rc controller.Rest
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
	mid                   int
	mpType                string
	storeName             string
	orderId               int
	orderNumber           string
	orderType             int
	queueNo               string
	userId                int
	voucherId             int
	totalFee              float64
	content               []model.Content
	noticeTitle           string
	noticeDesc            string
	audio                 string
	automaticOrder        bool
	createAt              int64
	authorizerAccessToken string
	formId                string
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
	timeDur := time.Date(currentTime.Year(), currentTime.Month(), currentTime.Day()-1, 23, 59, 59, 0, currentTime.Location())
	yesterday := timeDur.Unix()

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
	data, err := fo.AppIndexByStore(c, query, queryArgs)
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

	mpUserId, exist := c.Get("mp_user_id")

	if exist {
		query = append(query, "fo.user_id = ?")
		queryArgs = append(queryArgs, mpUserId)
	}

	foodOrder := model.FoodOrder{}
	appId, exist := c.Get("app_id")
	if exist {
		foodOrder.AppId = appId.(string)
	}

	data, err := foodOrder.ShowByStore(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取配送价格
 * @Date 2021/4/5 18:52:26
 * @Param
 * @return
 **/
func (rest *Order) DeliveryFee(c *gin.Context) {

	/*
	 配送公司
	 门店编号
	 物流配送运单号
	 收件人
	 发件人
	 cargo货品信息
	*/
	mid, _ := c.Get("mid")

	mpUserId, _ := c.Get("mp_user_id") // 用户id

	mpType, _ := c.Get("mp_type")

	openid, exist := c.Get("open_id") // 微信支付宝唯一识别id

	var form struct {
		OrderDetail []orderDetail `json:"order_detail"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	userMpType := ""

	if mpType.(string) == "wechat" {
		userMpType = "wechat-mp"
	}

	if mpType.(string) == "alipay" {
		userMpType = "alipay-mp"
	}

	// 获取当前会员信息
	u, err := new(model.User).GetMpUser(mpUserId.(int), userMpType)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	storeId, _ := c.Get("store_id")
	store := model.Store{}

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	store, err = store.Show([]string{"id = ?", "delete_at = ?"}, []interface{}{storeId, 0})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if store.Id == 0 {
		rest.rc.Error(c, "该门店不存在或以关闭！", nil)
		return
	}

	addressId := rewrite.Id

	if addressId == 0 {
		rest.rc.Error(c, "地址不能为空！", nil)
		return
	}

	od := form.OrderDetail

	var deliveryGoods []model.DeliveryGoods

	var goodsWeight float64 = 0
	var fee float64 = 0
	var boxFee float64 = 0

	for _, v := range od {

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

		// 启用加料功能

		var materialTotalFee float64

		materialRemark := ""
		if foodData.UseMaterial == 1 {
			for _, item := range v.Material {
				m := model.FoodMaterialPost{}
				result := cmf.NewDb().Where("id = ? AND mid = ?", item.Id, mid).First(&m)
				if result.Error != nil {
					if errors.Is(result.Error, gorm.ErrRecordNotFound) {
						rest.rc.ErrorCode(c, 90001, item.MaterialName+"加料已下架，请删除重新下单！", item)
						return
					}
					rest.rc.Error(c, result.Error.Error(), nil)
					return
				}

				if m.MaterialPrice != item.MaterialPrice {
					rest.rc.ErrorCode(c, 90001, item.MaterialName+"商品价格变动，请重新下单！", nil)
					return
				}

				// 增加加料描述
				materialRemark += m.MaterialName + "|"
				count := float64(item.Count)

				mDecimal := decimal.NewFromFloat(m.MaterialPrice).Mul(decimal.NewFromFloat(count))
				tempMatPrice, _ := mDecimal.Round(2).Float64()

				materialFeeDecimal := decimal.NewFromFloat(materialTotalFee).Add(decimal.NewFromFloat(tempMatPrice))
				materialTotalFee, _ = materialFeeDecimal.Round(2).Float64()

			}

		}

		// 口味
		tastyRemark := ""

		for _, item := range v.Tasty {
			tastyRemark += item.AttrValue + "|"
		}

		// 单个订单总计
		var odTotal float64 = 0
		// 是否启用规格
		if foodData.UseSku == 1 {

			if v.SkuId == 0 {
				rest.rc.Error(c, "规格参数不能为空！", nil)
				return
			}

			// 打印单项详情

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

			if v.Count > skuData.Inventory && skuData.Inventory != -1 {
				rest.rc.Error(c, v.Name+skuData.SkuDetail+"所选商品大于库存数，请删除重新下单！", nil)
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
			odTotal, _ = totalPriceDecimal.Round(2).Float64()

			// 单个规格总价
			if odTotal < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			// 判断菜品是否启用会员价
			if skuData.UseMember == 1 {

				// 判断会员是否拥有专属折扣
				var memberPrice float64 = 0
				if u.Level != nil && u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {
					mPriceDecimal := decimal.NewFromFloat(foodData.MemberPrice).Mul(decimal.NewFromFloat(u.Level.Benefit.Discount).Div(decimal.NewFromInt(100)))
					memberPrice, _ = mPriceDecimal.Round(2).Float64()
				}

				totalPriceDecimal := decimal.NewFromFloat(memberPrice).Mul(decimal.NewFromFloat(count))
				odTotal, _ = totalPriceDecimal.Round(2).Float64()

			}

			feeDecimal := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(odTotal))
			fee, _ = feeDecimal.Round(2).Float64()

			weightDecimal := decimal.NewFromFloat(skuData.Weight).Mul(decimal.NewFromFloat(count))
			weightTotal, _ := weightDecimal.Round(2).Float64()

			goodsWeight += weightTotal

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			title := foodData.Name
			if remark != "" {
				title += "-" + remark
			}

			deliveryGoods = append(deliveryGoods, model.DeliveryGoods{
				GoodCount: int(count),
				GoodName:  title,
				GoodPrice: odTotal,
				GoodUnit:  food.Unit,
			})
		} else {
			// 打印单项详情
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

			if v.Count > foodData.Inventory && foodData.Inventory != -1 {
				rest.rc.Error(c, foodData.Name+"所选商品大于库存数，请删除重新下单！", nil)
				return
			}

			count := float64(v.Count)

			tempDecimal := decimal.NewFromFloat(foodData.Price).Mul(decimal.NewFromFloat(count))
			totalPrice, _ := tempDecimal.Round(2).Float64()

			if totalPrice < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			if foodData.UseMember == 1 {
				if u.Level.Benefit.EnabledDiscount == 1 && u.Level.Benefit.Discount > 0 {
					mPriceDecimal := decimal.NewFromFloat(foodData.Price).Mul(decimal.NewFromFloat(u.Level.Benefit.Discount).Div(decimal.NewFromInt(100)))
					totalPrice, _ = mPriceDecimal.Round(2).Float64()
				}
			}

			odDecimal := decimal.NewFromFloat(totalPrice)
			odTotal, _ = odDecimal.Float64()

			feeDecimal := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(odTotal))
			fee, _ = feeDecimal.Round(2).Float64()

			weightDecimal := decimal.NewFromFloat(foodData.Weight).Mul(decimal.NewFromFloat(count))
			weightTotal, _ := weightDecimal.Round(2).Float64()

			goodsWeight += weightTotal

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			title := foodData.Name
			if remark != "" {
				title += "-" + remark
			}

			deliveryGoods = append(deliveryGoods, model.DeliveryGoods{
				GoodCount: int(count),
				GoodName:  title,
				GoodPrice: totalPrice,
				GoodUnit:  food.Unit,
			})

		}

		if goodsWeight == 0 {
			goodsWeight = 1
		}

		boxFeeDecimal := decimal.NewFromFloat(boxFee).Add(decimal.NewFromFloat(foodData.BoxFee))
		boxFee, _ = boxFeeDecimal.Float64()

	}

	totalFee, _ := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(boxFee)).Round(2).Float64()

	fo := model.FoodOrder{
		TotalAmount: totalFee,
		AddressId:   addressId,
		GoodsWeight: goodsWeight,
	}

	if exist {
		fo.OpenId = openid.(string)
	}

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

	fmt.Println("authorizerAccessToken")

	if akExist {
		fo.AccessToken = authorizerAccessToken.(string)
	}

	fo, err = fo.GetDeliveryFee(store, deliveryGoods)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", gin.H{
		"delivery_token": fo.DeliveryToken,
		"delivery_name":  fo.DeliveryName,
		"delivery_fee":   fo.DeliveryFee,
		"delivery_free":  fo.DeliveryFree,
	})

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 校验菜品库存是否存在
 * @Date 2021/6/27 21:13:12
 * @Param
 * @return
 **/
func (rest *Order) CheckOrder(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	orderId := rewrite.Id

	fo := model.FoodOrder{}
	// 支付成功
	tx := cmf.NewDb().Where("order_id", orderId).First(&fo)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if fo.OrderStatus != "WAIT_BUYER_PAY" {
		rest.rc.Error(c, "订单状态错误！", nil)
		return
	}

	// 查询订单列表
	var fod []model.FoodOrderDetail
	cmf.NewDb().Where("order_id = ?", orderId).Find(&fod)

	for _, v := range fod {

		foodId := v.FoodId
		food := model.Food{}
		foodData, err := food.Show([]string{"mid = ? AND id = ? AND delete_at = ?"}, []interface{}{fo.Mid, foodId, 0})
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, v.FoodName+"商品不存在或已下架！", nil)
				return
			}
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if food.UseSku == 1 {

			foodSku := model.FoodSku{}
			skuData, err := foodSku.Detail([]string{"sku_id = ?"}, []interface{}{v.SkuId})

			if err != nil {
				if errors.Is(err, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, v.FoodName+skuData.SkuDetail+"不存在或已下架！", nil)
					return
				}
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			if skuData.Inventory == 0 {
				rest.rc.Error(c, v.FoodName+skuData.SkuDetail+"库存不足，请删除重新下单！", nil)
				return
			}

			if v.Count > skuData.Inventory && skuData.Inventory != -1 {
				rest.rc.Error(c, v.FoodName+skuData.SkuDetail+"所选商品大于库存数，请删除重新下单！", nil)
				return
			}

		} else {
			if foodData.Inventory == 0 {
				rest.rc.Error(c, v.FoodName+"库存不足，请删除重新下单！", nil)
				return
			}

			if v.Count > foodData.Inventory && foodData.Inventory != -1 {
				rest.rc.Error(c, foodData.Name+"所选商品大于库存数，请删除重新下单！", nil)
				return
			}
		}

	}

	rest.rc.Success(c, "校验成功！", nil)

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

	mpUserId, _ := c.Get("mp_user_id") // 用户id

	mid, _ := c.Get("mid")

	midStr := strconv.Itoa(mid.(int))

	openid, exist := c.Get("open_id") // 微信支付宝唯一识别id

	if !exist {
		rest.rc.Error(c, "openid不能为空！", nil)
		return
	}

	storeId, _ := c.Get("store_id")
	mpType, _ := c.Get("mp_type")
	appId, appIdExist := c.Get("app_id")

	if !appIdExist {
		rest.rc.Error(c, "appId不存在！", nil)
		return
	}

	appIdStr := appId.(string)

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

	var form struct {
		Scene         string        `json:"scene"`
		DeskId        int           `json:"desk_id"`
		Mobile        string        `json:"mobile"`
		Appointment   string        `json:"appointment"`
		OrderDetail   []orderDetail `json:"order_detail"`
		BoxFee        float64       `json:"box_fee"`
		VoucherId     int           `json:"voucher_id"`
		Remark        string        `json:"remark"`
		AddressId     int           `json:"address_id"`
		PayType       string        `json:"pay_type"` // balance 和 alipay
		FormId        string        `json:"form_id"`
		DeliveryToken string        `json:"delivery_token"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	var deliveryMap = model.DeliveryMap{}

	if form.DeliveryToken != "" {
		deliveryOrderStr, _ := cmf.NewRedisDb().Get(form.DeliveryToken).Result()
		json.Unmarshal([]byte(deliveryOrderStr), &deliveryMap)

	}

	userMpType := ""

	if mpType.(string) == "wechat" {
		userMpType = "wechat-mp"
	}

	if mpType.(string) == "alipay" {
		userMpType = "alipay-mp"
	}

	// 获取当前会员信息
	u, err := new(model.User).GetMpUser(mpUserId.(int), userMpType)
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
		FormId:  form.FormId,
		OpenId:  openid.(string),
	}

	if deliveryMap.DeliveryToken != "" {
		fo.ShopOrderId = deliveryMap.ShopOrderId
		fo.DeliveryToken = deliveryMap.DeliveryToken
		fo.DeliveryFee, _ = decimal.NewFromFloat(deliveryMap.DeliveryFee).Round(2).Float64()
		fo.DeliveryFree, _ = decimal.NewFromFloat(deliveryMap.DeliveryFree).Round(2).Float64()
	}

	if akExist {
		fo.AccessToken = authorizerAccessToken.(string)
	}

	store := model.Store{}
	store, err = store.Show([]string{"id = ?", "delete_at = ?"}, []interface{}{storeId, 0})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if store.Id == 0 {
		rest.rc.Error(c, "该门店不存在或以关闭！", nil)
		return
	}

	if store.IsClosure == 1 {
		rest.rc.Error(c, "该门店已经歇业！", nil)
		return
	}

	otInt := 0

	// 通知标题
	noticeTitle := ""
	noticeDesc := ""

	foodOrderType := "qr_order"

	deskName := ""

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

	appointmentTime := ""
	var appointmentType int64 = 0
	// 判断预约时间是否过近
	if form.Appointment != "" {
		appointmentType = 1
		appointmentTime = form.Appointment + ":00"
		tmp, err := time.ParseInLocation(cmfData.TimeLayout, appointmentTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "预约时间格式错误！", nil)
			return
		}

		if time.Now().Unix()+10*60 > tmp.Unix() {
			rest.rc.Error(c, "您选的预约时间过于接近，请调整时间！", nil)
			return
		}

	}

	// 配送费
	var deliveryFee = fo.DeliveryFee

	switch orderType {

	case 1:
		otInt = 1
		noticeTitle = "堂食订单通知"
		noticeDesc = "您有新的堂食订单，请及时处理！"
		foodOrderType = "qr_order"
		// 如果的是堂食扫码点餐

		if form.DeskId == 0 {
			rest.rc.Error(c, "桌号不能为空！", nil)
			return
		}

		// 如果是餐前模式
		if store.EatIn.SaleType == 0 {
			if store.EatIn.EatType == 0 {

			}
		}

	case 2:
		otInt = 2
		noticeTitle = "堂食订单通知"
		noticeDesc = "您有新的堂食订单，请及时处理！"
		foodOrderType = "qr_order"

	case 3:
		otInt = 3
		noticeTitle = "打包订单通知"
		noticeDesc = "您有新的打包订单，请及时处理！"
		foodOrderType = "pre_order"

	case 4:
		otInt = 4
		noticeTitle = "外卖订单通知"
		noticeDesc = "您有新的外卖订单，请及时处理！"
		foodOrderType = "home_delivery"
		// 如果是外卖

		if form.AddressId == 0 {
			rest.rc.Error(c, "地址不能为空！", nil)
			return
		}

		fo.AddressId = form.AddressId

	default:
		rest.rc.Error(c, "订单类型参数错误！", nil)
		return
	}

	// 如果的是堂食到店就餐
	appointmentAt := time.Now().Unix()

	if appointmentTime != "" {
		//预约时间
		appointmentUnix, _ := time.ParseInLocation(cmfData.TimeLayout, appointmentTime, time.Local)
		appointmentAt = appointmentUnix.Unix()
	} else {
		if orderType <= 3 && form.DeskId > 0 {
			deskId := form.DeskId // 桌号
			desk := model.Desk{}
			tx := cmf.NewDb().Where("id = ?", deskId).First(&desk)
			if tx.Error != nil {
				if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, "桌号不存在！", nil)
					return
				}
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}
			// 添加桌号
			fo.DeskId = deskId
			deskName = desk.Name
			fo.DeskName = deskName
		}
	}

	fo.AppointmentAt = appointmentAt

	fo.AppointmentType = appointmentType

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

	var wechatDetail []pay.GoodsDetail

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

	var deliveryGoods []model.DeliveryGoods
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
		fod.FoodThumbnail = foodData.Thumbnail
		fod.AlipayMaterialId = foodData.AlipayMaterialId

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

				// 加料价格
				mDecimal := decimal.NewFromFloat(m.MaterialPrice).Mul(decimal.NewFromFloat(count))
				tempMatPrice, _ := mDecimal.Round(2).Float64()
				mPrice := tempMatPrice

				if mPrice < 0 {
					rest.rc.Error(c, "商品结算价格非法！", nil)
					return
				}

				// 增加加料描述
				materialRemark += m.MaterialName + "|"
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
			tastyRemark += item.AttrValue + "|"
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

			if v.Count > skuData.Inventory && skuData.Inventory != -1 {
				rest.rc.Error(c, v.Name+skuData.SkuDetail+"所选商品大于库存数，请删除重新下单！", nil)
				return
			}

			code := skuData.Code
			if code == "" {
				code = strconv.Itoa(v.FoodId) + "-" + strconv.Itoa(skuData.SkuId)
			}

			// 增加规格描述
			remark = skuData.SkuDetail + "-" + materialRemark + tastyRemark

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			count := float64(v.Count)

			totalPriceDecimal := decimal.NewFromFloat(skuData.Price).Mul(decimal.NewFromFloat(count))
			odTotal, _ := totalPriceDecimal.Round(2).Float64()

			// 单个规格总价
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

			title := foodData.Name

			if remark != "" {
				title += "-" + remark
			}

			printOrderItem["title"] = title
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
				GoodsName: title,
				Quantity:  strconv.Itoa(v.Count),
				Price:     odTotal,
				Body:      skuData.SkuDetail,
			})

			wxTotal := decimal.NewFromFloat(odTotal).Mul(decimal.NewFromInt(100)).IntPart()
			wechatDetail = append(wechatDetail, pay.GoodsDetail{
				MerchantGoodsId: code,
				GoodsName:       title,
				Quantity:        v.Count,
				UnitPrice:       int(wxTotal),
			})

			deliveryGoods = append(deliveryGoods, model.DeliveryGoods{
				GoodCount: int(count),
				GoodName:  title,
				GoodPrice: odTotal,
				GoodUnit:  food.Unit,
			})

			// 包含加料等额外的总价
			fod.Total = odTotal

			feeDecimal := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(odTotal))
			fee, _ = feeDecimal.Round(2).Float64()

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

			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			if foodData.Inventory == 0 {
				rest.rc.Error(c, v.Name+"库存不足，请删除重新下单！", nil)
				return
			}

			if v.Count > foodData.Inventory && foodData.Inventory != -1 {
				rest.rc.Error(c, foodData.Name+"所选商品大于库存数，请删除重新下单！", nil)
				return
			}

			/*if foodData.Price != v.Fee {
				rest.rc.Error(c, v.Name+"价格变动，请重新下单！", nil)
				return
			}*/

			count := float64(v.Count)

			tempDecimal := decimal.NewFromFloat(foodData.Price).Mul(decimal.NewFromFloat(count))
			totalPrice, _ := tempDecimal.Round(2).Float64()

			if totalPrice < 0 {
				rest.rc.Error(c, "商品结算价格非法！", nil)
				return
			}

			fod.Code = code
			fod.Count = v.Count
			fod.Price = foodData.Price

			title := foodData.Name

			if remark != "" {
				title += "-" + remark
			}

			printOrderItem["title"] = title
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

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   code,
				GoodsName: title,
				Quantity:  strconv.Itoa(v.Count),
				Price:     odTotal,
				Body:      v.Name,
			})

			wxTotal := decimal.NewFromFloat(odTotal).Mul(decimal.NewFromInt(100)).IntPart()
			wechatDetail = append(wechatDetail, pay.GoodsDetail{
				MerchantGoodsId: code,
				GoodsName:       title,
				Quantity:        v.Count,
				UnitPrice:       int(wxTotal),
			})

			deliveryGoods = append(deliveryGoods, model.DeliveryGoods{
				GoodCount: int(count),
				GoodName:  title,
				GoodPrice: odTotal,
				GoodUnit:  food.Unit,
			})

			fod.Total = odTotal

			feeDecimal := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(odTotal))
			fee, _ = feeDecimal.Round(2).Float64()

			foodOrderDetail = append(foodOrderDetail, fod)
			printOrder = append(printOrder, printOrderItem)
		}

		if otInt > 2 {
			// 餐盒费
			boxFeeDecimal := decimal.NewFromFloat(boxFee).Add(decimal.NewFromFloat(foodData.BoxFee))
			boxFee, _ = boxFeeDecimal.Float64()
			fo.BoxFee = boxFee
		}
	}

	// 外卖达到配送门槛
	if otInt == 4 && store.TakeOut.MinPrice > 0 && fee < store.TakeOut.MinPrice {
		requirement := store.TakeOut.MinPrice - fee
		rest.rc.Error(c, "未达到起送门槛！还差"+strconv.FormatFloat(requirement, 'f', 2, 64)+"元", nil)
		return
	}

	if fo.DeliveryToken == "" {
		getDelivery, _ := fo.GetDeliveryFee(store, deliveryGoods)
		deliveryFee = getDelivery.DeliveryFee
	}

	orderDetail, err := json.Marshal(od)

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

		if vpData.SyncToAlipay == 1 && mpType != "alipay" {
			rest.rc.Error(c, "该优惠仅限支付宝使用", nil)
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

		couponFee, _ = decimal.NewFromFloat(vpData.Amount).Round(2).Float64()

		if fee < couponFee {
			rest.rc.Error(c, "非法，该优惠券未达到使用门槛！", nil)
			return
		}

		fo.VoucherId = vpData.Id

	}

	fo.CouponFee = couponFee
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

	originalFee, _ := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(boxFee)).Add(decimal.NewFromFloat(deliveryFee)).Round(2).Float64()
	totalFee, _ := decimal.NewFromFloat(fee).Add(decimal.NewFromFloat(boxFee)).Add(decimal.NewFromFloat(deliveryFee)).Sub(decimal.NewFromFloat(couponFee)).Round(2).Float64()

	fo.Fee = totalFee
	fo.OriginalFee = originalFee

	fmt.Println("fee", fee)
	fmt.Println("boxFee", boxFee)
	fmt.Println("deliveryFee", deliveryFee)

	fmt.Println("totalFee", totalFee)
	fmt.Println("originalFee", originalFee)

	/*
	 * 判断用户是否开通会员
	 * 1.享受会员卡优惠
	 * 2.增送增加积分
	 * 3.赠送增加经验
	 */

	msg := ""
	var data interface{}

	var rechargeLog appModel.RechargeLog
	var bp balancePay

	txBegin := cmf.NewDb().Begin()
	defer func() {
		if r := recover(); r != nil {
			txBegin.RollbackTo("sp1")
		}
	}()

	if err := txBegin.Error; err != nil {
		rest.rc.Error(c, "开启事务失败!", err)
		return
	}

	txBegin.SavePoint("sp1")

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
		fo.OriginalFee = originalFee
		fo.Fee = totalFee
		fo.RefundFee = totalFee
		fo.CreateAt = nowUnix
		fo.FinishedAt = nowUnix
		fo.OrderStatus = "TRADE_SUCCESS"

		address := ""
		name := ""
		mobile := form.Mobile

		automaticOrder := true
		if otInt == 4 {

			automaticOrder = false

			addr := model.Address{}
			tx := txBegin.Where("id = ?", form.AddressId).First(&addr)

			if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				txBegin.RollbackTo("sp1")
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			if tx.RowsAffected == 0 {
				txBegin.RollbackTo("sp1")
				rest.rc.Error(c, "地址不存在！", nil)
				return
			}

			address = addr.Address + addr.Room
			nameRune := []rune(addr.Name)
			name = string(nameRune[:1])
			mobile = strconv.Itoa(addr.Mobile)

			fo.AddressId = addr.Id
			fo.Address = address
			fo.Name = name
			fo.Mobile = mobile

			takeJson := saasModel.Options("takeout", store.Mid)
			var takeOut model.TakeOut
			_ = json.Unmarshal([]byte(takeJson), &takeOut)

			// 开启自动接单

			if takeOut.AutomaticOrder == 1 {
				automaticOrder = true
				// 修改订单状态为已接单
				fo.DeliveryStatus = "TRADE_RECEIVED"

			}
		}

		// 生成取餐号
		queueNo := ""
		if form.DeskId == 0 {
			queueNo = model.QueueNo(appIdStr, fo.AppointmentAt)
		} else {

			eatinJson := saasModel.Options("eatin", fo.Mid)
			eatIn := model.EatIn{}

			_ = json.Unmarshal([]byte(eatinJson), &eatIn)

			// 绑定桌号的先付模式（无多人点餐）
			if eatIn.Status == 1 && eatIn.EatType == 1 {
				queueNo = model.QueueNo(appIdStr, fo.AppointmentAt)
			}

		}

		appointmentTime := time.Unix(appointmentAt, 0).Format(cmfData.TimeLayout)

		if appointmentType == 0 {
			appointmentTime = "立即就餐<BR>(" + appointmentTime + ")"
		}

		fo.QueueNo = queueNo

		// 整单打印的内容
		content, err := new(model.FoodOrder).SendPrinter(fo, printOrder, store.StoreName, appointmentTime, false)
		if err != nil {
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
		if otInt <= 2 {
			audio = "https://cdn.mashangdian.cn/eatin.mp3"
		} else if otInt == 3 {
			audio = "https://cdn.mashangdian.cn/pack.mp3"
		} else {
			audio = "https://cdn.mashangdian.cn/takeout.mp3"
		}

		bp = balancePay{
			mid:            mid.(int),
			mpType:         mpType.(string),
			orderType:      otInt,
			storeName:      store.StoreName,
			userId:         mpUserId.(int),
			queueNo:        queueNo,
			voucherId:      form.VoucherId,
			totalFee:       totalFee,
			content:        content,
			noticeTitle:    noticeTitle,
			noticeDesc:     noticeDesc,
			audio:          audio,
			automaticOrder: automaticOrder,
			formId:         fo.FormId,
		}

		if akExist {
			bp.authorizerAccessToken = authorizerAccessToken.(string)
		}

		msg = "支付成功"

	case "alipay":

		if mpType == "alipay" {

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
			bizContent["buyer_id"] = openid
			bizContent["goods_detail"] = aliDetail
			bizContent["product_code"] = "FACE_TO_FACE_PAYMENT"

			extendParams := map[string]string{
				"food_order_type": foodOrderType,
			}

			bizContent["extend_params"] = extendParams

			result := new(payment.Common).Create(bizContent)

			if result.Response.Code == "10000" {
				fo.PayType = "alipay"
				fo.TradeNo = result.Response.TradeNo
				msg = "创建成功！"
			} else {
				txBegin.RollbackTo("sp1")
				rest.rc.Error(c, "创建失败！", result.Response)
				return
			}
		} else {
			txBegin.RollbackTo("sp1")
			rest.rc.Error(c, "环境异常，非支付宝小程序！", nil)
			return
		}

	case "wxpay":

		if mpType == "wechat" {
			msg = "创建成功！"

			mpTheme := saasModel.MpTheme{}
			tx := txBegin.Where("mid = ?", mid).First(&mpTheme)
			if tx.Error != nil {
				txBegin.RollbackTo("sp1")
				if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, "小程序不存在！", nil)
					return
				}
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			subMchid := mpTheme.SubMchid

			if subMchid == "" {
				rest.rc.Error(c, "请联系管理员配置收款账号！", nil)
				return
			}

			options := wechatEasySdk.OpenOptions()

			bizContent := make(map[string]interface{}, 0)

			bizContent["sp_appid"] = options.SpAppid
			bizContent["sp_mchid"] = options.SpMchid
			bizContent["out_trade_no"] = orderId
			bizContent["sub_appid"] = appId
			bizContent["sub_mchid"] = subMchid

			// 测试模板
			flag := new(appModel.TestAppId).InList(appId.(string))
			if flag {
				bizContent["amount"] = map[string]interface{}{
					"total":    1,
					"currency": "CNY",
				}
			} else {
				bizContent["amount"] = map[string]interface{}{
					"total":    totalFee * 100,
					"currency": "CNY",
				}
			}

			var detail struct {
				CostPrice   int               `json:"cost_price,omitempty"`
				InvoiceId   string            `json:"invoice_id,omitempty"`
				GoodsDetail []pay.GoodsDetail `json:"goods_detail,omitempty"`
			}

			detail.GoodsDetail = wechatDetail

			bizContent["detail"] = detail

			bizContent["description"] = bi.BrandName + "点餐"

			host := "https://console.mashangdian.cn"
			bizContent["notify_url"] = host + "/api/v1/wechat/pay_notify"

			bizContent["payer"] = map[string]interface{}{
				"sub_openid": openid,
			}

			payResult := new(pay.PartnerPay).Jsapi(bizContent)
			if payResult.Code != "" {
				txBegin.RollbackTo("sp1")
				rest.rc.Error(c, payResult.Message, nil)
				return
			}

			fo.PayType = "wxpay"
			fo.TradeNo = payResult.PrepayId

			fo.RequestPayment.AppId = appId.(string)
			fo.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
			fo.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
			fo.RequestPayment.Package = "prepay_id=" + fo.TradeNo
			fo.RequestPayment.SignType = "RSA"

		} else {
			txBegin.RollbackTo("sp1")
			rest.rc.Error(c, "环境异常，非微信小程序！", nil)
			return
		}

	default:
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "支付类型错误！", nil)
		return
	}

	fo.Db = txBegin
	storeData, err := fo.Store()
	if err != nil {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "创建失败！", err.Error())
		return
	}

	if fo.PayType == "wxpay" {
		encryptData := []string{
			storeData.RequestPayment.AppId,
			storeData.RequestPayment.TimeStamp,
			storeData.RequestPayment.NonceStr,
			storeData.RequestPayment.Package,
		}

		signature := wechatUtil.Sign(encryptData)
		storeData.RequestPayment.PaySign = signature
	}

	bp.orderId = storeData.Id
	bp.orderNumber = storeData.OrderId
	bp.createAt = storeData.CreateAt

	if fo.PayType == "balance" {

		err := bp.submit()
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		fo.AddOrder(store, deliveryGoods)

		rechargeLog.TargetId = storeData.Id
		rechargeLog.TargetType = 0
		if err := txBegin.Create(&rechargeLog).Error; err != nil {
			txBegin.RollbackTo("sp1")
			rest.rc.Error(c, "创建日志记录失败！", err)
			return
		}

	}

	if data == nil {
		if vpData.SyncToAlipay == 1 {
			storeData.TotalAmount = storeData.TotalAmount - vpData.Amount
		}
		data = storeData
	}

	// 保存到订单详情表
	if err := txBegin.Create(&foodOrderDetail).Error; err != nil {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "保存订单失败！"+err.Error(), err)
		return
	}

	// 减库存
	if fo.PayType == "balance" {

		foodOrder := model.FoodOrder{
			OrderId: orderId,
			Db:      txBegin,
		}
		foodOrder.ReduceInventory()
	}

	txBegin.Commit()
	rest.rc.Success(c, msg, data)
}

func (b balancePay) submit() error {

	// 获取当前会员信息
	userMpType := ""
	if b.mpType == "wechat" {
		userMpType = "wechat-mp"
	}

	if b.mpType == "alipay" {
		userMpType = "alipay-mp"
	}

	u, err := new(model.User).GetMpUser(b.userId, userMpType)
	if err != nil {
		cmfLog.Error(err.Error())
		return err
	}

	balance := u.Balance

	// 消费更改余额
	balanceDecimal := decimal.NewFromFloat(balance).Sub(decimal.NewFromFloat(b.totalFee))
	balance, _ = balanceDecimal.Round(2).Float64()

	tx := cmf.NewDb().Model(&u).Where("id = ?", b.userId).Updates(map[string]interface{}{
		"balance": balance,
	})

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

	// 标记优惠券为已使用
	cmf.NewDb().Model(&model.VoucherPost{}).Where("id = ?", b.voucherId).Update("status", 1)

	// 菜品减库存

	// 如果是外卖
	canPrinter := true
	if b.orderType == 4 {
		canPrinter = false
		if b.automaticOrder {
			canPrinter = true
		}
	}

	for _, content := range b.content {
		if canPrinter {
			sn := content.Sn
			text := content.Content

			if content.Brand == "feie" {
				myResult := new(base.Printer).Printer(sn, text, content.Count)
				fmt.Println("myResult", myResult)
				if myResult.Ret > 0 {
					new(model.Printer).NsqProducer(b.mid, b.orderId)
				}
			}

			if content.Brand == "xprinter" {
				myResult := new(xpyunYun.Printer).Printer(sn, text, content.Count)
				fmt.Println("myResult", myResult)
				if myResult.Content.Code > 0 {
					new(model.Printer).NsqProducer(b.mid, b.orderId)
				}
			}

		}
	}

	// 消息推送
	createTime := time.Unix(b.createAt, 0).Format(cmfData.TimeLayout)

	orderRemark := "您已下单成功！"

	if b.queueNo != "" {
		orderRemark += "取餐号：" + b.queueNo
	}

	wxSubscribe := model.Subscribe{
		Id:         b.orderId,
		Mid:        b.mid,
		Type:       b.mpType,
		OpenId:     u.OpenId,
		StoreName:  b.storeName,
		OrderId:    b.orderNumber,
		Fee:        strconv.FormatFloat(b.totalFee, 'f', -1, 64),
		CreateTime: createTime,
		Remark:     orderRemark,
	}

	if b.mpType == "wechat" {
		wxSubscribe.AccessToken = b.authorizerAccessToken
	}

	if b.mpType == "alipay" {
		wxSubscribe.AccessToken = b.formId
	}

	wxSubscribe.TradeSuccess()

	// 创建通知提醒
	_, err = new(saasModel.AdminNotice).Save(b.mid, b.noticeTitle, b.noticeDesc, b.orderId, 0, b.audio)

	if err != nil {
		return tx.Error
	}

	return nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 阿里支付成功回调
 * @Date 2020/11/30 19:36:5
 * @Param
 * @return
 **/

func (rest *Order) ReceiveNotify(c *gin.Context) {

	iNewDb, exist := c.Get("DB")
	var newDb *gorm.DB
	if !exist {
		rest.rc.Error(c, "数据库异常！", nil)
	}

	newDb = iNewDb.(*gorm.DB)

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

	cmfLog.Save("ReceiveNotify || "+getParams, "alipay.log")

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

	if strings.Join(param["trade_status"], "") == "TRADE_SUCCESS" {

		// 解析回调参数
		orderId := strings.Join(param["out_trade_no"], "")
		tradeNo := strings.Join(param["trade_no"], "")
		appId := strings.Join(param["auth_app_id"], "")

		ra := strings.Join(param["receipt_amount"], "")
		raFloat, err := strconv.ParseFloat(ra, 64)
		if err != nil {
			fmt.Println("raFloat", err.Error())
			raFloat = 0
		}

		ia := strings.Join(param["invoice_amount"], "")
		iaFloat, err := strconv.ParseFloat(ia, 64)
		if err != nil {
			fmt.Println("iaFloat", err.Error())
			iaFloat = 0
		}

		bpa := strings.Join(param["buyer_pay_amount"], "")
		bpaFloat, err := strconv.ParseFloat(bpa, 64)
		if err != nil {
			fmt.Println("bpaFloat", err.Error())
			bpaFloat = 0
		}

		pa := strings.Join(param["point_amount"], "")
		paFloat, err := strconv.ParseFloat(pa, 64)
		if err != nil {
			fmt.Println("paFloat", err.Error())
			paFloat = 0
		}

		ta := strings.Join(param["total_amount"], "")
		taFloat, err := strconv.ParseFloat(ta, 64)
		if err != nil {
			fmt.Println("taFloat 462", err.Error())
			taFloat = 0
		}

		buyerId := strings.Join(param["buyer_id"], "")
		sellerId := strings.Join(param["seller_id"], "")

		vDetailList := strings.Join(param["voucher_detail_list"], "")
		fundBillList := strings.Join(param["fund_bill_list"], "") // 支付渠道

		var vList []alipayModel.VoucherDetailList

		json.Unmarshal([]byte(vDetailList), &vList)

		subject := strings.Join(param["subject"], "")
		body := strings.Join(param["body"], "")
		tradeStatus := strings.Join(param["trade_status"], "")
		gmtPayment := strings.Join(param["gmt_payment"], "")

		od := orderData{
			payType:        "alipay",
			mid:            mid.(int),
			appId:          appId,
			orderId:        orderId,
			tradeNo:        tradeNo,
			buyerId:        buyerId,
			sellerId:       sellerId,
			totalAmount:    taFloat,
			receiptAmount:  raFloat,
			invoiceAmount:  iaFloat,
			buyerPayAmount: bpaFloat,
			PointAmount:    paFloat,
			vList:          vList,
			vDetailList:    vDetailList,
			subject:        subject,
			body:           body,
			tradeStatus:    tradeStatus,
			fundBillList:   fundBillList,
			gmtPayment:     gmtPayment,
			NewDb:          newDb,
		}

		err = od.orderHandle()
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		c.String(http.StatusOK, "success")
	}
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 微信支付回调
 * @Date 2021/5/2 19:3:21
 * @Param
 * @return
 **/

func (rest *Order) PayNotify(c *gin.Context) {

	type resource struct {
		Algorithm      string `json:"algorithm"`
		Ciphertext     string `json:"ciphertext"`
		AssociatedData string `json:"associated_data,omitempty"`
		OriginalType   string `json:"original_type"`
		Nonce          string `json:"nonce"`
	}

	var form struct {
		Id           string   `json:"id"`
		CreateTime   string   `json:"create_time"`
		EventType    string   `json:"event_type"`
		ResourceType string   `json:"resource_type"`
		Resource     resource `json:"resource"`
		Summary      string   `json:"summary"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	formStr, _ := json.Marshal(form)

	cmfLog.Save(string(formStr), "pay_notify.log")

	switch form.EventType {
	case "TRANSACTION.SUCCESS":

		/*订单回调处理*/
		if form.ResourceType == "encrypt-resource" {

			openOptions := wechatEasySdk.OpenOptions()

			response, err := wechatUtil.AesDecrypt256Gcm(openOptions.V3key, form.Resource.AssociatedData, form.Resource.Nonce, form.Resource.Ciphertext)

			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			type payer struct {
				SpOpenid  string `json:"sp_openid"`
				SubOpenid string `json:"sub_openid,omitempty"`
			}

			type amount struct {
				Total         int    `json:"total"`
				PayerTotal    int    `json:"payer_total"`
				Currency      string `json:"currency"`
				PayerCurrency string `json:"payer_currency"`
			}

			type sceneInfo struct {
				DeviceId string `json:"device_id,omitempty"`
			}

			/*goodsDetail*/
			type goodsDetail struct {
				GoodsId        string `json:"goods_id"`
				Quantity       int    `json:"quantity"`
				UnitPrice      int    `json:"unit_price"`
				DiscountAmount int    `json:"discount_amount"`
				GoodsRemark    string `json:"goods_remark,omitempty"`
			}

			/*优惠内容*/
			type promotionDetail struct {
				CouponId            string        `json:"coupon_id"`
				Name                string        `json:"name,omitempty"`
				Scope               string        `json:"scope"`
				Type                string        `json:"type,omitempty"`
				Amount              int           `json:"amount,omitempty"`
				StockId             string        `json:"stock_id,omitempty"`
				WechatpayContribute int           `json:"wechatpay_contribute,omitempty"`
				MerchantContribute  int           `json:"merchant_contribute,omitempty"`
				OtherContribute     int           `json:"other_contribute,omitempty"`
				Currency            string        `json:"currency,omitempty"`
				GoodsDetail         []goodsDetail `json:"goods_detail,omitempty"`
			}

			type PayResponse struct {
				SpAppid         string            `json:"sp_appid"`
				SpMchid         string            `json:"sp_mchid"`
				SubAppid        string            `json:"sub_appid,omitempty"`
				SubMchid        string            `json:"sub_mchid"`
				OutTradeNo      string            `json:"out_trade_no"`   // 商户订单号
				TransactionId   string            `json:"transaction_id"` // 微信支付订单号
				TradeType       string            `json:"trade_type"`
				TradeState      string            `json:"trade_state"`
				TradeStateDesc  string            `json:"trade_state_desc"`
				BankType        string            `json:"bank_type"`
				Attach          string            `json:"attach,omitempty"`
				SuccessTime     string            `json:"success_time"`
				Payer           payer             `json:"payer"`
				Amount          amount            `json:"amount"`
				SceneInfo       sceneInfo         `json:"scene_info,omitempty"`
				PromotionDetail []promotionDetail `json:"promotion_detail,omitempty"`
			}
			var payResponse PayResponse

			json.Unmarshal([]byte(response), &payResponse)

			couponFee := 0

			for _, v := range payResponse.PromotionDetail {
				couponFee += v.Amount
			}

			couponFee64 := decimal.NewFromInt(int64(couponFee)).Div(decimal.NewFromInt(100)).Round(2).IntPart()

			couponFee = int(couponFee64)

			vDetailList, _ := json.Marshal(payResponse.PromotionDetail)

			// 处理订单数据
			orderId := payResponse.OutTradeNo
			appId := payResponse.SubAppid

			isvAuth := appModel.MpIsvAuth{}
			tx := cmf.Db().Where("auth_app_id = ?", appId).First(&isvAuth)
			if tx.Error != nil {
				c.JSON(http.StatusBadRequest, gin.H{
					"code":    "ERROR",
					"message": tx.Error.Error(),
				})
				return
			}

			authorizerAccessToken := isvAuth.AppAuthToken

			// 判断当前AuthorizerAccessToken是否过期
			expireIn, _ := strconv.Atoi(isvAuth.ExpiresIn)
			if int64(expireIn)-1200 < time.Now().Unix() {
				// 已过期重新刷新
				options := wechatEasySdk.OpenOptions()
				accessToken, exist := c.Get("accessToken")

				if !exist {
					rest.rc.Error(c, "accessToken不存在！", nil)
					return
				}

				bizContent := map[string]interface{}{
					"component_appid":          options.AppId,
					"authorizer_appid":         isvAuth.AuthAppId,
					"authorizer_refresh_token": isvAuth.AppRefreshToken,
				}

				result := new(open.Component).AuthorizerToken(accessToken.(string), bizContent)

				if result.Errcode == 0 {

					ei := time.Now().Unix() + int64(result.ExpiresIn)
					isvAuth.AppAuthToken = result.AuthorizerAccessToken
					isvAuth.AppRefreshToken = result.AuthorizerRefreshToken
					isvAuth.ExpiresIn = strconv.FormatInt(ei, 10)

					tx := cmf.Db().Where("id = ?", isvAuth.Id).Updates(&isvAuth)

					if tx.Error != nil {
						new(controller.Rest).Error(c, tx.Error.Error(), nil)
						c.Abort()
						return
					}

					authorizerAccessToken = isvAuth.AppAuthToken

				} else {
					new(controller.Rest).Error(c, result.Errmsg, nil)
					c.Abort()
					return
				}

			}

			db := "tenant_" + strconv.Itoa(isvAuth.TenantId)
			newDb := cmf.ManualDb(db)

			mid := isvAuth.MpId

			totalAmount, _ := decimal.NewFromInt(int64(payResponse.Amount.Total)).Div(decimal.NewFromInt(100)).Round(2).Float64()
			buyerPayAmount := float64(payResponse.Amount.PayerTotal)

			receiptAmount, _ := decimal.NewFromInt(int64(payResponse.Amount.Total)).Round(2).Float64()

			tradeStatus := ""
			if payResponse.TradeState == "SUCCESS" {
				tradeStatus = "TRADE_SUCCESS"
			}

			od := orderData{
				payType:               "wxpay",
				mid:                   mid,
				appId:                 appId,
				orderId:               orderId,
				tradeNo:               payResponse.TransactionId,
				buyerId:               payResponse.Payer.SubOpenid,
				sellerId:              payResponse.SubMchid,
				totalAmount:           totalAmount,
				receiptAmount:         receiptAmount,
				invoiceAmount:         0,
				buyerPayAmount:        buyerPayAmount,
				vDetailList:           string(vDetailList),
				CouponFee:             float64(couponFee),
				PointAmount:           0,
				gmtPayment:            payResponse.SuccessTime,
				authorizerAccessToken: authorizerAccessToken,
				tradeStatus:           tradeStatus,
				NewDb:                 newDb,
			}

			err = od.orderHandle()
			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}

		}

	default:

	}

	c.JSON(http.StatusOK, gin.H{
		"code":    "SUCCESS",
		"message": "成功",
	})

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 订单统一处理逻辑
 * @Date 2021/5/2 21:2:55
 * @Param
 * @return
 **/
type orderData struct {
	payType               string
	appId                 string
	mid                   int
	orderId               string
	tradeNo               string
	buyerId               string
	sellerId              string
	totalAmount           float64
	receiptAmount         float64
	invoiceAmount         float64
	buyerPayAmount        float64
	PointAmount           float64
	vList                 []alipayModel.VoucherDetailList // 支付宝优惠券
	vDetailList           string                          // 优惠券详情
	subject               string
	body                  string
	tradeStatus           string
	fundBillList          string
	gmtPayment            string
	authorizerAccessToken string
	CouponFee             float64
	NewDb                 *gorm.DB
}

func (rest *orderData) orderHandle() (err error) {

	var (
		audio       string
		noticeTitle string
		noticeDesc  string
		userId      int
		rPoint      int // 设置的成长值返点 1.储值 => 2.消费
		fo          model.FoodOrder
		newDb       *gorm.DB
	)

	newDb = rest.NewDb
	mid := rest.mid
	appId := rest.appId
	orderId := rest.orderId
	tradeNo := rest.tradeNo
	buyerId := rest.buyerId
	sellerId := rest.sellerId
	totalAmount := rest.totalAmount
	receiptAmount := rest.receiptAmount
	invoiceAmount := rest.invoiceAmount
	buyerPayAmount := rest.buyerPayAmount
	pointAmount := rest.PointAmount
	vList := rest.vList
	vDetailList := rest.vDetailList
	subject := rest.subject
	body := rest.body
	tradeStatus := rest.tradeStatus
	fundBillList := rest.fundBillList
	gmtPayment := rest.gmtPayment
	receiptCouponFee := rest.CouponFee

	reg := regexp.MustCompile(`[a-zA-Z]+`)
	prefix := reg.FindString(orderId)

	mpType := ""

	payType := ""

	u := model.User{}

	userMpType := ""

	if mpType == "alipay" {
		userMpType = "alipay-mp"
	}

	if mpType == "wechat" {
		userMpType = "wechat-mp"
	}

	switch prefix {
	case "vip":

		if rest.payType == "wxpay" {
			subject = "开通会员"
			body = "开通会员"
		}

		// 支付开卡

		// 获取订单号
		co := model.MemberCardOrder{}
		tx := newDb.Where("order_id = ? AND order_status = 'WAIT_BUYER_PAY'", orderId).First(&co)
		if tx.Error != nil {
			return tx.Error
		}

		if !(co.OrderStatus == "WAIT_BUYER_PAY" || co.OrderStatus == "TRADE_CLOSED") {
			return errors.New("订单状态错误！")
		}

		if co.PayType == "wxpay" {
			mpType = "wechat"
			payType = "wxpay"
		}

		if co.PayType == "alipay" {
			mpType = "alipay"
			payType = "alipay"
		}

		// 获取会员
		card := model.CardTemplate{}
		tx = newDb.Where("id = ? AND status  = ?", "1", "1").First(&card)
		if tx.Error != nil {
			return tx.Error
		}

		validPeriod := card.ValidPeriod
		validPeriodUnix := validPeriod * 86400
		fmt.Println("validPeriodUnix", validPeriodUnix)

		// 获取用户id
		userId = co.UserId

		u, err = new(model.User).GetMpUser(userId, userMpType)
		if err != nil {
			return err
		}

		vip := model.MemberCard{}

		// 判断用户是否已经开过会员卡
		vip, err := vip.Show([]string{"user_id = ?"}, []interface{}{userId})
		if err != nil {
			return err
		}

		var endAt = vip.EndAt
		if endAt == -1 {
			endAt = 0
		}
		// 如果已过期
		if vip.EndAt < time.Now().Unix() {
			endAt = time.Now().Unix() + int64(validPeriodUnix)
		} else {
			endAt += int64(validPeriodUnix)
		}
		if card.ValidPeriod == -1 {
			endAt = -1
		}
		vip.EndAt = endAt
		tx = newDb.Where("vip_num = ?", co.VipNum).Updates(&vip)
		if tx.Error != nil {
			return err
		}

		// 修改订单状态
		newDb.Where("order_id = ?", orderId).Updates(&model.MemberCardOrder{
			FinishedAt:  time.Now().Unix(),
			OrderStatus: "TRADE_FINISHED",
		})

		/*同步会员卡接口*/
		if rest.payType == "alipay" {
			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["amount"] = totalAmount

			if len(vList) > 0 && vList[0].Amount != "" {
				bizContent["discount_amount"] = vList[0].Amount
			} else {
				bizContent["pay_amount"] = buyerPayAmount
			}

			upContent := make(map[string]string, 0)
			fileResult, err := new(merchant.File).Upload(upContent, util.GetAbsPath("images/vip.png"))

			if err != nil {
				return err
			}

			if fileResult.Response.Code != "10000" {
				return errors.New(fileResult.Response.SubMsg)
			}

			var fodExtInfo = []map[string]string{
				{
					"ext_key":   "image_material_id",
					"ext_value": fileResult.Response.MaterialId,
				},
			}

			ioInfo := map[string]interface{}{
				"item_id":    "vipCard",
				"item_name":  "会员服务",
				"unit_price": totalAmount,
				"quantity":   "1",
				"ext_info":   fodExtInfo,
			}

			var itemOrderInfo []map[string]interface{}
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
				return errors.New("同步小程序订单失败！" + result.Response.SubMsg)
			}
		}

	case "recharge":
		// 支付充值

		ro := model.RechargeOrder{}
		tx := newDb.Where("order_id = ?", orderId).First(&ro)
		if tx.Error != nil {
			return tx.Error
		}

		if !(ro.OrderStatus == "WAIT_BUYER_PAY" || ro.OrderStatus == "TRADE_CLOSED") {
			return errors.New("订单状态错误！")
		}

		userId = ro.UserId

		u, err = new(model.User).GetMpUser(userId, userMpType)
		if err != nil {
			return err
		}

		if ro.PayType == "wxpay" {
			mpType = "wechat"
			payType = "wxpay"
		}

		if ro.PayType == "alipay" {
			mpType = "alipay"
			payType = "alipay"
		}

		totalFloat := ro.Fee

		fmt.Println("totalFloat", totalFloat)

		recJson := saasModel.Options("recharge", mid)
		if json.Valid([]byte(recJson)) {

		}

		var recharge []model.Recharge
		_ = json.Unmarshal([]byte(recJson), &recharge)

		// 充值规则

		money := totalFloat
		var tMoney float64 = 0

		if len(recharge) > 0 {

			maxGear := recharge[len(recharge)-1]

			// 充值档次
			money = 0
			tMoney = 0
			var (
				tScore = 0 // 成长值
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
				remainder, reScore := rechargeSend(newDb, remainder, userId, recharge)
				if remainder > 0 {
					tMoney += remainder
					tScore += reScore
				}
			} else {
				tMoney, tScore = rechargeSend(newDb, totalFloat, userId, recharge)
			}

			// 开启充值送
			if maxGear.EnabledMoney == 1 {
				money = tMoney
			}

			if maxGear.EnabledScore == 1 {
				rPoint = tScore
			}

			money += totalFloat

		}

		tx = newDb.Model(&ro).Where("order_id = ?", orderId).Updates(&model.RechargeOrder{
			ActualFee:   money,
			SendFee:     tMoney,
			RefundFee:   totalFloat,
			OrderStatus: "TRADE_FINISHED",
		})
		if tx.Error != nil {
			return tx.Error
		}

		// 充值余额
		user := model.User{}
		tx = newDb.Where("id = ? AND  user_status = 1", ro.UserId).First(&user)
		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			return tx.Error
		}
		user.Id = ro.UserId
		// 增加余额
		balance := user.Balance + money
		user.Balance = balance

		tx = newDb.Updates(&user)
		if tx.Error != nil {
			return tx.Error
		}

		// 余额日志
		moneyStr := strconv.FormatFloat(money, 'f', -1, 64)
		tMoneyStr := strconv.FormatFloat(tMoney, 'f', -1, 64)
		balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

		remark := "余额储值"

		if tMoney > 0 {
			remark += "（含赠送" + tMoneyStr + "元）"
		}

		rechargeLog := appModel.RechargeLog{
			UserId:   userId,
			Type:     0,
			Fee:      moneyStr,
			Balance:  balanceStr,
			Remark:   remark,
			CreateAt: time.Now().Unix(),
		}

		newDb.Create(&rechargeLog)

		if rest.payType == "wxpay" {
			subject = "余额储值"
			body = remark
		}

		if rest.payType == "alipay" {
			// 根据订单号获取支付日志
			bizContent := make(map[string]interface{}, 0)
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["seller_id"] = sellerId
			bizContent["amount"] = totalAmount

			var vListAmount float64 = 0

			for _, v := range vList {
				tempAmount, _ := strconv.ParseFloat(v.Amount, 64)
				vListAmount += tempAmount
			}

			if len(vList) > 0 && vListAmount > 0 {
				bizContent["discount_amount"] = vListAmount
			} else {
				bizContent["pay_amount"] = buyerPayAmount
			}

			upContent := make(map[string]string, 0)
			fileResult, err := new(merchant.File).Upload(upContent, util.GetAbsPath("images/recharge.png"))

			if err != nil {
				return err
			}

			if fileResult.Response.Code != "10000" {
				return errors.New(fileResult.Response.SubMsg)
			}

			var fodExtInfo = []map[string]string{
				{
					"ext_key":   "image_material_id",
					"ext_value": fileResult.Response.MaterialId,
				},
			}

			ioInfo := map[string]interface{}{
				"item_id":    "recharge",
				"item_name":  "余额充值",
				"unit_price": totalFloat,
				"quantity":   "1",
				"ext_info":   fodExtInfo,
			}

			var itemOrderInfo []map[string]interface{}
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
				return errors.New("同步小程序订单失败！" + result.Response.SubMsg)
			}
		}
	case "T":
		fallthrough
	case "W":

		// 支付成功
		tx := newDb.Where("order_id", orderId).First(&fo)
		if tx.Error != nil {
			return tx.Error
		}

		if !(fo.OrderStatus == "WAIT_BUYER_PAY" || fo.OrderStatus == "TRADE_CLOSED") {
			return errors.New("订单状态错误！")
		}

		userId = fo.UserId

		u, err = new(model.User).GetMpUser(userId, userMpType)
		if err != nil {
			return err
		}

		if fo.PayType == "wxpay" {
			mpType = "wechat"
			payType = "wxpay"
		}

		if fo.PayType == "alipay" {
			mpType = "alipay"
			payType = "alipay"
		}

		deskName := ""
		// 生成取餐号
		queueNo := ""
		if fo.DeskId == 0 {
			queueNo = model.QueueNo(appId, fo.AppointmentAt)
		} else {
			deskId := fo.DeskId
			desk := model.Desk{}
			tx := newDb.Where("id = ?", deskId).First(&desk)
			if tx.Error != nil {
				if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					return errors.New("桌号不存在！")
				}
				return tx.Error
			}
			deskName = desk.Name
			fo.DeskName = deskName

			eatinJson := saasModel.Options("eatin", fo.Mid)
			eatIn := model.EatIn{}

			_ = json.Unmarshal([]byte(eatinJson), &eatIn)

			// 绑定桌号的先付模式（无多人点餐）
			if eatIn.Status == 1 && eatIn.EatType == 1 {
				queueNo = model.QueueNo(appId, fo.AppointmentAt)
			}

		}

		// 查询订单
		if fo.OrderType <= 2 {
			audio = "https://cdn.mashangdian.cn/eatin.mp3"
			noticeTitle = "堂食订单通知"
			noticeDesc = "您有新的堂食订单，请及时处理！"
		} else if fo.OrderType == 3 {
			audio = "https://cdn.mashangdian.cn/pack.mp3"
			noticeTitle = "打包订单通知"
			noticeDesc = "您有新的打包订单，请及时处理！"
		} else {
			audio = "https://cdn.mashangdian.cn/takeout.mp3"
			noticeDesc = "您有新的外卖订单，请及时处理！"
		}

		businessJson := saasModel.Options("business_info", fo.Mid)
		bi := model.BusinessInfo{}
		_ = json.Unmarshal([]byte(businessJson), &bi)
		if rest.payType == "wxpay" {
			// 企业主体

			subject = bi.BrandName
			body = bi.BrandName + "点餐"
		}

		// 如果是外卖
		orderStatus := "TRADE_SUCCESS"
		deliveryStatus := ""

		canPrinter := true
		if prefix == "W" {
			if rest.payType == "wxpay" {
				body = bi.BrandName + "外卖"
			}
			canPrinter = false
			takeJson := saasModel.Options("takeout", fo.Mid)
			takeOut := model.TakeOut{}
			_ = json.Unmarshal([]byte(takeJson), &takeOut)
			if takeOut.AutomaticOrder == 1 {
				canPrinter = true
				// 修改订单状态为已接单
				deliveryStatus = "TRADE_RECEIVED"

			}
		}

		// 查询优惠券
		vp := model.VoucherPost{}

		foParams := map[string]interface{}{
			"refund_fee":      totalAmount,
			"queue_no":        queueNo,
			"order_status":    orderStatus,
			"delivery_status": deliveryStatus,
		}

		if rest.payType == "alipay" {

			var vListAmount float64 = 0
			for _, v := range vList {
				tempAmount, _ := strconv.ParseFloat(v.Amount, 64)
				vListAmount += tempAmount
			}

			foParams["coupon_fee"] = vListAmount
			foParams["fee"] = fo.OriginalFee - vListAmount
			foParams["refund_fee"] = fo.OriginalFee - vListAmount

			if len(vList) > 0 && vListAmount > 0 {

				tx := newDb.Where("alipay_voucher_id = ?", vList[0].VoucherId).First(&vp)
				if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					return tx.Error
				}

				if vp.Id > 0 {

					foParams["coupon_fee"] = vListAmount
					foParams["voucher_id"] = vp.Id

					couponFee, _ := decimal.NewFromString(vList[0].Amount)
					fee, _ := decimal.NewFromFloat(fo.Fee).Sub(couponFee).Float64()
					fo.Fee = fee
					foParams["fee"] = fee
				}

			}
		}

		if rest.payType == "wxpay" {
			foParams["coupon_fee"] = receiptCouponFee
			foParams["fee"] = fo.OriginalFee - receiptCouponFee
			foParams["refund_fee"] = fo.OriginalFee - receiptCouponFee
		}

		if vp.Id > 0 {
			// 标记优惠券为已使用
			tx = newDb.Model(&model.VoucherPost{}).Where("id = ?", vp.Id).Update("status", 1)
			if tx.Error != nil {
				return tx.Error
			}
		}

		// 修改订单状态
		tx = newDb.Model(&fo).Where("order_id = ?", orderId).Updates(foParams)
		if tx.Error != nil {
			return tx.Error
		}

		// 减库存
		foodOrder := model.FoodOrder{OrderId: orderId, Db: newDb}
		foodOrder.ReduceInventory()

		// 获取订单门店
		storeId := fo.StoreId

		// 获取门店信息
		store := model.Store{}
		store, err = store.Show([]string{"id = ?", "delete_at = ?"}, []interface{}{storeId, 0})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			return err
		}

		if store.Id == 0 {
			return errors.New("该门店不存在或以关闭！")
		}

		// 查询订单列表
		var fod []model.FoodOrderDetail
		newDb.Where("order_id = ?", orderId).Find(&fod)

		bizContent := make(map[string]interface{}, 0)
		if rest.payType == "alipay" {
			bizContent["out_biz_no"] = orderId
			bizContent["trade_no"] = tradeNo
			bizContent["buyer_id"] = buyerId
			bizContent["seller_id"] = sellerId
			bizContent["amount"] = totalAmount
			if len(vList) > 0 && vList[0].Amount != "" {
				bizContent["discount_amount"] = vList[0].Amount
			} else {
				bizContent["pay_amount"] = buyerPayAmount
			}
		}
		var itemOrderInfo []map[string]interface{}

		var printOrder = make([]map[string]string, 0)

		for _, v := range fod {

			if rest.payType == "alipay" {
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
			}

			// 打印订单详情信息
			var printOrderItem = make(map[string]string, 0)

			title := v.FoodName
			if v.SkuDetail != "" {
				title += "-" + v.SkuDetail
			}

			// 加料
			materialRemark := ""
			var materialArr []material
			json.Unmarshal([]byte(v.Material), &materialArr)
			for _, item := range materialArr {
				materialRemark += item.MaterialName + "|"
			}

			// 口味
			tastyRemark := ""

			var tasty []tasty
			json.Unmarshal([]byte(v.Tasty), &tasty)

			for _, item := range tasty {
				tastyRemark += item.AttrValue + "|"
			}

			remark := materialRemark + tastyRemark
			remarkRune := []rune(remark)

			if len(remarkRune) > 1 {
				remark = string(remarkRune[0 : len(remarkRune)-1])
			}

			if remark != "" {
				title += "-" + remark
			}

			printOrderItem["title"] = title
			printOrderItem["count"] = strconv.Itoa(v.Count)
			printOrderItem["food_id"] = strconv.Itoa(v.FoodId)
			printOrderItem["total"] = strconv.FormatFloat(v.Total, 'f', -1, 64)
			printOrder = append(printOrder, printOrderItem)

		}
		if rest.payType == "alipay" {
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
				// 门店信息
				bizContent["shop_info"] = shopInfo
			}

			result := new(merchant.Order).Sync(bizContent)
			if result.Response.Code != "10000" {
				return errors.New("同步小程序订单失败！" + result.Response.SubMsg)
			}
		}

		if noticeTitle == "" {
			audio = "https://cdn.mashangdian.cn/takeout.mp3"
			noticeTitle = "外卖订单提醒"
		}

		orderRemark := "您已下单成功！"

		if queueNo != "" {
			orderRemark += "取餐号：" + queueNo
		}

		if fo.PayType == "wxpay" {
			wxSubscribe := model.Subscribe{
				Id:          fo.Id,
				Mid:         fo.Mid,
				Type:        "wechat",
				AccessToken: rest.authorizerAccessToken,
				OpenId:      u.OpenId,
				StoreName:   store.StoreName,
				OrderId:     fo.OrderId,
				Fee:         strconv.FormatFloat(fo.Fee, 'f', -1, 64),
				CreateTime:  time.Unix(fo.CreateAt, 0).Format(cmfData.TimeLayout),
				Remark:      orderRemark,
			}
			wxSubscribe.TradeSuccess()

		}

		if fo.PayType == "alipay" {
			wxSubscribe := model.Subscribe{
				Id:          fo.Id,
				Mid:         fo.Mid,
				Type:        "alipay",
				AccessToken: fo.FormId,
				OpenId:      u.OpenId,
				StoreName:   store.StoreName,
				OrderId:     fo.OrderId,
				Fee:         strconv.FormatFloat(fo.Fee, 'f', -1, 64),
				CreateTime:  time.Unix(fo.CreateAt, 0).Format(cmfData.TimeLayout),
				Remark:      orderRemark,
			}
			wxSubscribe.TradeSuccess()

		}

		// 保存通知
		_, err = new(saasModel.AdminNotice).Save(mid, noticeTitle, noticeDesc, fo.Id, 0, audio)

		if err != nil {
			cmfLog.Save(err.Error(), "payErr.log")
			return err
		}

		// 打印机打印订单
		appointmentTime := time.Unix(fo.AppointmentAt, 0).Format(cmfData.TimeLayout)

		if fo.AppointmentType == 0 {
			appointmentTime = "立即就餐<BR>(" + appointmentTime + ")"
		}

		// 获取门店打印机状态
		_, err = new(model.FoodOrder).SendPrinter(fo, printOrder, store.StoreName, appointmentTime, canPrinter)
		if err != nil {
			cmfLog.Save(err.Error(), "payErr.log")
			return err
		}
	}

	// 获取当前会员信息

	/*
		1.积分
		2.经验
		判断用户的会员卡状态
		是否开启了消费送经验
	*/

	if prefix != "vip" {

		score := u.Score
		tScore := 0
		scoreJson := saasModel.Options("score", mid)
		scoreMap := model.Score{}
		_ = json.Unmarshal([]byte(scoreJson), &scoreMap)

		totalFee := totalAmount

		if totalFee == 0 {
			totalFee = fo.Fee
		}

		// 启用消费返积分
		if scoreMap.EnabledPay == 1 {
			tScore = scoreMap.PayScore * int(totalFee)

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
					point = u.Level.Benefit.Point * int(totalFee)
				}
			}

			exp += point

			// 保存到数据库
			sLog := appModel.ScoreLog{
				UserId: u.Id,
				Score:  tScore,
				Fee:    strconv.FormatFloat(totalFee, 'f', 2, 64),
				Remark: remark,
			}

			// 达到消费门槛1元
			if totalFee > 1 {
				err = sLog.Save()
				if err != nil {
					return err
				}
			}

			eLog := appModel.ExpLog{
				UserId: u.Id,
				Exp:    point,
				Fee:    strconv.FormatFloat(totalFee, 'f', 2, 64),
				Remark: remark,
			}

			if score > 0 {
				err = eLog.Save()
				if err != nil {
					return err
				}
			}

			tx := newDb.Model(&u).Where("id = ?", u.Id).Updates(map[string]interface{}{
				"score": score,
				"exp":   exp,
			})

			if tx.Error != nil {
				cmfLog.Error(tx.Error.Error())
				return tx.Error
			}

		}
	}

	// 转换微信单位
	if payType == "wxpay" {
		receiptAmount, _ = decimal.NewFromFloat(receiptAmount).Div(decimal.NewFromInt(100)).Round(2).Float64()
		invoiceAmount, _ = decimal.NewFromFloat(invoiceAmount).Div(decimal.NewFromInt(100)).Round(2).Float64()
		buyerPayAmount, _ = decimal.NewFromFloat(buyerPayAmount).Div(decimal.NewFromInt(100)).Round(2).Float64()
		pointAmount, _ = decimal.NewFromFloat(pointAmount).Div(decimal.NewFromInt(100)).Round(2).Float64()
	}

	payLog := appModel.PayLog{
		OrderId:           orderId,
		TradeNo:           tradeNo,
		Type:              payType,
		AppId:             appId,
		UserId:            userId,
		BuyerId:           buyerId,
		TotalAmount:       totalAmount,
		ReceiptAmount:     receiptAmount,
		InvoiceAmount:     invoiceAmount,
		BuyerPayAmount:    buyerPayAmount,
		PointAmount:       pointAmount,
		VoucherDetailList: vDetailList,
		Subject:           subject,
		Body:              body,
	}

	timeLayout := cmfData.TimeLayout

	if payType == "wxpay" {
		payLog.TotalAmount = totalAmount
		payLog.ReceiptAmount = receiptAmount
		payLog.InvoiceAmount = invoiceAmount
		payLog.BuyerPayAmount = buyerPayAmount
		timeLayout = time.RFC3339
	}

	if payType == "alipay" {
		timeLayout = cmfData.TimeLayout
	}

	gpUnix, err := time.ParseInLocation(timeLayout, gmtPayment, time.Local)
	if err != nil {
		fmt.Println("gmtUnixErr", err.Error())
		return
	}
	payLog.GmtPayment = gpUnix.Unix()

	payLog.TradeStatus = tradeStatus

	fbl := fundBillList

	if fbl == "" {
		fbl = "{}"
	}

	payLog.FundBillList = fbl

	// 存入
	tx := newDb.Create(&payLog)
	if tx.Error != nil {
		return tx.Error
	}

	return nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 计算充值送金额
 * @Date 2021/1/2 10:13:1
 * @Param
 * @return
 **/
func rechargeSend(newDb *gorm.DB, totalFloat float64, userId int, recharge []model.Recharge) (money float64, point int) {

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
						return money, point
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
	newDb.Create(&vPost)
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

	tx := cmf.NewDb().Where(queryStr, queryArgs...).Updates(foodOrder)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "取消成功！", nil)

}
