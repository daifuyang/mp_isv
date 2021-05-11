/**
** @创建时间: 2020/12/27 2:59 下午
** @作者　　: return
** @描述　　:
 */
package merchant

import (
	"encoding/json"
	"fmt"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/iot"
	"github.com/gincmf/alipayEasySdk/payment"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	"io/ioutil"
	"net/http"
	"strings"
	"time"
)

type Order struct {
	rc controller.Rest
}

type payResponse struct {
	iot.AlipayResponse
	MerchantOrderNo  string `json:"merchant_order_no"`
	IsvOrderNo       string `json:"isv_order_no"`
	ChannelOrderNo   string `json:"channel_order_no"`
	ChannelType      string `json:"channel_type,omitempty"`
	OrderState       string `json:"order_state"`
	PayTime          string `json:"pay_time"`
	TotalAmount      string `json:"total_amount"`
	ReceiptAmount    string `json:"receipt_amount"`
	BuyerPayAmount   string `json:"buyer_pay_amount"`
	BuyerUserId      string `json:"buyer_user_id"`
	BuyerAccountName string `json:"buyer_account_name"`
	AttachParams     string `json:"attach_params"`
	ErrorCode        string `json:"error_code"`
	ErrorDesc        string `json:"error_desc"`
}

func (rest *Order) Test(c *gin.Context) {

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form

	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	privateData, err := ioutil.ReadFile("./data/ruyiPem/private_key.pem")
	if err != nil {
		panic("读取私钥出错，文件不存在！")
	}

	if len(getParams) > 0 {
		getParams = getParams[:len(getParams)-1]
		cmfLog.Info(getParams)
	}

	r := iot.AlipayResult{
		Response: iot.AlipayResponse{
			Code: "10000",
			Msg:  "Success",
		},
	}

	contentToSign, _ := json.Marshal(&r.Response)
	fmt.Println(string(contentToSign))

	sign := util.ResponseSign(string(contentToSign), string(privateData))

	r.Sign = sign

	c.JSON(http.StatusOK, r)

}

// 收款
func (rest *Order) Pay(c *gin.Context) {

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form

	merchantTradeNo := strings.Join(param["merchant_order_no"], "")
	authCode := strings.Join(param["auth_code"], "")
	subject := strings.Join(param["subject"], "")
	totalAmount := strings.Join(param["total_amount"], "")

	if subject == "" {
		subject = "IOT当面付"
	}

	// 创建收款
	bizContent := map[string]interface{}{
		"out_trade_no": merchantTradeNo,
		"scene":        "bar_code",
		"auth_code":    authCode,
		"subject":      subject,
		"total_amount": totalAmount,
	}

	result := new(payment.FaceToFace).Pay(bizContent)

	var (
		signBytes []byte
		err       error
	)

	r := iot.AlipayResult{}

	if result.Response.Code == "10000" {
		r.Response = payResponse{
			AlipayResponse: iot.AlipayResponse{
				Code: "10000",
				Msg:  "Success",
			},
			MerchantOrderNo:  merchantTradeNo,
			IsvOrderNo:       result.Response.OutTradeNo,
			ChannelOrderNo:   result.Response.TradeNo,
			OrderState:       "ORDER_SUCCESS",
			PayTime:          time.Unix(time.Now().Unix(), 0).Format(data.TimeLayout),
			TotalAmount:      result.Response.TotalAmount,
			ReceiptAmount:    result.Response.ReceiptAmount,
			BuyerAccountName: result.Response.BuyerLogonId,
		}
	} else {

		subCode := "BIZ_ERROR"
		subMsg := "业务异常"

		switch result.Response.SubCode {
		case "ACQ.ACCESS_FORBIDDEN":
			subCode = "MERCHANT_UNSIGN"
			subMsg = "商户未签约"
		case "ACQ.TRADE_HAS_CLOSE":
			subCode = "ORDER_HAS_CLOSED"
			subMsg = "订单已关闭，不允许再次支付"
		}

		r.Response = iot.AlipayResponse{
			Code:    "40004",
			Msg:     "Business Failed",
			SubCode: subCode,
			SubMsg:  subMsg,
		}
	}

	contentToSign, _ := json.Marshal(&r.Response)

	signBytes, err = ioutil.ReadFile("./data/ruyi_pem/private_key.pem")
	if err != nil {
		panic("读取私钥出错，文件不存在！")
	}

	sign := util.ResponseSign(string(contentToSign), string(signBytes))
	r.Sign = sign

	c.JSON(http.StatusOK, r)

}

// 查询

func (rest *Order) Query(c *gin.Context) {

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form

	fmt.Println(param)

	//merchantOrderNo := strings.Join(param["merchant_order_no"],"")
	//isvOrderNo := time.Now().Unix()
	//terminalId := strings.Join(param["terminal_id"],"")
	//orderState := strings.Join(param["order_state"],"")

	var (
		signBytes []byte
		err       error
	)

	r := iot.AlipayResult{

	}

	r.Response = iot.AlipayResponse{
		Code: "10000",
		Msg:  "Success",
	}

	contentToSign, _ := json.Marshal(&r.Response)
	fmt.Println(string(contentToSign))

	signBytes, err = ioutil.ReadFile("./data/ruyi_pem/private_key.pem")
	if err != nil {
		panic("读取私钥出错，文件不存在！")
	}

	sign := util.ResponseSign(string(contentToSign), string(signBytes))
	r.Sign = sign

	c.JSON(http.StatusOK, r)

}
