package migrate

type Migrate interface {
	AutoMigrate()
}

func AutoMigrate() {
	new(AlipayAuth).AutoMigrate()
	new(merchant).AutoMigrate()
}
