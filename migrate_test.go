/**
** @创建时间: 2020/11/9 5:46 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"gincmf/app/migrate"
	saasMigrate "gincmf/plugins/saasPlugin/migrate"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func Test_Migrate(t *testing.T) {
	cmf.Initialize("./data/conf/config.json")
	migrate.StartMigrate()
	cmf.ManualDb("tenant_1051453199")
	migrate.StartTenantMigrate()
	saasMigrate.AutoMigrate()
}
