/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package saasPlugin

import (
	"gincmf/plugins/saasPlugin/migrate"
	"gincmf/plugins/saasPlugin/router"
)

func Init() {
	router.ApiListenRouter()
}

func AutoMigrate(dbName string) {
	migrate.AutoMigrate(dbName)
}
