/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/portalPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate(dbName string) {
	cmf.ManualDb(dbName).AutoMigrate(&model.PortalCategory{})
	cmf.ManualDb(dbName).AutoMigrate(&model.PortalPost{})
	cmf.ManualDb(dbName).AutoMigrate(&model.PortalCategoryPost{})

	portalTag := model.PortalTag{
		Db: cmf.ManualDb(dbName),
	}

	portalTag.AutoMigrate()
}
