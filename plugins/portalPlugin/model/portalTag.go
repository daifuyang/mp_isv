/**
** @创建时间: 2020/12/25 2:08 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
	"strings"
)

// 标签内容
type PortalTag struct {
	Id          int    `json:"id"`
	Status      int    `gorm:"type:tinyint(3);comment:状态,1:发布,0:不发布;default:1;not null;" json:"status"`
	Recommended int    `gorm:"type:tinyint(3);comment:是否推荐,1:推荐;0:不推荐;default:0;not null;" json:"recommended"`
	PostCount   int64  `gorm:"type:bigint(20);comment:标签文章数;default:0;not null;" json:"post_count"`
	Name        string `gorm:"type:varchar(20);comment:标签名称;not null;" json:"name"`
}

func (model *PortalTag) Error() string {
	panic("implement me")
}

// 标签关系
type PortalTagPost struct {
	Id     int `json:"id"`
	TagId  int `gorm:"type:bigint(20);comment:标签id;not null;" json:"tag_id"`
	PostId int `gorm:"type:bigint(20);comment:文章id;not null;" json:"post_id"`
	Status int `gorm:"type:tinyint(3);comment:状态,1:发布,0:不发布;default:1;not null;" json:"status"`
}

func (model *PortalTag) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&PortalTagPost{})
}

func (model *PortalTag) Show(query []string, queryArgs []interface{}) (PortalTag, error) {
	tag := PortalTag{}
	queryStr := strings.Join(query, " AND ")
	result := cmf.NewDb().Where(queryStr, queryArgs...).Find(&tag)

	if result.Error != nil {
		return tag, nil
	}

	return tag, nil
}

func (model PortalTag) Save(postId int) error {

	var count int64
	cmf.NewDb().Model(&PortalTagPost{}).Where("post_id = ?", postId).Count(&count)

	cmf.NewDb().Where("id = ?",model.Id).First(&model)

	model.PostCount = count
	tx := cmf.NewDb().Save(&model)

	if tx.Error != nil {
		return tx.Error
	}

	return nil
}

func (model PortalTag) FirstOrSave() (PortalTag, error) {
	// 新建

	var tx *gorm.DB

	if model.Id == 0 {
		tx = cmf.NewDb().Create(&model)
	} else {
		// 更新
		// 统计文章标签数
		var count int64
		cmf.NewDb().Model(&PortalTagPost{}).Where("tag_id = ?", model.Id).Count(&count)

		model.PostCount = count

		tx = cmf.NewDb().Where("id = ?", model.Id).Save(model)
	}

	if tx.Error != nil {
		return PortalTag{}, tx.Error
	}

	return model, nil

}

func (model *PortalTagPost) FirstOrSave(kId []int) error {

	// [0,1,2]  [1,3,4]

	postId := model.PostId

	// 查出原来的
	var tagPost []PortalTagPost
	cmf.NewDb().Where("post_id = ?", postId).Find(&tagPost)

	// 待添加的
	var toAdd []PortalTagPost

	for _, v := range kId {
		if !new(PortalTagPost).inAddArray(v,tagPost) || len(tagPost) == 0 {
			toAdd = append(toAdd,PortalTagPost{
				TagId: v,
				PostId: postId,
			})
		}
	}

	//待删除的
	var toDel []string
	var toDelArgs []interface{}

	for _, v := range tagPost {
		if !new(PortalTagPost).inDelArray(v.Id, kId) {
			toDel = append(toDel,"id = ?")
			toDelArgs = append(toDelArgs,v.Id)
		}

		if len(kId) == 0 {
			toDel = append(toDel,"id = ?")
			toDelArgs = append(toDelArgs,v.Id)
		}
	}

	// 删除要删除的
	if len(toDel) > 0 {
		delStr := strings.Join(toDel," OR ")
		cmf.NewDb().Where(delStr,toDelArgs...).Delete(&PortalTagPost{})
	}

	if len(toAdd) > 0 {
		// 增加待增加的
		cmf.NewDb().Create(toAdd)
	}

	// 统计当前标签文章数

	for _, v := range kId {
		err := PortalTag{Id: v}.Save(postId)
		if err != nil {
			return err
		}

	}
	return nil
}

func (model *PortalTagPost) inDelArray(s int, kId []int) bool {

	for _, v := range kId {
		if s == v {
			return true
		}
	}
	return false

}

func (model *PortalTagPost) inAddArray(s int, tagPost []PortalTagPost) bool {

	for _, v := range tagPost {
		if s == v.Id {
			return true
		}
	}
	return false

}
