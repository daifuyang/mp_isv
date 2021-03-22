package migrate

import (
	"gincmf/app/model"
	"os"
)

type Migrate interface {
	AutoMigrate()
}

func AutoMigrate() {
	_, err := os.Stat("./data/install.lock")
	if err != nil {
		StartMigrate()
	}

	// 改为已安装
	file, _ := os.Create("./data/install.lock")
	file.Close()
}

func StartMigrate() {

	new(user).AutoMigrate()
	new(option).AutoMigrate()
	new(mpIsvAuth).AutoMigrate()
	new(tenant).AutoMigrate()
	new(AdminMenu).AutoMigrate()
	new(Region).AutoMigrate()
	new(shopCategory).AutoMigrate()
	new(model.MiniCategory).AutoMigrate()
	new(model.Qrcode).AutoMigrate()

	new(role).AutoMigrate()
	new(authAccess).AutoMigrate()
	new(authRule).AutoMigrate()
	new(PayLog).AutoMigrate()
	new(model.AdminNotice).AutoMigrate()
	new(model.ScoreLog).AutoMigrate()
	new(model.ExpLog).AutoMigrate()
	new(model.RechargeLog).AutoMigrate()

	model.AutoAdminMenu()

}
