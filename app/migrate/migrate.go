package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
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
	/*new(Region).AutoMigrate()
	new(shopCategory).AutoMigrate()
	new(takeCategory).AutoMigrate()
	new(model.MiniCategory).AutoMigrate()*/
	new(model.Qrcode).AutoMigrate()

	new(role).AutoMigrate()
	new(authAccess).AutoMigrate()
	new(authRule).AutoMigrate()

	//new(model.AdminNotice).AutoMigrate()

	// 主题模板
	new(model.MpTheme).AutoMigrate()
	// new(Bank).AutoMigrate()
	new(model.WxpayCategory).AutoMigrate()

	dbName := cmf.Conf().Database.Name

	model.AutoAdminMenu(dbName)

}
