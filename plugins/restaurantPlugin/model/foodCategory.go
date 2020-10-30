/**
** @创建时间: 2020/10/30 3:30 下午
** @作者　　: return
** @描述　　: 菜品分类模型
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

type FoodCategory struct {
	Id         int    `json:"id"`
	Name       int    `gorm:"type:varchar(20);comment:菜品分类名称;not null" json:"name"`
	Icon       string `gorm:"type:varchar(20);comment:菜品分类推荐图标" json:"icon"`
	IsRequired int    `gorm:"type:tinyint(3);comment:是否必选品（0=>否，1=>是）;not null;default:0" json:"is_required"`
	Type       int    `gorm:"type:tinyint(3);comment:场景类型（0=>全部，1=>堂食，2=>外卖）;not null;default:0" json:"type"`
	CreateAt   int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt   int64  `gorm:"type:int(11)" json:"update_at"`
	DeleteAt   int64  `gorm:"type:int(10);comment:'删除时间';default:0" json:"delete_at"`
	Status     int    `gorm:"type:tinyint(3);comment:菜品分类状态;" json:"status"`
}

type FoodCategoryStorePost struct {
	Id             int   `json:"id"`
	FoodCategoryId int   `gorm:"type:bigint(20)" json:"food_category_id"`
	StoreId        int   `gorm:"type:bigint(20)" json:"store_id"`
	CreateAt       int64 `gorm:"type:int(11)" json:"create_at"`
	UpdateAt       int64 `gorm:"type:int(11)" json:"update_at"`
	Status         int   `gorm:"type:tinyint(3);comment:菜品状态;" json:"status"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/10/30 21:08:10
 * @Param
 * @return
 **/
func (model *FoodCategory) AutoMigrate() {
	cmf.Db.AutoMigrate(&model)
	cmf.Db.AutoMigrate(&FoodCategoryStorePost{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 指定数据库迁移
 * @Date 2020/10/30 21:08:10
 * @Param
 * @return
 **/
func (model *FoodCategory) ManualMigrate(db *gorm.DB) {
	db.AutoMigrate(&model)
	db.AutoMigrate(&FoodCategoryStorePost{})
}
