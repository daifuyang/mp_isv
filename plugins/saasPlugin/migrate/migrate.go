/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	appModel "gincmf/app/model"
	"gincmf/plugins/portalPlugin"
	"gincmf/plugins/restaurantPlugin"
	"gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate () {
	// 租户资源管理器
	cmf.NewDb().AutoMigrate(&appModel.Asset{})


	cmf.NewDb().AutoMigrate(&model.MpTheme{})
	cmf.NewDb().AutoMigrate(&model.MpThemePage{})

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate()
	portalPlugin.AutoMigrate()

}
