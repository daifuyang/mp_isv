/**
** @创建时间: 2021/6/29 7:43 下午
** @作者　　: return
** @描述　　:
 */
package nsqPlugin

import (
	"gincmf/plugins/nsqPlugin/Consumer"
)

func Init() {
	go func() {
		new(Consumer.Nsq).Init()
	}()
}
