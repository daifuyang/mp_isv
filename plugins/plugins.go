/**
** @创建时间: 2020/10/29 4:53 下午
** @作者　　: return
** @描述　　:
 */
package plugins

import (
	"gincmf/plugins/alipayPlugin"
	"gincmf/plugins/portalPlugin"
	"gincmf/plugins/printerPlugin"
	"gincmf/plugins/qiniuPlugin"
	"gincmf/plugins/queuePlugin"
	"gincmf/plugins/restaurantPlugin"
	"gincmf/plugins/saasPlugin"
	"gincmf/plugins/wechatPlugin"
)

func AutoRegister() {
	// 注册阿里的插件
	alipayPlugin.Init()
	restaurantPlugin.Init()
	saasPlugin.Init()
	queuePlugin.Init()
	printerPlugin.Init()
	portalPlugin.Init()
	qiniuPlugin.Init()
	wechatPlugin.Init()
}
