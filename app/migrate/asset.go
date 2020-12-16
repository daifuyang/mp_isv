package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type asset struct {
	Migrate
}

func (_ *asset) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model.Asset{})
}
