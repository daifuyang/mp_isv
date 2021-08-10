/**
** @创建时间: 2020/8/4 1:09 下午
** @作者　　: return
 */
package migrate

import (
	"gincmf/app/model"
	"gorm.io/gorm"
)

type authAccess struct {
	Db *gorm.DB
	Migrate
}

func (migrate *authAccess) AutoMigrate() {
	migrate.Db.AutoMigrate(model.AuthAccess{})
}
