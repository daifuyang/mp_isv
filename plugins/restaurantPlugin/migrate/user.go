/**
** @创建时间: 2021/3/14 9:38 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/app/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"gorm.io/gorm"
)

type user struct {
	model.User
	Mid int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	Db  *gorm.DB `gorm:"-" json:"-"`
}

func (migrate *user) AutoMigrate() {
	migrate.Db.AutoMigrate(&user{})
	migrate.Db.AutoMigrate(&resModel.ThirdPart{})
}
