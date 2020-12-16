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
	StartTenantMigrate()
	new(option).AutoMigrate()
	new(mpIsvAuth).AutoMigrate()
	new(tenant).AutoMigrate()
	new(AdminMenu).AutoMigrate()
	new(Region).AutoMigrate()
}

// 租户表迁移
func StartTenantMigrate() {
	new(user).AutoTenantMigrate()
	new(asset).AutoMigrate()
	new(role).AutoMigrate()
	new(authAccess).AutoMigrate()
	new(authRule).AutoMigrate()
	new(model.PayLog).AutoMigrate()
}
