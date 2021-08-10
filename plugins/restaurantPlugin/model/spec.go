/**
** @创建时间: 2020/11/16 2:37 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

// 属性键表
type FoodAttrKey struct {
	AttrId int    `gorm:"primaryKey;type:int(11) AUTO_INCREMENT;not null" json:"attr_id"` // 属性键唯一id
	Name   string `gorm:"type:varchar(40);comment:属性名称;not null" json:"name"`             // 属性名称
}

// 属性值表
type FoodAttrValue struct {
	AttrValueId int      `gorm:"primaryKey;type:int(11) AUTO_INCREMENT;not null" json:"attr_value_id"` // 属性值唯一id
	AttrId      int      `gorm:"type:int(11)" json:"attr_id"`                                          // 属性键对应id
	AttrValue   string   `gorm:"type:varchar(40);comment:属性名称;not null" json:"attr_value"`             // 属性值
	Db          *gorm.DB `gorm:"-" json:"-"`
}

// 属性关系表
type FoodAttrPost struct {
	AttrPostId  int      `gorm:"primaryKey;type:int(11) AUTO_INCREMENT;not null" json:"attr_post_id"` // 属性规格唯一id
	FoodId      int      `gorm:"type:int(11)" json:"food_id"`
	AttrValueId int      `gorm:"type:int(11)" json:"attr_value_id"` // 对应属性值id
	Db          *gorm.DB `gorm:"-" json:"-"`
}

type tempAttrPost struct {
	AttrPostId  int    `json:"attr_post_id"`
	FoodId      int    `json:"food_id"`
	AttrId      int    `json:"attr_id"`       // 属性键唯一id
	Name        string `json:"name"`          // 属性名称
	AttrValueId int    `json:"attr_value_id"` // 属性值唯一id
	AttrValue   string `json:"attr_value"`    // 属性值

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取规格详情
 * @Date 2020/11/18 12:20:17
 * @Param
 * @return
 **/
func (model FoodAttrPost) attrPost() ([]tempAttrPost, error) {

	db := model.Db

	var tempAttr []tempAttrPost
	prefix := cmf.Conf().Database.Prefix
	result := db.Select("ap.food_id,ap.attr_post_id,v.attr_value_id,v.attr_value,k.attr_id,k.name").Table(prefix+"food_attr_post ap").
		Joins("INNER JOIN "+prefix+"food_attr_value v ON ap.attr_value_id = v.attr_value_id").
		Joins("INNER JOIN "+prefix+"food_attr_key k ON k.attr_id = v.attr_id").
		Where("ap.food_id = ?", model.FoodId).Order("ap.attr_post_id asc").Scan(&tempAttr)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return tempAttr, result.Error
	}

	return tempAttr, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 增加键属性
 * @Date 2020/11/16 16:09:57
 * @Param
 * @return
 **/
func (model FoodAttrValue) AddAttrValue() (FoodAttrValue, error) {

	attrId := model.AttrId
	attrVal := model.AttrValue
	result := model.Db.Where("attr_id = ? AND attr_value = ?", attrId, attrVal).First(&model)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return model, result.Error
	}

	if errors.Is(result.Error, gorm.ErrRecordNotFound) {
		result := model.Db.Create(&model)
		if result.Error != nil {
			return model, result.Error
		}
	}

	return model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 增加键和商品关联信息
 * @Date 2020/11/16 17:03:33
 * @Param
 * @return
 **/
func (model FoodAttrPost) AddAttrPost() (FoodAttrPost, error) {

	result := model.Db.Where("food_id =? AND attr_value_id=?", model.FoodId, model.AttrValueId).First(&model)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return model, result.Error
	}

	if errors.Is(result.Error, gorm.ErrRecordNotFound) {
		result := model.Db.Create(&model)
		if result.Error != nil {
			return model, result.Error
		}
	}

	return model, nil
}
