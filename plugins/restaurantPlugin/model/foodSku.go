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
	AttrValue        string   `gorm:"-" json:"attr_value"`
	AttrPost         string   `gorm:"type:varchar(20);comment:对应的多选规格;index:idx_attr_post,unique;not null" json:"attr_post"`
	Code             string   `gorm:"type:varchar(20);comment:规格唯一编号;index:idx_code,unique;not null" json:"code"`
	Inventory        int      `gorm:"type:int(11);comment:库存" json:"inventory"`
	DefaultInventory int      `gorm:"type:int(11);comment:默认库存" json:"default_inventory"`
	UseMember        int      `gorm:"type:tinyint(3);comment:是否启用菜品会员价;not null" json:"use_member"`
	MemberPrice      float64  `gorm:"type:decimal(9,2);comment:菜品会员价;not null" json:"member_price"`
	OriginalPrice    float64  `gorm:"type:decimal(9,2);comment:菜品原价;not null" json:"original_price"`
	Price            float64  `gorm:"type:decimal(9,2);comment:规格售价;not null" json:"price"`
	Volume           int      `gorm:"type:int(11);comment:销量" json:"volume"`        // 销量
	Remark           string   `gorm:"type:varchar(255);comment:规格备注" json:"remark"` // 销量
	Weight           float64  `gorm:"type:float(5);comment:重量（kg）;" json:"weight"`
	Db               *gorm.DB `gorm:"-" json:"-"`
}

func (model FoodSku) AutoMigrate() {

	cmf.NewDb().Migrator().DropIndex(&FoodSku{}, "idx_attr_post")
	cmf.NewDb().Migrator().DropIndex(&FoodSku{}, "idx_code")

	cmf.NewDb().Migrator().CreateIndex(&FoodSku{}, "idx_attr_post")
	cmf.NewDb().Migrator().CreateIndex(&FoodSku{}, "idx_code")

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

type SkuDetail struct {
	FoodSku
	SkuDetail string `json:"sku_detail"`
}

func (model FoodSku) Detail(query []string, queryArgs []interface{}) (SkuDetail, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	queryStr := strings.Join(query, " AND ")

	var sku SkuDetail

	prefix := cmf.Conf().Database.Prefix

	result := cmf.NewDb().Table(prefix+"food_sku sku").Select("sku.*,av.attr_value as sku_detail").
		Joins("INNER JOIN "+prefix+"food_attr_post ap ON sku.attr_post = ap.attr_post_id").
		Joins("INNER JOIN "+prefix+"food_attr_value av ON ap.attr_value_id = av.attr_value_id").
		Where(queryStr, queryArgs...).Scan(&sku)
	if result.Error != nil {
		return sku, result.Error
	}
	return sku, nil
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

	// 查看编码是否为唯一
	tx := model.Db.Where("code = ? && code != ''", model.Code).First(&Food{})
	if tx.RowsAffected > 0 {
		return foodSku, errors.New(model.AttrValue + "规格分类或编码已存在")
	}

	if foodSku.SkuId == 0 {

		tx = model.Db.Where("attr_post = ? || (code = ? && code != '')", model.AttrPost, model.Code).First(&FoodSku{})
		if tx.RowsAffected > 0 {
			return foodSku, errors.New(model.AttrValue + "规格分类或编码已存在")
		}

		result := model.Db.Create(&model)
		if result.Error != nil {
			return foodSku, result.Error
		}
	} else {

		// 查看编码是否为唯一
		tx := model.Db.Where("(attr_post = ? || (code = ? && code != '')) AND  sku_id != ?", model.AttrPost, model.Code, foodSku.SkuId).First(&FoodSku{})
		if tx.RowsAffected > 0 {
			return foodSku, errors.New(model.AttrValue + "规格分类或编码已存在")
		}

		model.SkuId = foodSku.SkuId
		result := model.Db.Save(&model)
		if result.Error != nil {
			return foodSku, result.Error
		}
	}

	return model, nil
}
