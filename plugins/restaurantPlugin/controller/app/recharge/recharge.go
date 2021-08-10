/**
** @创建时间: 2020/12/18 5:08 下午
** @作者　　: return
** @描述　　:
 */
package recharge

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	"github.com/gincmf/cmf/controller"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/pay"
	wechatUtil "github.com/gincmf/wechatEasySdk/util"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Recharge struct {
	rc controller.Rest
}

func (rest *Recharge) Order(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	var query = []string{"mid = ? AND  user_id = ? AND order_status = ?"}
	var queryArgs = []interface{}{mid, userId, "TRADE_FINISHED"}

	rechargeOrder := model.RechargeOrder{
		Db: db,
	}

	data, err := rechargeOrder.Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

// 查看充值规则
func (rest *Recharge) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	recJson, err := saasModel.Options(db, "recharge", mid.(int))

	var recharge []model.Recharge
	json.Unmarshal([]byte(recJson), &recharge)

	user := appModel.CurrentMpUser(c)

	tx :=db.Where("id = ?", user.Id).First(&user)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	balance := user.Balance

	var result struct {
		Recharge []model.Recharge `json:"recharge"`
		Balance  float64          `json:"balance"`
	}

	result.Recharge = recharge
	result.Balance = balance

	rest.rc.Success(c, "获取成功！", result)

}

// 充值
func (rest *Recharge) Pay(c *gin.Context) {

	mpUserId, _ := c.Get("mp_user_id")
	mpType, _ := c.Get("mp_type")
	openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")
	appId, _ := c.Get("app_id")

	var form struct {
		Fee float64 `json:"fee"`
	}

	if err := c.ShouldBindJSON(&form); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if form.Fee == 0 {
		rest.rc.Error(c, "充值金额不能为空！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	ro := model.RechargeOrder{
		Db: db,
	}

	var payType = ""
	fmt.Println("mpType", mpType)
	if mpType == "alipay" {
		payType = "alipay"
	} else if mpType == "wechat" {
		payType = "wxpay"
	} else {
		payType = ""
	}

	if payType == "" {
		rest.rc.Error(c, "支付方式错误！", nil)
		return
	}

	tx := db.Where("user_id = ? AND mid = ? AND fee = ? AND pay_type = ? AND order_status = ?", mpUserId, mid, form.Fee, payType, "WAIT_BUYER_PAY").First(&ro)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected > 0 {

		if ro.PayType == "wxpay" {

			ro.RequestPayment.AppId = appId.(string)
			ro.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
			ro.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
			ro.RequestPayment.Package = "prepay_id=" + ro.TradeNo
			ro.RequestPayment.SignType = "RSA"

			encryptData := []string{
				ro.RequestPayment.AppId,
				ro.RequestPayment.TimeStamp,
				ro.RequestPayment.NonceStr,
				ro.RequestPayment.Package,
			}

			signature := wechatUtil.Sign(encryptData)
			ro.RequestPayment.PaySign = signature

		}

		rest.rc.Success(c, "获取历史订单成功！", ro)
		return
	}

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":recharge:" + date

	orderId := util.DateUuid("recharge", insertKey, date, mid.(int))

	if orderId == "" {
		rest.rc.Error(c, "订单号生成出错！", nil)
		return
	}

	// 支付宝小程序下单
	businessJson, err := saasModel.Options(db, "business_info", mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	bi := model.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)
	// 支付宝小程序下单

	nowUnix := time.Now().Unix()
	ro.OrderId = orderId
	ro.Mid = mid.(int)
	ro.UserId = mpUserId.(int)
	ro.Fee = form.Fee
	ro.CreateAt = nowUnix
	ro.OrderStatus = "WAIT_BUYER_PAY"

	if mpType == "alipay" {

		ro.PayType = "alipay"

		var aliDetail []payment.GoodsDetail
		aliDetail = append(aliDetail, payment.GoodsDetail{
			GoodsId:   "recharge",
			GoodsName: "钱包充值",
			Quantity:  "1",
			Price:     form.Fee,
			Body:      "钱包充值",
		})

		common := payment.Common{}
		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = orderId

		// 测试模板
		flag := new(appModel.TestAppId).InList(appId.(string))
		if flag {
			bizContent["total_amount"] = 0.01
		} else {
			bizContent["total_amount"] = form.Fee
		}

		bizContent["discountable_amount"] = 0
		bizContent["subject"] = bi.BrandName
		bizContent["body"] = bi.BrandName + "钱包充值"
		bizContent["buyer_id"] = openid
		bizContent["goods_detail"] = aliDetail
		bizContent["product_code"] = "FACE_TO_FACE_PAYMENT"
		extendParams := map[string]string{
			"food_order_type": "direct_payment",
		}
		bizContent["extend_params"] = extendParams
		result := common.Create(bizContent)

		if result.Response.Code == "10000" {
			ro.TradeNo = result.Response.TradeNo
		} else {
			rest.rc.Error(c, "创建失败！", result.Response)
			return
		}
	}

	if mpType == "wechat" {

		ro.PayType = "wxpay"
		mpTheme := saasModel.MpTheme{}
		tx := db.Where("mid = ?", mid).First(&mpTheme)
		if tx.Error != nil {
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
				"total":    form.Fee * 100,
				"currency": "CNY",
			}
		}

		bizContent["description"] = bi.BrandName + "钱包充值"

		host := "https://console.mashangdian.cn"
		bizContent["notify_url"] = host + "/api/v1/wechat/pay_notify"

		bizContent["payer"] = map[string]interface{}{
			"sub_openid": openid,
		}

		payResult := new(pay.PartnerPay).Jsapi(bizContent)
		if payResult.Code != "" {
			rest.rc.Error(c, payResult.Message, nil)
			return
		}

		ro.TradeNo = payResult.PrepayId
		ro.RequestPayment.AppId = appId.(string)
		ro.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
		ro.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
		ro.RequestPayment.Package = "prepay_id=" + ro.TradeNo
		ro.RequestPayment.SignType = "RSA"

		encryptData := []string{
			ro.RequestPayment.AppId,
			ro.RequestPayment.TimeStamp,
			ro.RequestPayment.NonceStr,
			ro.RequestPayment.Package,
		}

		signature := wechatUtil.Sign(encryptData)
		ro.RequestPayment.PaySign = signature

	}

	tx = db.Create(&ro)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "创建订单成功！", ro)

}
