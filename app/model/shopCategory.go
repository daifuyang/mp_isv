/**
** @创建时间: 2020/12/20 12:58 下午
** @作者　　: return
** @描述　　: 门店类目模型
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

// 门店类目
type ShopCategory struct {
	CategoryId   string `gorm:"primaryKey;type:varchar(20);not null" json:"category_id"`
	CategoryName string `gorm:"type:varchar(20);comment:类目名称;not null" json:"category_name"`
	CategoryType int    `gorm:"type:tinyint(3);comment:类目类型;not null" json:"category_type"`
	ParentId     string `gorm:"type:varchar(20);comment:类目上级父类id;default:0;not null" json:"parent_id"`
	TopId        string `gorm:"type:varchar(20);comment:类目顶级父类id;default:0;not null" json:"top_id"`
}

type shopCategoryResult struct {
	Value    string               `json:"value"`
	Label    string               `json:"label"`
	Children []shopCategoryResult `json:"children"`
}

func (model *ShopCategory) ShopCategory() []shopCategoryResult {
	// 第一步查询出全部的省市区
	var ShopCategory []ShopCategory
	cmf.Db().Find(&ShopCategory)
	result := recursionAddShopCategory(ShopCategory, "0")
	return result
}

func (model *ShopCategory) GetChildrenById(CategoryId string) []ShopCategory {
	var ShopCategory []ShopCategory
	cmf.Db().Where("parent_id = ?", CategoryId).Find(&ShopCategory)
	return ShopCategory
}

func (model *ShopCategory) GetChildrenByTopId(CategoryId string) []ShopCategory {
	var ShopCategory []ShopCategory
	cmf.Db().Where("top_id = ?", CategoryId).Find(&ShopCategory)
	return ShopCategory
}

// 获取单项
func (model *ShopCategory) GetOneById(CategoryId string) ShopCategory {
	var ShopCategory ShopCategory
	cmf.Db().Where("category_id = ?", CategoryId).First(&ShopCategory)
	return ShopCategory
}

func recursionAddShopCategory(ShopCategory []ShopCategory, parentId string) []shopCategoryResult {
	// 遍历当前层级
	var results []shopCategoryResult
	for _, v := range ShopCategory {

		if parentId == v.ParentId {
			result := shopCategoryResult{
				Value: v.CategoryId,
				Label: v.CategoryName,
			}
			result.Children = recursionAddShopCategory(ShopCategory, v.CategoryId)
			results = append(results, result)
		}

	}
	return results
}
