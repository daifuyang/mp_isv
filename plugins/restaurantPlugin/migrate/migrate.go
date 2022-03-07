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

	foodOrder := FoodOrder{
		Db: cmf.ManualDb(dbName),
	}

	foodOrder.AutoMigrate()
	foodCategory.AutoMigrate()
	store.AutoMigrate()
	desk.AutoMigrate()
	deskCategory.AutoMigrate()
	food.AutoMigrate()
	foodSku.AutoMigrate()

	u := user{Db: cmf.ManualDb(dbName)}
	u.AutoMigrate()

	option := model.Option{
		Db: cmf.ManualDb(dbName),
	}
	option.AutoMigrate()

	voucher := model.Voucher{
		Db: cmf.ManualDb(dbName),
	}
	voucher.AutoMigrate()

	cardTemplate := model.CardTemplate{
		Db: cmf.ManualDb(dbName),
	}
	cardTemplate.AutoMigrate()

	mco := memberCardOrder{
		Db: cmf.ManualDb(dbName),
	}
	mco.AutoMigrate()

	ro := RechargeOrder{
		Db: cmf.ManualDb(dbName),
	}
	ro.AutoMigrate()

	printer := model.Printer{
		Db: cmf.ManualDb(dbName),
	}
	printer.AutoMigrate()

	address := model.Address{
		Db: cmf.ManualDb(dbName),
	}
	// 地址
	address.AutoMigrate()

	qp := QrcodePost{
		Db: cmf.ManualDb(dbName),
	}
	qp.AutoMigrate()

	immediateDelivery := model.ImmediateDelivery{
		Db: cmf.ManualDb(dbName),
	}
	immediateDelivery.AutoMigrate()

	idp := model.ImmediateDeliveryPost{
		Db:cmf.ManualDb(dbName),
	}
	idp.AutoMigrate()

	ido := model.ImmediateDeliveryOrder{
		Db: cmf.ManualDb(dbName),
	}
	ido.AutoMigrate()

}
