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
	wechatMigrate "gincmf/plugins/wechatPlugin/migrate"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate() {

	// 租户资源管理器
	cmf.NewDb().AutoMigrate(&model.Asset{})
	cmf.NewDb().AutoMigrate(&model.MpTheme{})
	cmf.NewDb().AutoMigrate(&model.MpThemeAdminUserPost{})
	cmf.NewDb().AutoMigrate(&model.MpThemeVersion{})
	cmf.NewDb().AutoMigrate(&model.MpThemePage{})

	cmf.NewDb().Migrator().DropTable(&appModel.AdminMenu{})
	cmf.NewDb().AutoMigrate(&appModel.AdminMenu{})

	cmf.NewDb().AutoMigrate(&model.Role{})
	cmf.NewDb().AutoMigrate(&appModel.RoleUser{})

	cmf.NewDb().AutoMigrate(&model.AuthAccess{})
	cmf.NewDb().Migrator().DropTable(&appModel.AuthRule{})
	cmf.NewDb().AutoMigrate(&appModel.AuthRule{})
	cmf.NewDb().Migrator().DropTable(&appModel.AuthRuleApi{})
	cmf.NewDb().AutoMigrate(&appModel.AuthRuleApi{})

	new(model.AdminUser).AutoMigrate()
	cmf.NewDb().AutoMigrate(&model.AdminNotice{})
	cmf.NewDb().AutoMigrate(&appModel.PayLog{})

	new(appModel.ScoreLog).AutoMigrate()
	new(appModel.ExpLog).AutoMigrate()
	new(appModel.RechargeLog).AutoMigrate()

	new(wechatMigrate.Migrate).AutoMigrate()

	appModel.AutoAdminMenu()

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate()
	portalPlugin.AutoMigrate()

}
