/**
** @创建时间: 2020/9/7 11:01 上午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

type mpIsvAuth struct {
	Migrate
	Db *gorm.DB
}

func (migrate *mpIsvAuth) AutoMigrate() {
	cmf.Db().AutoMigrate(&model.MpIsvAuth{})

	// 检查索引
	b := migrate.Db.Migrator().HasIndex(&model.MpIsvAuth{}, "idx_id")
	if !b {
		// 新建索引
		migrate.Db.Migrator().CreateIndex(&model.MpIsvAuth{}, "idx_id")
	}
}
