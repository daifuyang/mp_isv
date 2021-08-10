/**
** @创建时间: 2020/12/13 2:04 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/model"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type User struct {
	model.User
	Mid          int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	BirthdayTime string  `gorm:"-" json:"birthday_time,omitempty"`
	VipNum       string  `gorm:"->" json:"vip_num,omitempty"`
	VipLevel     string  `gorm:"->" json:"vip_level,omitempty"`
	VipName      string  `gorm:"->" json:"vip_name,omitempty"`
	StartAt      int64   `gorm:"->" json:"start_at,omitempty"`
	EndAt        int64   `gorm:"->" json:"end_at,omitempty"`
	Level        *SLevel `gorm:"-" json:"level,omitempty"`
	ExpRangeEnd  int     `gorm:"-" json:"exp_range_end,omitempty"`
	StartTime    string  `gorm:"-" json:"start_time,omitempty"`
	EndTime      string  `gorm:"-" json:"end_time,omitempty"`
	VipCanOpen   bool    `gorm:"-" json:"vip_can_open"`
	Type         string  `gorm:"->" json:"type"`
	UserId       int     `gorm:"->" json:"user_id"`
	OpenId       string  `gorm:"->" json:"open_id"`
	MemberStatus int     `gorm:"->" json:"member_status"`
	SessionKey   string  `gorm:"->" json:"session_key"`
	paginate     cmfModel.Paginate
	Db           *gorm.DB `gorm:"-" json:"-"`
}

type ThirdPart struct {
	Id         int      `json:"id"`
	Mid        int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	Type       string   `gorm:"type:varchar(10);not null" json:"type"`
	UserId     int      `gorm:"type:int(11);not null" json:"user_id"`
	OpenId     string   `gorm:"type:varchar(128);not null" json:"open_id"`
	SessionKey string   `gorm:"type:varchar(255);not null" json:"session_key"`
	Db         *gorm.DB `gorm:"-" json:"-"`
}

func (model *User) Show(query []string, queryArgs []interface{}) (User, error) {

	db := model.Db

	var user User
	queryStr := strings.Join(query, " AND ")
	prefix := cmf.Conf().Database.Prefix
	tx := db.Table(prefix+"user u").Select("u.*,tp.open_id,tp.session_key,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at,mc.status as member_status").
		Joins("LEFT JOIN "+prefix+"third_part tp ON tp.user_id = u.id").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Scan(&user)

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return user, tx.Error
	}

	if user.StartAt > 0 {
		user.StartTime = time.Unix(user.StartAt, 0).Format("2006-01-02 15:04:05")
	}
	if user.EndAt > 0 {
		user.EndTime = time.Unix(user.EndAt, 0).Format("2006-01-02 15:04:05")
	}

	if user.EndAt == -1 {
		user.EndTime = "永久有效"
	}

	// 获取会员权益
	levelModel := Level{
		Db: db,
	}
	level, err := levelModel.LevelDetail(user.VipLevel, user.Mid)

	if err != nil {
		return user, tx.Error
	}

	if level.LevelId != "" {
		user.Level = &level
	}

	user.ExpRangeEnd = level.ExpRangeEnd

	// 获取会员卡状态
	card := CardTemplate{}
	tx = db.Where("id = ? AND status = ? AND delete_at = ?", 1, 1, 0).First(&card)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
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

	db := model.Db

	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	var user []User

	db.Table(prefix+"third_part tp").Select("u.*,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at,tp.type,tp.open_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = tp.user_id").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Group("u.id").
		Count(&total)

	tx := db.Table(prefix+"third_part tp").Select("u.*,mc.vip_num,mc.vip_level,mc.vip_name,mc.start_at,mc.end_at,mc.create_at,mc.update_at,mc.delete_at,tp.type,tp.open_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = tp.user_id").
		Joins("LEFT JOIN "+prefix+"member_card mc ON u.id = mc.user_id").
		Where(queryStr, queryArgs...).
		Group("u.id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Scan(&user)

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		return cmfModel.Paginate{}, tx.Error
	}

	for k, v := range user {

		if v.Birthday > 0 {
			user[k].BirthdayTime = time.Unix(v.Birthday, 0).Format("2006-01-02")
		}

		if v.StartAt > 0 {
			user[k].StartTime = time.Unix(v.StartAt, 0).Format("2006-01-02")
		}

		if v.EndAt > 0 {
			user[k].EndTime = time.Unix(v.EndAt, 0).Format("2006-01-02")
		}
	}

	paginate := cmfModel.Paginate{Data: user, Current: current, PageSize: pageSize, Total: total}
	if len(user) == 0 {
		paginate.Data = make([]User, 0)
	}

	return paginate, nil

}

func (model *User) GetBalance(userId int) (float64, error) {

	db := model.Db

	u := User{}
	tx := db.Where("id = ?", userId).First(&u)

	if tx.Error != nil {
		return 0, tx.Error
	}

	return u.Balance, nil

}

func (model *User) GetMpUser(id int, typeStr string) (User, error) {
	u := User{}
	u, err := model.Show([]string{"u.id = ? AND user_status = ? AND type = ?"}, []interface{}{id, 1, typeStr})
	if err != nil {
		return u, err
	}

	return u, nil
}

// 获取小程序用户信息
func (model *User) CurrentMpUser(c *gin.Context) User {
	u := User{}
	session := sessions.Default(c)
	user := session.Get("mp_user")
	userId, _ := c.Get("mp_user_id")
	userIdInt, _ := userId.(int)
	mpType, _ := c.Get("mp_type")

	if user == nil {
		u, err := model.Show([]string{"u.id = ? AND user_status = ? AND type = ?"}, []interface{}{userId, 1, mpType})
		if err != nil {
			return u
		}

		jsonBytes, _ := json.Marshal(u)
		session.Set("mp_user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = User{}
			u, err := model.Show([]string{"id = ? AND user_status = ?"}, []interface{}{u.Id, 1})
			if err != nil {
				return u
			}
			jsonBytes, _ := json.Marshal(u)
			session.Set("mp_user", string(jsonBytes))
			session.Save()
			return u
		}
	}
	return u
}

type UserPart struct {
	User
	Mid        int      `json:"mid"`
	Type       string   `json:"type"`
	OpenId     string   `json:"open_id"`
	SessionKey string   `json:"session_key"`
	Db         *gorm.DB `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 前台小程序更新用户数据
 * @Date 2020/12/6 19:4:29
 * @Param
 * @return
 **/

/**
 * @Author return <1140444693@qq.com>
 * @Description 第三方用户信息获取
 * @Date 2020/12/6 19:3:38
 * @Param
 * @return
 **/
func (model UserPart) Show(query []string, queryArgs []interface{}) (UserPart, error) {

	db := model.Db

	up := UserPart{}

	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix

	result := db.Table(prefix+"third_part tp").Select("u.*,tp.type,tp.user_id,tp.open_id,tp.session_key").
		Joins("LEFT JOIN "+prefix+"user u ON tp.user_id = u.id").
		Where(queryStr, queryArgs...).Order("tp.id desc").Scan(&up)

	if result.Error != nil {
		return up, result.Error
	}

	return up, nil
}

func (model *User) CurrentUser(c *gin.Context) User {

	db := model.Db

	u := User{}
	session := sessions.Default(c)
	user := session.Get("user")
	userId, _ := c.Get("user_id")

	userIdInt, _ := userId.(int)

	if user == nil {
		db.First(&u, "id = ? AND user_type = 1 AND user_status = 1 AND  delete_at = 0", userId)
		jsonBytes, _ := json.Marshal(u)
		session.Set("user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = User{}
			db.First(&u, "id = ? AND user_type = 1 AND user_status = 1 AND  delete_at = 0", userId)
			jsonBytes, _ := json.Marshal(u)
			session.Set("user", string(jsonBytes))
			session.Save()
			return u
		}
	}
	return u
}
