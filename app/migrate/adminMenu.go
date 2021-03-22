/**
* @创建时间: 2020/7/15 5:05 下午
* @作者　　: return
 */
package migrate

import (
	appModel "gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type AdminMenu struct {
	Migrate
}

func (_ *AdminMenu) AutoMigrate() {
	cmf.Db().Migrator().DropTable(&appModel.AdminMenu{})
	cmf.Db().AutoMigrate(&appModel.AdminMenu{})
}
