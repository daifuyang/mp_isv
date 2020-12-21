/**
** @创建时间: 2020/12/13 2:04 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"strings"
)

type User struct {
	model.User
	VipNum     string            `gorm:"type:varchar(32);comment:会员号;not null" json:"vip_num"`
	VipLevel   string            `gorm:"type:varchar(10);comment:会员等级;not null" json:"vip_level"`
	VipName    string            `gorm:"type:varchar(40);comment:会员名称;not null" json:"vip_name"`
	StartAt    int64             `gorm:"type:int(11);comment:起始时间;not null" json:"start_at"`
	EndAt      int64             `gorm:"type:int(11);comment:截止时间;not null" json:"end_at"`
	StartTime  string            `gorm:"-" json:"start_time"`
	EndTime    string            `gorm:"-" json:"end_time"`
	VipCanOpen bool              `gorm:"-" json:"vip_can_open"`
	Type       string            `gorm:"type:varchar(10);not null" json:"type"`
	UserId     int               `gorm:"type:int(11);not null" json:"user_id"`
	OpenId     string            `gorm:"type:varchar(20);not null" json:"open_id"`
	paginate   cmfModel.Paginate `gorm:"-"`
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

func (model *User) ThirdPartIndex(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	var user []User

	cmf.NewDb().Table(prefix+"third_part tp").Select("u.*,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at,tp.type,tp.open_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = tp.user_id").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Group("u.id").
		Count(&total)

	tx := cmf.NewDb().Table(prefix+"third_part tp").Select("u.*,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at,tp.type,tp.open_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = tp.user_id").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Group("u.id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Scan(&user)

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: user, Current: current, PageSize: pageSize, Total: total}
	if len(user) == 0 {
		paginate.Data = make([]User, 0)
	}

	return paginate, nil

}
