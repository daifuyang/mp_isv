/**
** @创建时间: 2021/5/9 3:32 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"github.com/gincmf/alipayEasySdk/mini"
	"github.com/gincmf/wechatEasySdk/open"
	"strconv"
)

type Subscribe struct {
	Type        string `json:"type"`
	AccessToken string `json:"access_token"`
	StoreName   string `json:"store_name"`
	OrderId     string `json:"order_id"`
	OpenId      string `json:"open_id"`
	Fee         string `json:"fee"`
	CreateTime  string `json:"create_time"`
	Remark      string `json:"remark"`
	Id          int    `json:"id"`
}

// 下单成功
func (rest *Subscribe) TradeSuccess() error {

	if rest.Type == "wechat" {

		ak := rest.AccessToken

		keywords := map[string]interface{}{
			"name1": map[string]string{
				"value": rest.StoreName,
			},
			"character_string4": map[string]string{
				"value": rest.OrderId,
			},
			"amount3": map[string]string{
				"value": rest.Fee + "元",
			},
			"date2": map[string]string{
				"value": rest.CreateTime,
			},
			"thing5": map[string]string{
				"value": rest.Remark,
			},
		}

		bizContent := map[string]interface{}{
			"touser":            rest.OpenId,
			"template_id":       "6rhlDbE3jLNQSqZQ-vKRx2vzuTZj8-W4-vnMPV0hs4s",
			"page":              "pages/order/detail?id=" + strconv.Itoa(rest.Id),
			"miniprogram_state": "developer",
			"data":              keywords,
		}

		response := new(open.Subscribe).Send(ak, bizContent)

		if response.Errcode != 0 {
			return errors.New(response.Errmsg)
		}

		return nil

	}

	if rest.Type == "alipay" {

		keywords := map[string]interface{}{
			"keyword1": map[string]string{
				"value": rest.StoreName,
			},
			"keyword2": map[string]string{
				"value": rest.OrderId,
			},
			"keyword3": map[string]string{
				"value": rest.Fee + "元",
			},
			"keyword4": map[string]string{
				"value": rest.CreateTime,
			},
			"keyword5": map[string]string{
				"value": rest.Remark,
			},
		}

		bizContent := map[string]interface{}{
			"to_user_id":       rest.OpenId,
			"form_id":          rest.AccessToken,
			"user_template_id": "PMae481363a4d2479c91a858a8e867f923",
			"page":             "pages/order/detail?id=" + strconv.Itoa(rest.Id),
			"data":             keywords,
		}

		messageResult := new(mini.TemplateMessage).Send(bizContent)

		if messageResult.Response.Code != "10000" {
			return errors.New(messageResult.Response.SubMsg)
		}

		return nil

	}

	return errors.New("类型不能为空！")

}

// 退款
func (rest *Subscribe) TradeRefund() error {

	if rest.Type == "wechat" {

		ak := rest.AccessToken

		keywords := map[string]interface{}{
			"thing12": map[string]string{
				"value": rest.StoreName,
			},
			"amount1": map[string]string{
				"value": rest.Fee + "元",
			},
			"character_string3": map[string]string{
				"value": rest.OrderId,
			},
			"thing6": map[string]string{
				"value": rest.Remark,
			},
		}

		bizContent := map[string]interface{}{
			"touser":            rest.OpenId,
			"template_id":       "88hff1XEBlptsP2U-uHV0td6xj2heHhx_oB6tlfE4LU",
			"page":              "pages/order/detail?id=" + strconv.Itoa(rest.Id),
			"miniprogram_state": "developer",
			"data":              keywords,
		}

		response := new(open.Subscribe).Send(ak, bizContent)

		if response.Errcode != 0 {
			return errors.New(response.Errmsg)
		}

		return nil

	}

	if rest.Type == "alipay" {

		keywords := map[string]interface{}{
			"keyword1": map[string]string{
				"value": rest.StoreName,
			},
			"keyword2": map[string]string{
				"value": rest.Fee + "元",
			},
			"keyword3": map[string]string{
				"value": rest.OrderId,
			},
			"keyword4": map[string]string{
				"value": rest.Remark,
			},
		}

		bizContent := map[string]interface{}{
			"to_user_id":       rest.OpenId,
			"form_id":          rest.AccessToken,
			"user_template_id": "PM1074b47fe64844de9cea5186c743e728",
			"page":             "pages/order/detail?id=" + strconv.Itoa(rest.Id),
			"data":             keywords,
		}

		messageResult := new(mini.TemplateMessage).Send(bizContent)

		if messageResult.Response.Code != "10000" {
			return errors.New(messageResult.Response.SubMsg)
		}

		return nil

	}

	return errors.New("类型不能为空！")

}
