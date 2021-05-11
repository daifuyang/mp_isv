/**
** @创建时间: 2021/4/4 10:33 上午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

// 门店类目
type TakeoutCategory struct {
	CategoryId   string `gorm:"primaryKey;type:varchar(20);not null" json:"category_id"`
	CategoryName string `gorm:"type:varchar(20);comment:类目名称;not null" json:"category_name"`
	CategoryType int    `gorm:"type:tinyint(3);comment:类目类型;not null" json:"category_type"`
	ParentId     string `gorm:"type:varchar(20);comment:类目上级父类id;default:0;not null" json:"parent_id"`
}

type foodResult struct {
	Value    string       `json:"value"`
	Label    string       `json:"label"`
	Children []foodResult `json:"children,omitempty"`
}

func (model *TakeoutCategory) FoodCategory() []foodResult {
	// 第一步查询出全部的省市区
	var foodCategory []TakeoutCategory
	cmf.Db().Find(&foodCategory)
	result := recursionAddFoodCategory(foodCategory, "0")
	return result
}

func (model *TakeoutCategory) GetChildrenById(CategoryId string) []TakeoutCategory {
	var fc []TakeoutCategory
	cmf.Db().Where("parent_id = ?", CategoryId).Find(&fc)
	return fc
}

// 获取单项
func (model *TakeoutCategory) GetOneById(CategoryId string) TakeoutCategory {
	var fc TakeoutCategory
	cmf.Db().Where("category_id = ?", CategoryId).First(&fc)
	return fc
}

func recursionAddFoodCategory(foodCategory []TakeoutCategory, parentId string) []foodResult {
	// 遍历当前层级
	var results []foodResult
	for _, v := range foodCategory {

		if parentId == v.ParentId {
			result := foodResult{
				Value: v.CategoryName,
				Label: v.CategoryName,
			}
			result.Children = recursionAddFoodCategory(foodCategory, v.CategoryId)
			results = append(results, result)
		}

	}
	return results
}
