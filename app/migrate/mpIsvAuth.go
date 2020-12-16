/**
** @创建时间: 2020/9/7 11:01 上午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type mpIsvAuth struct {
	Migrate
}

func (_ *mpIsvAuth) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model.MpIsvAuth{})

	// 检查索引
	b := cmf.NewDb().Migrator().HasIndex(&model.MpIsvAuth{}, "idx_id")
	if !b {
		// 新建索引
		cmf.NewDb().Migrator().CreateIndex(&model.MpIsvAuth{}, "idx_id")
	}
}
