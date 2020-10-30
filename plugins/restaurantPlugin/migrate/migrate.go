/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"gorm.io/gorm"
)

type Restaurant struct {
	Db *gorm.DB
}

func (migrate *Restaurant) AutoMigrate () {
	fmt.Println("migrate",migrate.Db)

	food := new(model.Food)
	foodCategory := new(model.FoodCategory)
	store := new(model.Store)

	if migrate.Db != nil {
		food.ManualMigrate(migrate.Db)
		foodCategory.ManualMigrate(migrate.Db)
		store.ManualMigrate(migrate.Db)
		return
	}

	food.AutoMigrate()
	foodCategory.AutoMigrate()
	store.AutoMigrate()
}
