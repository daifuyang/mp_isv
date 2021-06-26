/**
** @创建时间: 2020/12/18 8:58 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	wechatModel "gincmf/plugins/wechatPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"github.com/gincmf/wechatEasySdk/pay"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

// 充值订单支付状态
type RechargeOrder struct {
	Id             int                        `json:"id"`
	Mid            int                        `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId        string                     `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo        string                     `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	UserId         int                        `gorm:"type:bigint(20);comment:用户所属id;not null" json:"user_id"`
	Avatar         string                     `gorm:"->" json:"avatar"`
	UserLogin      string                     `gorm:"->" json:"user_login"`
	UserNickname   string                     `gorm:"->" json:"user_nickname"`
	UserRealName   string                     `gorm:"->" json:"user_realname"`
	PayType        string                     `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	Fee            float64                    `gorm:"type:decimal(7,2);comment:支付金额;default:0;not null" json:"fee"`
	ActualFee      float64                    `gorm:"type:decimal(7,2);comment:实际金额;default:0;not null" json:"actual_fee"`
	SendFee        float64                    `gorm:"type:decimal(7,2);comment:赠送金额;default:0;not null" json:"send_fee"`
	RefundFee      float64                    `gorm:"type:decimal(7,2);comment:剩余可退金额;default:0;not null" json:"refund_fee"`
	CreateAt       int64                      `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt     int64                      `gorm:"type:int(11)" json:"finished_at"`
	CreateTime     string                     `gorm:"-" json:"create_time"`
	FinishedTime   string                     `gorm:"-" json:"finished_time"`
	OrderStatus    string                     `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_FINISHED=> 已完成，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	paginate       cmfModel.Paginate          `gorm:"-"`
	RequestPayment wechatModel.RequestPayment `gorm:"-" json:"request_payment"`
	Db             *gorm.DB                   `gorm:"-" json:"-"`
}

func (model *RechargeOrder) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var ro []RechargeOrder

	prefix := cmf.Conf().Database.Prefix

	cmf.NewDb().Table(prefix+"recharge_order ro").
		Select("ro.*,u.id as user_id,u.user_login,u.user_nickname,u.user_realname").
		Joins("INNER JOIN "+prefix+"user u ON ro.user_id = u.id").
		Where(queryStr, queryArgs...).
		Order("ro.id desc").
		Scan(&ro).Count(&total)

	tx := cmf.NewDb().Table(prefix+"recharge_order ro").
		Select("ro.*,u.id as user_id,u.user_login,u.user_nickname,u.user_realname").
		Joins("INNER JOIN "+prefix+"user u ON ro.user_id = u.id").
		Where(queryStr, queryArgs...).
		Order("ro.id desc").
		Limit(pageSize).Offset((current - 1) * pageSize).Scan(&ro)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range ro {
		ro[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		ro[k].FinishedTime = time.Unix(v.FinishedAt, 0).Format(data.TimeLayout)
	}

	paginate := cmfModel.Paginate{Data: ro, Current: current, PageSize: pageSize, Total: total}
	if len(ro) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 统一退款
 * @Date 2021/3/30 11:59:18
 * @Param
 * @return
 **/
func (model *RechargeOrder) Refund(refundFee float64, refundReason string, authorizerAccessToken string) error {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	userMpType := ""
	if model.PayType == "alipay" {
		userMpType = "alipay-mp"
	}

	if model.PayType == "wxpay" {
		userMpType = "wechat-mp"
	}

	u, err := new(User).GetMpUser(model.UserId, userMpType)
	if err != nil {
		cmfLog.Error(err.Error())
		return err
	}

	refundFeeFloat, _ := decimal.NewFromFloat(model.ActualFee).Round(2).Float64()
	if refundFee != model.Fee {
		// 计算退款比例
		discount, _ := decimal.NewFromFloat(model.Fee).Div(decimal.NewFromFloat(model.ActualFee)).Round(2).Float64()

		// 计算应退金额比例

		refundFeeFloat, _ = decimal.NewFromFloat(refundFee).Div(decimal.NewFromFloat(discount)).Round(2).Float64()
	}

	balance := u.Balance - refundFeeFloat
	if balance < 0 {
		return errors.New("可退余额不足，无法完成退款")
	}

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
		total := decimal.NewFromFloat(model.Fee).Round(2).Mul(decimal.NewFromInt(100)).IntPart()

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

	}

	// 可退金额
	rFee, _ := decimal.NewFromFloat(model.RefundFee).Sub(decimal.NewFromFloat(refundFee)).Round(2).Float64()
	rfParams := map[string]interface{}{
		"refund_fee": rFee,
	}

	if rFee == 0 {
		rfParams["order_status"] = "TRADE_REFUND"
	}

	tx := db.Model(&RechargeOrder{}).Where("id = ?", model.Id).Updates(rfParams)
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

	// 增加退款到退款订单日志
	fee := strconv.FormatFloat(refundFeeFloat, 'f', -1, 64)
	balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

	u.Balance = balance

	rechargeLog := appModel.RechargeLog{
		TargetId: model.Id,
		UserId:   u.Id,
		Type:     1,
		Fee:      fee,
		Balance:  balanceStr,
		Remark:   "余额储值退款",
		CreateAt: time.Now().Unix(),
	}

	tx = db.Create(&rechargeLog)

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

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
		}

	}

	// 收回余额
	tx = db.Where("id = ?", u.Id).Updates(&u)
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return tx.Error
	}

	return nil
}
