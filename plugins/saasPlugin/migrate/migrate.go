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

func AutoMigrate(dbName string) {

	// 租户资源管理器
	cmf.ManualDb(dbName).AutoMigrate(&model.Asset{})
	cmf.ManualDb(dbName).AutoMigrate(&model.MpTheme{})
	cmf.ManualDb(dbName).AutoMigrate(&model.MpThemeAdminUserPost{})
	cmf.ManualDb(dbName).AutoMigrate(&model.MpThemeVersion{})
	cmf.ManualDb(dbName).AutoMigrate(&model.MpThemePage{})

	cmf.ManualDb(dbName).Migrator().DropTable(&appModel.AdminMenu{})
	cmf.ManualDb(dbName).AutoMigrate(&appModel.AdminMenu{})

	cmf.ManualDb(dbName).AutoMigrate(&model.Role{})
	cmf.ManualDb(dbName).AutoMigrate(&appModel.RoleUser{})

	cmf.ManualDb(dbName).AutoMigrate(&model.AuthAccess{})
	cmf.ManualDb(dbName).Migrator().DropTable(&appModel.AuthRule{})
	cmf.ManualDb(dbName).AutoMigrate(&appModel.AuthRule{})
	cmf.ManualDb(dbName).Migrator().DropTable(&appModel.AuthRuleApi{})
	cmf.ManualDb(dbName).AutoMigrate(&appModel.AuthRuleApi{})

	adminUser := model.AdminUser{
		Db: cmf.ManualDb(dbName),
	}
	adminUser.AutoMigrate()

	cmf.ManualDb(dbName).AutoMigrate(&model.AdminNotice{})
	cmf.ManualDb(dbName).AutoMigrate(&appModel.PayLog{})

	scoreLog := appModel.ScoreLog{
		Db: cmf.ManualDb(dbName),
	}
	scoreLog.AutoMigrate()

	expLog := appModel.ExpLog{
		Db: cmf.ManualDb(dbName),
	}
	expLog.AutoMigrate()

	rechargeLog := appModel.RechargeLog{
		Db: cmf.ManualDb(dbName),
	}

	rechargeLog.AutoMigrate()

	wechatMigrate.AutoMigrate(dbName)

	appModel.AutoAdminMenu(dbName)

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate(dbName)
	portalPlugin.AutoMigrate(dbName)

}
