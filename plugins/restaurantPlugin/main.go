/**
** @创建时间: 2020/11/23 10:17 上午
** @作者　　: return
** @描述　　:
 */
package restaurantPlugin

import (
	"gincmf/plugins/restaurantPlugin/migrate"
	"gincmf/plugins/restaurantPlugin/router"
)

func Init() {
	regRouter()
}

func regRouter() {
	router.ApiListenRouter()
}

func AutoMigrate(dbName string) {
	migrate.AutoMigrate(dbName)
}
