/**
** @创建时间: 2020/10/29 4:53 下午
** @作者　　: return
** @描述　　:
 */
package plugins

import (
	alipayRouter "gincmf/plugins/alipayPlugin/router"
	demoRouter "gincmf/plugins/demoPlugin/router"
	restaurantRouter "gincmf/plugins/restaurantPlugin/router"
)

func AutoRegister()  {

	// 注册路由
	demoRouter.ApiListenRouter()
	alipayRouter.ApiListenRouter()
	restaurantRouter.ApiListenRouter()

	// 注册数据库迁移
	/*dMigrate := demoMigrate.Demo{}
	dMigrate.AutoMigrate()*/

}
