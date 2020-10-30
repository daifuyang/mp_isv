/**
** @创建时间: 2020/10/3 1:17 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type tenant struct {
	Migrate
}

func (u *tenant) AutoMigrate() {
	cmf.Db.AutoMigrate(&model.Tenant{})
}
