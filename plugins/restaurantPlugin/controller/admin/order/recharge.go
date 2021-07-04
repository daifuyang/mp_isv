/**
** @创建时间: 2021/2/20 1:30 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"strings"
)

type Recharge struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取全部会员订单
 * @Date 2021/2/20 13:31:3
 * @Param
 * @return
 **/
func (rest Recharge) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"ro.mid = ?"}
	var queryArgs = []interface{}{mid}

	keywords := c.Query("keywords")

	if keywords != "" {
		var querySub = []string{"(ro.order_id LIKE ?", "ro.trade_no LIKE ?", "u.user_nickname LIKE ?", "u.user_realname LIKE ?)"}

		querySubStr := strings.Join(querySub, " OR ")

		querySubStr = strings.ReplaceAll(querySubStr, "?", "'%"+keywords+"%'")

		query = append(query, querySubStr)
	}

	data, err := new(model.RechargeOrder).Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2021/6/25 13:48:44
 * @Param
 * @return
 **/
func (rest Recharge) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	ro := model.RechargeOrder{}
	tx := cmf.NewDb().Where("id = ? and mid = ?", rewrite.Id, mid).First(&ro)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "订单不存在", nil)
		return
	}

	rest.rc.Success(c, "获取成功", ro)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 退款储值订单
 * @Date 2021/6/25 11:4:18
 * @Param
 * @return
 **/
func (rest Recharge) Refund(c *gin.Context) {

	/*
		1.查询退款订单是否存在并且状态是否正确
		2.判断可退金额是否超出剩余可退金额
		3.回收退款金额和用户余额，如果余额不足可退金额则无法退款
	*/

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	refundFee := c.PostForm("refund_fee")

	if refundFee == "" {
		rest.rc.Error(c, "退款金额不能为空！", nil)
		return
	}

	refundFeeFloat, err := strconv.ParseFloat(refundFee, 64)
	if err != nil {
		rest.rc.Error(c, "退款金额不是有效值！", nil)
		return
	}

	refundReason := c.PostForm("refund_reason")

	if refundReason == "" {
		rest.rc.Error(c, "退款理由不能为空！", nil)
		return
	}

	txBegin := cmf.NewDb().Begin()
	defer func() {
		if r := recover(); r != nil {
			txBegin.RollbackTo("sp1")
		}
	}()

	var query = []string{"mid = ?", " id = ?"}
	var queryArgs = []interface{}{mid, rewrite.Id}
	queryStr := strings.Join(query, " AND ")

	ro := model.RechargeOrder{}
	tx := txBegin.Where(queryStr, queryArgs...).First(&ro)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if ro.Id == 0 {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "订单不存在", nil)
		return
	}

	if !(ro.OrderStatus == "TRADE_SUCCESS" || ro.OrderStatus == "TRADE_FINISHED") {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "订单状态不正确", nil)
		return
	}

	if ro.RefundFee < refundFeeFloat {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, "非法退款，超出可退金额", nil)
		return
	}

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

	at := ""
	if akExist {
		at = authorizerAccessToken.(string)
	}
	ro.Db = txBegin
	err = ro.Refund(refundFeeFloat, refundReason, at)

	fmt.Println("err", err)

	if err != nil {
		txBegin.RollbackTo("sp1")
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	txBegin.Commit()

	rest.rc.Success(c, "退款成功！", nil)

}
