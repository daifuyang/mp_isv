/**
** @创建时间: 2020/12/17 3:58 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"encoding/json"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/merchant"
	cmf "github.com/gincmf/cmf/bootstrap"
	"math"
	"regexp"
	"strconv"
	"testing"
)

func TestOrder_Get(t *testing.T) {
	reg := regexp.MustCompile(`[a-z]+`)
	prefix := reg.FindString("vip0010021031312031230120")
	fmt.Println(prefix)
}

// 测试会员卡

// 测试充值
func Test_Recharge(t *testing.T) {

	cmf.Initialize("/Users/return/workspace/mygo/mp_isv/data/conf/config.json")

	cmf.ManualDb("tenant_1051453199")

	total := "1000"
	totalFloat, _ := strconv.ParseFloat(total, 64)

	orderId := "recharge202012191392402917"

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
			remainder = rechargeSend(remainder, 1, recharge)
			if remainder > 0 {
				money += remainder
			}

		}
	} else {
		money = rechargeSend(totalFloat, 1, recharge)
	}

	fmt.Println("赠送余额", money)
	totalFloat += money
	fmt.Println("总充值", totalFloat)

	// 获取订单号
	ro := model.RechargeOrder{}
	tx := cmf.NewDb().Where("order_id = ?", orderId).First(&ro)
	if tx.Error != nil {
		fmt.Println(tx.Error.Error())
		return
	}

	tx = cmf.NewDb().Model(&ro).Where("id = ?", ro.Id).Update("order_status", "TRADE_FINISHED")
	if tx.Error != nil {
		fmt.Println(tx.Error.Error())
		return
	}

	// 充值余额
	user := model.User{}
	tx = cmf.NewDb().Where("id = ?", ro.UserId).First(&user)
	if tx.Error != nil {
		fmt.Println(tx.Error.Error())
		return
	}
	user.Id = ro.UserId
	// 增加余额
	user.Balance += totalFloat

	tx = cmf.NewDb().Updates(&user)
	if tx.Error != nil {
		fmt.Println(tx.Error.Error())
		return
	}

}

// 测试订单同步到支付宝小程序

func TestOrder_Sync(t *testing.T) {

	cmf.Initialize("/Users/return/workspace/mygo/mp_isv/data/conf/config.json")
	cmf.ManualDb("tenant_1051453199")

	op := map[string]string{
		"protocol":    "https",
		"gatewayHost": "openapi.alipay.com/gateway.do",
		"signType":    "RSA2",
		"appId":       "2021001192664075",
		"version":     "1.0",
		"charset":     "utf-8",
		"notifyUrl":   "http://www.codecloud.ltd/api/v1/app/alipay/receive_notify",
		"AppCertPath": "/Users/return/workspace/mygo/mp_isv/data/pem",
		"AliCertPath": "/Users/return/workspace/mygo/mp_isv/data/pem",
	}

	alipayEasySdk.NewOptions(op)
	alipayEasySdk.SetOption("AppAuthToken", "202012BBc94d62297edb49e385e2136023b0dX61")

	// 根据订单号获取支付日志
	orderId := "T202012211048424296"
	tradeNo := "2020122122001496711451167885"

	payLog := appModel.PayLog{}
	cmf.NewDb().Where("order_id", orderId).First(&payLog)

	// 查询订单
	var fo model.FoodOrder
	cmf.NewDb().Where("order_id", orderId).First(&fo)

	// 获取订单门店
	storeId := fo.StoreId
	// 获取门店信息
	store := model.Store{}
	cmf.NewDb().Where("id = ?",storeId).First(&store)

	// 查询订单列表
	var fod []model.FoodOrderDetail
	cmf.NewDb().Where("order_id", orderId).Find(&fod)

	bizContent := make(map[string]interface{}, 0)
	bizContent["out_biz_no"] = orderId
	bizContent["trade_no"] = tradeNo
	bizContent["buyer_id"] = payLog.BuyerId
	bizContent["amount"] = payLog.TotalAmount
	bizContent["pay_amount"] = payLog.BuyerPayAmount

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
			"ext_value": payLog.AppId,
		},
		{
			"ext_key":   "merchant_order_status",
			"ext_value": "MERCHANT_PAID",
		},
		{
			"ext_key": "merchant_order_link_page",  // 小程序订单详情页
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
		"merchant_shop_id":store.StoreNumber,
		"name":store.StoreName,
		"address":store.Address,
		"phone_num":store.Phone,
	}

	result := new(merchant.Order).Sync(bizContent)
	fmt.Println(result)
}
