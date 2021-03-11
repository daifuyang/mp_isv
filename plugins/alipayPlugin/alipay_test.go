/**
** @创建时间: 2020/12/7 7:01 下午
** @作者　　: return
** @描述　　:
 */
package alipayPlugin

import (
	"github.com/gincmf/alipayEasySdk"
	"github.com/gincmf/alipayEasySdk/logistics"
	"testing"
)

func Test_InstantDelivery(t *testing.T) {
	op := map[string]string{
		"protocol":    "https",
		"gatewayHost": "openapi.alipay.com/gateway.do",
		"signType":    "RSA2",
		"appId":       "2021001192664075",
		"version":     "1.0",
		"charset":     "utf-8",
		"notifyUrl":   "http://www.codecloud.ltd/api/v1/app/alipay/receive_notify",
		"AppCertPath": "../../data/pem",
		"AliCertPath": "../../data/pem",
	}
	alipayEasySdk.NewOptions(op)

	alipayEasySdk.SetOption("AppAuthToken", "202012BBc94d62297edb49e385e2136023b0dX61")
	instantDelivery := logistics.InstantDelivery{}
	instantDelivery.Query(nil)

	//account := logistics.Account{}
	//bizContent := make(map[string]interface{}, 0)
	//bizContent["out_biz_no"] = "test123"
	//bizContent["logistics_codes"] = "ISTD"
	//account.Create(bizContent)

	//ms := logistics.MerchantShop{}
	//bizContent = make(map[string]interface{}, 0)
	//bizContent["out_biz_no"] = "test123"
	//bizContent["shop_no"] = "001"
	//bizContent["shop_name"] = "001"
	//bizContent["shop_category"] = "1715"
	//bizContent["enterprise_province"] = "310000"
	//bizContent["enterprise_city"] = "310100"
	//bizContent["enterprise_district"] = "310113"
	//bizContent["detail_address"] = "殷高西路地铁站"
	//bizContent["contact_name"] = "张三"
	//bizContent["phone"] = "15161178722"
	//bizContent["longitude"] = "121.484856"
	//bizContent["latitude"] = "31.320005"
	//
	//ms.Create(bizContent)
}
