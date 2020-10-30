/**
** @创建时间: 2020/10/30 9:08 下午
** @作者　　: return
** @描述　　: 门店数据库模型
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

type Store struct {
	Id             int     `json:"id"`
	StoreNumber    string  `gorm:"type:varchar(32);comment:门店唯一编号;not null" json:"food_number"`
	StoreName      string  `gorm:"type:varchar(32);comment:门店名称;not null" json:"store_name"`
	Phone          string  `gorm:"type:varchar(20);comment:联系电话;not null" json:"phone"`
	ContactPerson  string  `gorm:"type:varchar(20);comment:联系人名称;not null" json:"contact_person"`
	Province       int     `gorm:"type:int(11);comment:省份id;not null" json:"province"`
	ProvinceName   string  `gorm:"type:varchar(20);comment:省份名称;not null" json:"province_name"`
	City           int     `gorm:"type:int(11);comment:市区id;not null" json:"city"`
	CityName       string  `gorm:"type:varchar(20);comment:市区名称;not null" json:"city_name"`
	District       int     `gorm:"type:int(11);comment:县区id;not null" json:"district"`
	DistrictName   string  `gorm:"type:varchar(20);comment:县区名称;not null" json:"district_name"`
	Address        string  `gorm:"type:varchar(255);comment:详细地址;not null" json:"address"`
	StoreThumbnail string  `gorm:"type:varchar(255);comment:门头照片" json:"store_thumbnail"`
	Longitude      float64 `gorm:"type:decimal(10,7);comment:'经度';not null" json:"longitude"`
	Latitude       float64 `gorm:"type:decimal(10,7);comment:'纬度';not null" json:"latitude"`
	IsClosure      int     `gorm:"type:tinyint(3);comment:'是否歇业';not null;default:0" json:"is_closure"`
	Notice         string  `gorm:"type:varchar(255);comment:'公告通知'" json:"notice"`
	Status         int     `gorm:"type:tinyint(3);comment:菜品状态;" json:"status"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/10/30 21:08:10
 * @Param
 * @return
 **/
func (model *Store) AutoMigrate() {
	cmf.Db.AutoMigrate(&model)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 指定数据库迁移
 * @Date 2020/10/30 21:08:10
 * @Param
 * @return
 **/
func (model *Store) ManualMigrate(db *gorm.DB) {
	db.AutoMigrate(&model)
}
