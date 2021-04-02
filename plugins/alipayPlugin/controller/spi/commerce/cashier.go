/**
** @创建时间: 2020/12/28 12:43 下午
** @作者　　: return
** @描述　　:
 */
package commerce

import (
	"encoding/json"
	"fmt"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/iot"
	"github.com/gincmf/cmf/controller"
	"io/ioutil"
	"net/http"
)

type Cashier struct {
	rc controller.Rest
}

type batchQueryResponse struct {
	iot.AlipayResponse
	CashierList []cashierList `json:"cashier_list"`
}

type cashierList struct {
	CashierId      string `json:"cashier_id"`
	CashierAccount string `json:"cashier_account,omitempty"`
	CashierName    string `json:"cashier_name"`
}

type queryResponse struct {
	iot.AlipayResponse
	Status    string `json:"status"`
	CashierId string `json:"cashier_id"`
}

// 收营员列表
func (rest Cashier) BatchQuery(c *gin.Context) {

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form
	fmt.Println(param)

	var (
		signBytes []byte
		err       error
	)

	r := iot.AlipayResult{}

	cl := []cashierList{
		{
			CashierId:   "001",
			CashierName: "系统收银员",
		},
	}

	fmt.Println(cl)

	qResponse := batchQueryResponse{
		AlipayResponse: iot.AlipayResponse{
			Code: "10000",
			Msg:  "Success",
		},
		CashierList: make([]cashierList, 0),
	}

	r.Response = qResponse

	contentToSign, _ := json.Marshal(&qResponse)
	fmt.Println(string(contentToSign))

	signBytes, err = ioutil.ReadFile("./data/ruyi_pem/private_key.pem")
	if err != nil {
		panic("读取私钥出错，文件不存在！")
	}

	sign := util.ResponseSign(string(contentToSign), string(signBytes))
	r.Sign = sign

	c.JSON(http.StatusOK, r)

}

func (rest Cashier) Query(c *gin.Context) {

	req := c.Request
	req.ParseForm()

	// 获取订单id
	param := req.Form
	fmt.Println(param)

	var (
		signBytes []byte
		err       error
	)

	r := iot.AlipayResult{}

	cl := []cashierList{
		{
			CashierId:   "001",
			CashierName: "系统收银员",
		},
	}

	fmt.Println(cl)

	qResponse := queryResponse{
		AlipayResponse: iot.AlipayResponse{
			Code: "10000",
			Msg:  "Success",
		},
		Status:    "1",
		CashierId: "001",
	}

	r.Response = qResponse

	contentToSign, _ := json.Marshal(&qResponse)
	fmt.Println(string(contentToSign))

	signBytes, err = ioutil.ReadFile("./data/ruyi_pem/private_key.pem")
	if err != nil {
		panic("读取私钥出错，文件不存在！")
	}

	sign := util.ResponseSign(string(contentToSign), string(signBytes))
	r.Sign = sign

	c.JSON(http.StatusOK, r)
}

// 签退
func (rest Cashier) UnSign(c *gin.Context) {

}
