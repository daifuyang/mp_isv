/**
** @创建时间: 2021/3/18 12:12 上午
** @作者　　: return
** @描述　　:
 */
package model

type VoucherDetailList struct {
	Amount             string `json:"amount"`
	FundChannel        string `json:"fund_channel"`
	MerchantContribute string `json:"merchantContribute"`
	Name               string `json:"name"`
	OtherContribute    string `json:"otherContribute"`
	Type               string `json:"type"`
	VoucherId          string `json:"voucherId"`
}
