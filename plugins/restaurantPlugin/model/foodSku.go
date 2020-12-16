/**
** @创建时间: 2020/11/13 8:26 下午
** @作者　　: return
** @描述　　: 规格扩展表
 */
package model

import (
	"errors"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
	"strings"
)

type FoodSku struct {
	SkuId            int      `gorm:"primaryKey;type:int(11) AUTO_INCREMENT;not null" json:"sku_id"`
	FoodId           int      `gorm:"type:int(11)" json:"food_id"`
	AttrPost         string   `gorm:"type:varchar(20);comment:对应的多选规格;not null" json:"attr_post"`
	Code             string   `gorm:"type:varchar(20);comment:规格唯一编号;not null" json:"code"`
	Inventory        int      `gorm:"type:int(11);comment:库存" json:"inventory"`
	DefaultInventory int      `gorm:"type:int(11);comment:默认库存" json:"default_inventory"`
	UseMember        int      `gorm:"type:tinyint(3);comment:是否启用菜品会员价;not null" json:"use_member"`
	MemberPrice      float64  `gorm:"type:decimal(9,2);comment:菜品会员价;not null" json:"member_price"`
	OriginalPrice    float64  `gorm:"type:decimal(9,2);comment:菜品原价;not null" json:"original_price"`
	Price            float64  `gorm:"type:decimal(9,2);comment:规格售价;not null" json:"price"`
	Volume           int      `gorm:"type:int(11);comment:销量" json:"volume"` // 销量
	Db               *gorm.DB `gorm:"-" json:"-"`
}

func (model FoodSku) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&FoodAttrKey{})
	cmf.NewDb().AutoMigrate(&FoodAttrValue{})
	cmf.NewDb().AutoMigrate(&FoodAttrPost{})
}

func (model FoodSku) ListByFoodId(query []string, queryArgs []interface{}) ([]FoodSku, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	query = append(query, "food_id = ?")
	queryArgs = append(queryArgs, model.FoodId)

	queryStr := strings.Join(query, " AND ")
	var foodSku []FoodSku
	result := cmf.NewDb().Where(queryStr, queryArgs...).Find(&foodSku)
	if result.Error != nil {

		return foodSku, result.Error
	}
	return foodSku, nil
}

func (model FoodSku) Show(query []string, queryArgs []interface{}) (FoodSku, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	queryStr := strings.Join(query, " AND ")
	foodSku := FoodSku{}
	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&foodSku)
	if result.Error != nil {
		return foodSku, result.Error
	}
	return foodSku, nil
}

func (model FoodSku) Store() (FoodSku, error) {

	foodSku := FoodSku{}

	query := []string{"food_id = ?", "attr_post = ?"}
	queryArgs := []interface{}{model.FoodId, model.AttrPost}

	foodSku, err := foodSku.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return foodSku, err
	}

	if foodSku.SkuId == 0 {
		result := cmf.NewDb().Create(&model)
		if result.Error != nil {
			return foodSku, result.Error
		}
	} else {
		return foodSku, errors.New("该分类已存在，无需重复添加！")
	}

	return model, nil

}

func (model FoodSku) FirstOrSave() (FoodSku, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	foodSku := FoodSku{}

	query := []string{"food_id = ?", "attr_post = ?"}
	queryArgs := []interface{}{model.FoodId, model.AttrPost}

	foodSku, err := foodSku.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return foodSku, err
	}

	if foodSku.SkuId == 0 {
		result := model.Db.Create(&model)
		if result.Error != nil {
			return foodSku, result.Error
		}
	} else {
		model.SkuId = foodSku.SkuId
		result := model.Db.Save(&model)
		if result.Error != nil {
			return foodSku, result.Error
		}
	}

	return model, nil
}
