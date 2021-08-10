/**
** @创建时间: 2020/10/3 1:17 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	saasModel "gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type tenant struct {
	Migrate
}

func (u *tenant) AutoMigrate() {
	cmf.Db().AutoMigrate(&saasModel.Tenant{})

	// 创建索引
	cmf.Db().Migrator().CreateIndex(&saasModel.Tenant{}, "TenantId")
	cmf.Db().Migrator().CreateIndex(&saasModel.Tenant{}, "idx_tenant_id")

	cmf.Db().Migrator().CreateIndex(&saasModel.Tenant{}, "UserLogin")
	cmf.Db().Migrator().CreateIndex(&saasModel.Tenant{}, "idx_user_login")
}
