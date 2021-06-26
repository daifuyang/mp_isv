/**
** @创建时间: 2020/12/30 9:48 下午
** @作者　　: return
** @描述　　:
 */
package controller

import (
	"gincmf/plugins/alipayPlugin/controller/getway"
	"github.com/gin-gonic/gin"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"strings"
)

type GetWay struct {
	rc controller.Rest
}

func (rest *GetWay) GetWay(c *gin.Context) {

	req := c.Request
	req.ParseForm()
	// 获取订单id
	param := req.Form

	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	getParams = getParams[:len(getParams)-1]
	cmfLog.Save(getParams, "getway.log")

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

	method := strings.Join(param["msg_method"], "")

	switch method {
	case "ant.merchant.expand.shop.save.passed":

		// 主动通知
		err := new(getway.Merchant).Passed(param)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		// 同意门店审核
	case "ant.merchant.expand.shop.save.rejected":

		// 拒绝
		err := new(getway.Merchant).Rejected(param)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	rest.rc.Success(c, "回调成功！", nil)

}
