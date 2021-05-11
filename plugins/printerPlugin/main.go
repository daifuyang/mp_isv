/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package printerPlugin

import (
	"github.com/gincmf/feieSdk"
	"github.com/gincmf/xpyunSdk"
)

func Init() {
	regRouter()
	op := map[string]string{
		"user": "1140444693@qq.com",
		"ukey": "FGmRHjDFZeFDZaHg",
		"url":  "http://api.feieyun.cn/Api/Open/",
	}
	feieSdk.NewOptions(op)

	op = map[string]string{
		"user": "codecloud2020@163.com",
		"ukey": "36e479c092ea4b5fac8e2ab7febc246b",
	}
	xpyunSdk.NewOptions(op)
}

func regRouter() {

}
