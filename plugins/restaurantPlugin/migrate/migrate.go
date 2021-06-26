/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/restaurantPlugin/model"
)

func AutoMigrate() {

	// 指定数据库
	food := new(model.Food)
	foodCategory := new(model.FoodCategory)
	foodSku := new(model.FoodSku)
	store := new(model.Store)
	desk := new(model.Desk)
	deskCategory := new(model.DeskCategory)

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
