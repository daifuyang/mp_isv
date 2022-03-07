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

func (migrate *authRule) AutoMigrate() {
	cmf.Db().Migrator().DropTable(&model.AuthRule{})
	cmf.Db().AutoMigrate(model.AuthRule{})
	cmf.Db().Migrator().DropTable(&model.AuthRuleApi{})
	cmf.Db().AutoMigrate(model.AuthRuleApi{})
}
