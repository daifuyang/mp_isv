/**
** @创建时间: 2021/3/1 12:22 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"github.com/gincmf/alipayEasySdk"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func Test_minCategory(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	host := cmf.Conf().App.Domain

	if cmf.Conf().App.AppDebug {
		host = "https://www.codecloud.ltd"
	}

	op := map[string]string{
		"protocol":    "https",
		"gatewayHost": "openapi.alipay.com/gateway.do",
		"signType":    "RSA2",
		"appId":       "2021001192664075",
		"version":     "1.0",
		"charset":     "utf-8",
		"notifyUrl":   host + "/api/v1/app/alipay/receive_notify",
		"AppCertPath": "../../data/pem",
		"AliCertPath": "../../data/pem",
	}
	alipayEasySdk.NewOptions(op)
	alipayEasySdk.SetOption("AppAuthToken", "202102BB5c9187e1e28148f7a202c921cd8e6X61")

	//bizContent := make(map[string]interface{}, 0)
	//bizContent["is_filter"] = "true"
	//result := new(mini.Category).Query(bizContent)
	// recursionCategory(result.Response.CategoryList,"0",0)
}
