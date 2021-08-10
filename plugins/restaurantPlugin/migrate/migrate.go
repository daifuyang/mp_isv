/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func AutoMigrate(dbName string) {

	// 指定数据库
	food := model.Food{
		Db: cmf.ManualDb(dbName),
	}
	foodCategory := model.FoodCategory{
		Db: cmf.ManualDb(dbName),
	}
	foodSku := model.FoodSku{
		Db: cmf.ManualDb(dbName),
	}
	store := model.Store{
		Db: cmf.ManualDb(dbName),
	}
	desk := model.Desk{
		Db: cmf.ManualDb(dbName),
	}
	deskCategory := model.DeskCategory{
		Db: cmf.ManualDb(dbName),
	}

	new(FoodOrder).AutoMigrate()
	foodCategory.AutoMigrate()
	store.AutoMigrate()
	desk.AutoMigrate()
	deskCategory.AutoMigrate()
	food.AutoMigrate()
	foodSku.AutoMigrate()

	new(user).AutoMigrate()
	new(model.Option).AutoMigrate()
	new(model.Voucher).AutoMigrate()
	new(model.CardTemplate).AutoMigrate()
	new(memberCardOrder).AutoMigrate()
	new(RechargeOrder).AutoMigrate()
	new(model.Printer).AutoMigrate()
	// 地址
	new(model.Address).AutoMigrate()

	new(QrcodePost).AutoMigrate()

	new(model.ImmediateDelivery).AutoMigrate()

	new(model.ImmediateDeliveryOrder).AutoMigrate()

}
