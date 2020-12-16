/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package queuePlugin

import (
	"gincmf/plugins/queuePlugin/controller"
)

func Init()  {
	queue := controller.Queue{}
	queue.Init()
	queue.Queue()
}
