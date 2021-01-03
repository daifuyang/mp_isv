/**
** @创建时间: 2020/12/18 5:08 下午
** @作者　　: return
** @描述　　:
 */
package recharge

import (
	"encoding/json"
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Recharge struct {
	rc controller.RestController
}

func (rest *Recharge) Order(c *gin.Context) {

	mid, _ := c.Get("mid")

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	var query = []string{"mid = ? AND  user_id = ? AND order_status = ?"}
	var queryArgs = []interface{}{mid,userId,"TRADE_FINISHED"}

	data,err := new(model.RechargeOrder).Index(c,query,queryArgs)

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	rest.rc.Success(c,"获取成功！",data)
}

// 查看充值规则
func (rest *Recharge) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	recJson := saasModel.Options("recharge",mid.(int))

	var recharge []model.Recharge
	json.Unmarshal([]byte(recJson), &recharge)

	user := appModel.CurrentMpUser(c)
	balance := user.Balance

	var result struct {
		Recharge []model.Recharge `json:"recharge"`
		Balance  float64 `json:"balance"`
	}

	result.Recharge = recharge
	result.Balance = balance

	rest.rc.Success(c, "获取成功！", result)

}

// 充值
func (rest *Recharge) Pay(c *gin.Context) {

	appId, _ := c.Get("app_id")
	mpUserId, _ := c.Get("mp_user_id")
	mpType, _ := c.Get("mp_type")
	Openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")

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

	ro := model.RechargeOrder{}

	tx := cmf.NewDb().Where("user_id = ? AND mid = ? AND fee = ? AND pay_type = ? AND order_status = ?",mpUserId,mid,form.Fee,"alipay","WAIT_BUYER_PAY").First(&ro)

	if tx.Error != nil && !errors.Is(tx.Error,gorm.ErrRecordNotFound) {
		rest.rc.Error(c,tx.Error.Error(),nil)
		return
	}

	if tx.RowsAffected > 0 {
		rest.rc.Success(c,"获取历史订单成功！",ro)
		return
	}

	appIdInt, _ := appId.(int)
	appIdStr := strconv.Itoa(appIdInt)

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + appIdStr + ":recharge:" + date

	orderId := util.DateUuid("recharge", insertKey, date)

	if orderId == "" {
		rest.rc.Error(c, "订单号生成出错！", nil)
		return
	}

	// 支付宝小程序下单
	businessJson := saasModel.Options("business_info",mid.(int))
	bi := settings.BusinessInfo{}
	json.Unmarshal([]byte(businessJson), &bi)
	// 支付宝小程序下单

	nowUnix := time.Now().Unix()
	ro.OrderId = orderId
	ro.Mid = mid.(int)
	ro.PayType = "alipay"
	ro.UserId = mpUserId.(int)
	ro.Fee = form.Fee
	ro.CreateAt = nowUnix
	ro.OrderStatus = "WAIT_BUYER_PAY"

	if mpType == "alipay" {

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
		//bizContent["total_amount"] = form.Fee
		bizContent["total_amount"] = 0.01
		// bizContent["discountable_amount"] = 0
		bizContent["subject"] = bi.BrandName
		bizContent["body"] = bi.BrandName + "开通会员卡"
		bizContent["buyer_id"] = Openid
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

	tx = cmf.NewDb().Create(&ro)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "创建订单成功！", ro)

}
