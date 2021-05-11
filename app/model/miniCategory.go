/**
** @创建时间: 2021/3/1 12:23 下午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2021/3/1 12:27:24
 * @Param
 * @return
 **/

type MiniCategory struct {
	Id                 int    `json:"id"`
	CategoryName       string `gorm:"type:varchar(20);comment:类目名称;not null" json:"category_name"`
	ParentId           int    `gorm:"type:bigint(20);comment:支付宝类目上级父类id;default:0;not null" json:"parent_id"`
	AlipayCategoryId   string `gorm:"type:varchar(20);not null" json:"alipay_category_id"`
	AlipayCategoryName string `gorm:"type:varchar(20);comment:支付宝类目名称;not null" json:"alipay_category_name"`
	AlipayParentId     string `gorm:"type:varchar(20);comment:支付宝类目上级父类id;default:0;not null" json:"alipay_parent_id"`
	WechatCategoryId   int    `gorm:"type:bigint(20);not null" json:"wechat_category_id"`
	WechatCategoryName string `gorm:"type:varchar(20);comment:支付宝类目名称;not null" json:"wechat_category_name"`
	WechatParentId     int    `gorm:"type:bigint(20);comment:支付宝类目上级父类id;default:0;not null" json:"wechat_parent_id"`
}

func (model *MiniCategory) AutoMigrate() {
	cmf.Db().AutoMigrate(&MiniCategory{})
}

func (model *MiniCategory) AllCategory() []categoryResult {
	// 第一步查询出全部的省市区
	var miniCategory []MiniCategory
	cmf.Db().Find(&miniCategory)
	result := recursionAddCategory(miniCategory, "0")
	return result
}

func (model *MiniCategory) GetChildrenById(CategoryId string) []MiniCategory {
	var miniCategory []MiniCategory
	cmf.Db().Where("parent_id = ?", CategoryId).Find(&miniCategory)
	return miniCategory
}

func (model *MiniCategory) GetChildrenByTopId(CategoryId string) []MiniCategory {
	var miniCategory []MiniCategory
	cmf.Db().Where("top_id = ?", CategoryId).Find(&miniCategory)
	return miniCategory
}

// 获取单项
func (model *MiniCategory) GetOneById(CategoryId string) MiniCategory {
	var miniCategory MiniCategory
	cmf.Db().Where("category_id = ?", CategoryId).First(&miniCategory)
	return miniCategory
}

func recursionAddCategory(category []MiniCategory, parentId string) []categoryResult {
	// 遍历当前层级
	var results []categoryResult
	for _, v := range category {

		if parentId == v.AlipayParentId {
			result := categoryResult{
				Value: v.AlipayCategoryId,
				Label: v.AlipayCategoryName,
			}
			result.Children = recursionAddCategory(category, v.AlipayCategoryId)
			results = append(results, result)
		}

	}
	return results
}
