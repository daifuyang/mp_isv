/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	appMigrate "gincmf/app/migrate"
	appModel "gincmf/app/model"
	"gincmf/plugins/portalPlugin"
	"gincmf/plugins/restaurantPlugin"
	"gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate() {

	// 租户资源管理器
	cmf.NewDb().AutoMigrate(&model.Asset{})
	cmf.NewDb().AutoMigrate(&model.MpTheme{})
	cmf.NewDb().AutoMigrate(&model.MpThemeVersion{})
	cmf.NewDb().AutoMigrate(&model.MpThemePage{})

	cmf.NewDb().Migrator().DropTable(&appModel.AdminMenu{})
	cmf.NewDb().AutoMigrate(&appModel.AdminMenu{})

	appModel.AutoAdminMenu()
	appMigrate.StartTenantMigrate()

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate()
	portalPlugin.AutoMigrate()

}
