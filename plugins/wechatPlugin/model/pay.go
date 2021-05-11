/**
** @创建时间: 2021/5/4 8:39 上午
** @作者　　: return
** @描述　　:
 */
package model

type RequestPayment struct {
	AppId     string `json:"appId"`
	TimeStamp string `json:"timeStamp"`
	NonceStr  string `json:"nonceStr"`
	Package   string `json:"package"`
	SignType  string `json:"signType"`
	PaySign   string `json:"paySign"`
}
