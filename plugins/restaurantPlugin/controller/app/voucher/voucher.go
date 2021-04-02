/**
** @创建时间: 2020/12/11 5:07 下午
** @作者　　: return
** @描述　　: 根据优惠券id获取
 */
package voucher

import (
	"encoding/json"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"net/http"
	"strings"
	"time"
)

type Voucher struct {
	rc controller.Rest
}

// @Summary 优惠券列表
// @Description 获取个人优惠券列表
// @Tags app 优惠券列表
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.Desk} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /app/voucher [get]
func (rest *Voucher) Get(c *gin.Context) {

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	mid, _ := c.Get("mid")

	status := c.Query("status")

	data, err := new(model.VoucherPost).Index(c, []string{"user_id = ? AND p.mid = ? AND p.status = ?"}, []interface{}{userId, mid, status})
	if err != nil {
		rest.rc.Error(c, "获取失败！", err.Error())
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Voucher) List(c *gin.Context) {

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")
	mid, _ := c.Get("mid")
	status := 0

	data, err := new(model.VoucherPost).List([]string{"user_id = ? AND p.mid = ? AND p.status = ?"}, []interface{}{userId, mid, status})
	if err != nil {
		rest.rc.Error(c, "获取失败！", err.Error())
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Voucher) ReceiveNotify(c *gin.Context) {

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

	orderId := strings.Join(param["out_trade_no"], "")

	voucherDetailList := strings.Join(param["voucher_detail_list"], "")

	var voucherDetailMap struct {
		Amount             string `json:"amount"`
		MerchantContribute string `json:"merchantContribute"`
		Name               string `json:"name"`
		OtherContribute    string `json:"otherContribute"`
		Type               string `json:"type"`
		VoucherId          string `json:"voucherId"`
	}

	json.Unmarshal([]byte(voucherDetailList), &voucherDetailMap)

	var fo model.FoodOrder

	tx := cmf.NewDb().Debug().Where("order_id", orderId).First(&fo)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	vp := model.VoucherPost{}

	cmf.NewDb().Where("alipay_voucher_id = ?", voucherDetailMap.VoucherId).First(&vp)

	vp.Status = 1
	vp.UpdateAt = time.Now().Unix()

	tx = cmf.NewDb().Where("alipay_voucher_id = ?", voucherDetailMap.VoucherId).Updates(vp)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	fo.VoucherId = vp.Id
	cmf.NewDb().Where("order_id", orderId).Updates(&fo)

	c.String(http.StatusOK, "success")
}
