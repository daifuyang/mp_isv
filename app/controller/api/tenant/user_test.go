/**
** @创建时间: 2020/10/3 7:43 下午
** @作者　　: return
** @描述　　:
 */
package tenant

import (
	"gincmf/app/model"
	restaurantMigrate "gincmf/plugins/restaurantPlugin/migrate"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"testing"
)

func TestUserController_autoMigrate(t *testing.T) {
	cmf.Initialize("../../../../conf/config.json")
	config :=cmf.Conf()
	dbName := "tenant_870525570"
	cmfModel.CreateTable(dbName,config)
	dsn := cmfModel.NewDsn(dbName,config)
	db := cmfModel.NewDb(dsn,config.Database.Prefix)
	rMigrate := restaurantMigrate.Restaurant{Db: db}
	rMigrate.AutoMigrate()
}
func TestTenantRegisterController_Post(t *testing.T) {
	cmf.Initialize("../../../../conf/config.json")
	config :=cmf.Conf()
	dbName := "tenant_268635852"
	cmfModel.CreateTable(dbName,config)
	dsn := cmfModel.NewDsn(dbName,config)
	db := cmfModel.NewDb(dsn,config.Database.Prefix)
	db.AutoMigrate(&model.User{})
	db.AutoMigrate(&model.MpTheme{})
	db.AutoMigrate(&model.MpThemePage{})
	db.AutoMigrate(&model.Asset{})
}
