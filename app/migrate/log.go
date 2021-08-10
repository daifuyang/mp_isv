package migrate

import (
	"gincmf/app/model"
	"gorm.io/gorm"
)

type log struct {
	Migrate
	Db *gorm.DB
}

func (migrate *log) AutoMigrate() {
	migrate.Db.AutoMigrate(&model.Log{})
}
