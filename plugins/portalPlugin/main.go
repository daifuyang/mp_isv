/**
** @创建时间: 2020/11/25 2:49 下午
** @作者　　: return
** @描述　　:
 */
package portalPlugin

import (
	"gincmf/plugins/portalPlugin/migrate"
	"gincmf/plugins/portalPlugin/router"
)

func Router()  {
	router.ApiListenRouter()
}

func AutoMigrate()  {
	migrate.AutoMigrate()
}

func Init()  {
	Router()
}