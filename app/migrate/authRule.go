/**
** @创建时间: 2020/8/5 7:34 上午
** @作者　　: return
 */
package migrate

import (
	"gincmf/app/model"
	"gorm.io/gorm"
)

type authRule struct {
	Migrate
	Db *gorm.DB
}

func (migrate *authRule) AutoMigrate() {
	migrate.Db.Migrator().DropTable(&model.AuthRule{})
	migrate.Db.AutoMigrate(model.AuthRule{})
	migrate.Db.Migrator().DropTable(&model.AuthRuleApi{})
	migrate.Db.AutoMigrate(model.AuthRuleApi{})
}
