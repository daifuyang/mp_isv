/**
** @创建时间: 2020/10/29 4:47 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"gorm.io/gorm"
)

type Demo struct {
	Id   int      `json:"id"`
	Name string   `gorm:"varchar(100)" json:"name"`
	Db   *gorm.DB `gorm:"-" json:"-"`
}

func (model *Demo) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}
