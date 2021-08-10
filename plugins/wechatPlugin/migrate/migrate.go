/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/wechatPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type Migrate struct{}

func AutoMigrate(dbName string) {

	applyment := model.Applyment{
		Db:cmf.ManualDb(dbName),
	}

	applyment.AutoMigrate()
}
