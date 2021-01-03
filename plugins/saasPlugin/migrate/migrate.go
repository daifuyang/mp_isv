/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	appModel "gincmf/app/model"
	"gincmf/plugins/restaurantPlugin"
	"gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate () {
	cmf.NewDb().AutoMigrate(&appModel.MpTheme{})
	cmf.NewDb().AutoMigrate(&appModel.MpThemePage{})

	// 租户资源管理器
	cmf.NewDb().AutoMigrate(&appModel.Asset{})

	// 地址
	cmf.NewDb().AutoMigrate(&model.Address{})

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate()

}
