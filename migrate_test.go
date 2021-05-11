/**
** @创建时间: 2020/11/9 5:46 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	appMigrate "gincmf/app/migrate"
	"gincmf/app/model"
	saasMigrate "gincmf/plugins/saasPlugin/migrate"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func Test_Migrate(t *testing.T) {
	cmf.Initialize("./data/conf/config.json")
	appMigrate.StartMigrate()
	cmf.ManualDb("tenant_562847651")
	saasMigrate.AutoMigrate()
	//new(saasModel.Role).Init(123456)
	// 创建当前租户的七牛云空间

	/*user := saasModel.AdminUser{
		UserLogin: "17625458588",
		Mobile:    "17625458588",
		UserPass:  "3ffc0ef0ced4e6824cc61b5afdedcff4",
		CreateAt:  time.Now().Unix(),
	}
	user.Init()*/
}

func Test_menu(t *testing.T) {

	cmf.Initialize("./data/conf/config.json")
	cmf.ManualDb("tenant_562847651")
	cmf.NewDb().Migrator().DropTable(&model.AdminMenu{})
	cmf.NewDb().AutoMigrate(&model.AdminMenu{})
	model.AutoAdminMenu()

}
