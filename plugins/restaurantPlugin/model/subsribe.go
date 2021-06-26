/**
** @创建时间: 2021/5/9 3:32 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"gincmf/plugins/wechatPlugin/model"
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
	Mid         int    `json:"mid"`
}

// 下单成功
func (rest *Subscribe) TradeSuccess() error {

	if rest.Type == "wechat" {

		sub, err := new(model.Subscribe).Show(rest.Mid)
		if err != nil {
			return err
		}

		if sub.PayTmpId != "" {

			ak := rest.AccessToken

			keywords := map[string]interface{}{
				"thing45": map[string]string{
					"value": rest.StoreName,
				},
				"character_string37": map[string]string{
					"value": rest.OrderId,
				},
				"amount12": map[string]string{
					"value": rest.Fee + "元",
				},
				"date4": map[string]string{
					"value": rest.CreateTime,
				},
				"thing26": map[string]string{
					"value": rest.Remark,
				},
			}

			bizContent := map[string]interface{}{
				"touser":            rest.OpenId,
				"template_id":       sub.PayTmpId,
				"page":              "pages/order/detail?id=" + strconv.Itoa(rest.Id),
				"miniprogram_state": "formal",
				"data":              keywords,
			}

			response := new(open.Subscribe).Send(ak, bizContent)

			if response.Errcode != 0 {
				return errors.New(response.Errmsg)
			}
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

		sub, err := new(model.Subscribe).Show(rest.Mid)
		if err != nil {
			return err
		}

		if sub.RefundTmpId != "" {

			ak := rest.AccessToken

			keywords := map[string]interface{}{
				"thing8": map[string]string{
					"value": rest.StoreName,
				},
				"amount5": map[string]string{
					"value": rest.Fee + "元",
				},
				"character_string7": map[string]string{
					"value": rest.OrderId,
				},
				"thing9": map[string]string{
					"value": rest.Remark,
				},
			}

			bizContent := map[string]interface{}{
				"touser":            rest.OpenId,
				"template_id":       sub.RefundTmpId,
				"page":              "pages/order/detail?id=" + strconv.Itoa(rest.Id),
				"miniprogram_state": "formal",
				"data":              keywords,
			}

			response := new(open.Subscribe).Send(ak, bizContent)

			if response.Errcode != 0 {
				return errors.New(response.Errmsg)
			}
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
