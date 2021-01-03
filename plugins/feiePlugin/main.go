/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package feiePlugin

import (
	"github.com/gincmf/feieSdk"
)

func Init() {
	regRouter()
	op := map[string]string{
		"user": "1140444693@qq.com",
		"ukey": "FGmRHjDFZeFDZaHg",
		"url":  "http://api.feieyun.cn/Api/Open/",
	}
	feieSdk.NewOptions(op)
}

func regRouter() {

}
