/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	"gincmf/plugins/restaurantPlugin"
	model2 "gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate () {
	// 租户创建user表
	cmf.NewDb().AutoMigrate(&model.User{})
	cmf.NewDb().AutoMigrate(&model.MpTheme{})
	cmf.NewDb().AutoMigrate(&model.MpThemePage{})

	// 租户资源管理器
	cmf.NewDb().AutoMigrate(&model.Asset{})

	// 地址
	cmf.NewDb().AutoMigrate(&model2.Address{})

	// 餐厅插件
	// 租户同步数据库迁移
	restaurantPlugin.AutoMigrate()

}
