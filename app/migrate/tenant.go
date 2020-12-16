/**
** @创建时间: 2020/10/3 1:17 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	model2 "gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type tenant struct {
	Migrate
}

func (u *tenant) AutoMigrate() {
	cmf.Db().AutoMigrate(&model2.Tenant{})

	// 创建索引
	cmf.Db().Migrator().CreateIndex(&model2.Tenant{}, "TenantId")
	cmf.Db().Migrator().CreateIndex(&model2.Tenant{}, "idx_tenant_id")

	cmf.Db().Migrator().CreateIndex(&model2.Tenant{}, "UserLogin")
	cmf.Db().Migrator().CreateIndex(&model2.Tenant{}, "idx_user_login")
}
