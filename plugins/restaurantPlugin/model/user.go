/**
** @创建时间: 2020/12/13 2:04 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	"strings"
)

type User struct {
	model.User
	VipNum     string `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	VipLevel   string `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	VipName    string `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	StartAt    int64    `gorm:"type:int(11);comment:起始时间;not null" json:"start_at"`
	EndAt      int64    `gorm:"type:int(11);comment:截止时间;not null" json:"end_at"`
	StartTime  string `gorm:"-" json:"start_time"`
	EndTime    string `gorm:"-" json:"end_time"`
	VipCanOpen bool   `gorm:"-" json:"vip_can_open"`
}

func (model *User) Show(query []string, queryArgs []interface{}) (User, error) {

	var user User
	queryStr := strings.Join(query, " AND ")
	prefix := cmf.Conf().Database.Prefix
	tx := cmf.NewDb().Table(prefix+"user u").Select("u.*,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Scan(&user)

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return user, tx.Error
	}

	// 获取会员卡状态
	card := CardTemplate{}
	tx = cmf.NewDb().Where("id = ? AND status = ? AND delete_at = ?", 1, 1, 0).First(&card)
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return user, tx.Error
	}

	if tx.RowsAffected == 0 {
		user.VipCanOpen = false
	} else {
		user.VipCanOpen = true
	}

	return user, nil
}
