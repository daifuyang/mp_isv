/**
** @创建时间: 2020/12/6 8:10 下午
** @作者　　: return
** @描述　　:
 */
package model

import "gorm.io/gorm"

type Address struct {
	Id           int      `json:"id"`
	Mid          int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	Name         string   `gorm:"type:varchar(40);not null" json:"name"`
	UserId       int      `gorm:"type:bigint(20);comment:所属用户id;not null" json:"user_id"`
	Gender       int      `gorm:"type:tinyint(3);comment:性别;default:0;comment:性别;0:保密,1:男,2:女;not null" json:"gender"`
	Mobile       int      `gorm:"type:varchar(20);comment:手机号;not null" json:"mobile"`
	ProvinceName string   `gorm:"type:varchar(20);comment:省份名称;" json:"province_name"`
	CityName     string   `gorm:"type:varchar(20);comment:市区名称" json:"city_name"`
	DistrictName string   `gorm:"type:varchar(20);comment:县区名称;not null" json:"district_name"`
	Address      string   `gorm:"type:varchar(255);comment:地址;not null" json:"address"`
	Longitude    float64  `gorm:"type:decimal(10,7);comment:经度;not null" json:"longitude"`
	Latitude     float64  `gorm:"type:decimal(10,7);comment:纬度;not null" json:"latitude"`
	Room         string   `gorm:"type:varchar(100);comment:门牌号;not null" json:"room"`
	Default      int      `gorm:"type:tinyint(3);comment:默认;not null" json:"default"`
	Db           *gorm.DB `gorm:"-" json:"-"`
}

func (model *Address) AutoMigrate() {
	model.Db.AutoMigrate(&Address{})
}
