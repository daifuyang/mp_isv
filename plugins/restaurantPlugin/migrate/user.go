/**
** @创建时间: 2021/3/14 9:38 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type user struct {
	model.User
	Mid int `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
}

func (migrate *user) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&user{})
	cmf.NewDb().AutoMigrate(&model.ThirdPart{})
}
