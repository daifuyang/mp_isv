/**
** @创建时间: 2020/8/5 7:34 上午
** @作者　　: return
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type authRule struct {
	Migrate
}

func (_ *authRule) AutoMigrate() {
	cmf.NewDb().Migrator().DropTable(&model.AuthRule{})
	cmf.NewDb().AutoMigrate(model.AuthRule{})
	cmf.NewDb().Migrator().DropTable(&model.AuthRuleApi{})
	cmf.NewDb().AutoMigrate(model.AuthRuleApi{})
}
