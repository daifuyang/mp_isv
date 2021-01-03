/**
** @创建时间: 2020/10/29 4:53 下午
** @作者　　: return
** @描述　　:
 */
package plugins

import (
	"gincmf/plugins/alipayPlugin"
	"gincmf/plugins/demoPlugin"
	"gincmf/plugins/feiePlugin"
	"gincmf/plugins/queuePlugin"
	"gincmf/plugins/restaurantPlugin"
	"gincmf/plugins/saasPlugin"
)

func AutoRegister() {
	// 注册阿里的插件
	alipayPlugin.Init()
	demoPlugin.Init()
	restaurantPlugin.Init()
	saasPlugin.Init()
	queuePlugin.Init()
	feiePlugin.Init()
	AutoMigrate()
}

func AutoMigrate() {

}
