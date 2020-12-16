package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"strings"
)

type User struct {
	Id                int     `json:"id"`
	UserType          int     `gorm:"type:tinyint(3);not null" json:"user_type"`
	Gender            int     `gorm:"type:tinyint(2);comment:性别;0:保密,1:男,2:女" json:"gender"`
	Birthday          int64   `gorm:"type:int(11)" json:"birthday"`
	LastLoginAt       int64   `gorm:"type:int(11)" json:"last_login_at"`
	Score             int     `gorm:"type:bigint(20);comment:积分;default:0;not null" json:"score"`
	Coin              int     `gorm:"type:bigint(20);comment:金币;default:0;not null" json:"coin"`
	Exp               int     `gorm:"type:bigint(20);comment:经验;default:0;not null" json:"exp"`
	Balance           float64 `gorm:"type:decimal(10,2);comment:余额;not null" json:"balance"`
	CreateAt          int64   `gorm:"type:int(11)" json:"create_at"`
	UpdateAt          int64   `gorm:"type:int(11)" json:"update_at"`
	UserStatus        int     `gorm:"type:tinyint(3);not null" json:"user_status"`
	UserLogin         string  `gorm:"type:varchar(60);not null" json:"user_login"`
	UserPass          string  `gorm:"type:varchar(64);not null" json:"-"`
	UserNickname      string  `gorm:"type:varchar(50);not null" json:"user_nickname"`
	UserRealName      string  `gorm:"type:varchar(50);not null" json:"user_realname"`
	UserEmail         string  `gorm:"type:varchar(100);not null" json:"user_email"`
	UserUrl           string  `gorm:"type:varchar(100);not null" json:"user_url"`
	Avatar            string  `json:"avatar"`
	Signature         string  `json:"signature"`
	LastLoginIp       string  `json:"last_loginip"`
	UserActivationKey string  `json:"user_activation_key"`
	Mobile            string  `gorm:"type:varchar(20);not null" json:"mobile"`
	More              string  `gorm:"type:text" json:"more"`
}

type ThirdPart struct {
	Id     int    `json:"id"`
	Type   string `gorm:"type:varchar(10);not null" json:"type"`
	UserId int    `gorm:"type:int(11);not null" json:"user_id"`
	OpenId string `gorm:"type:varchar(20);not null" json:"open_id"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 显示用户信息
 * @Date 2020/12/6 19:3:25
 * @Param
 * @return
 **/
func (model *User) Show(query []string, queryArgs []interface{}) (User, error) {
	user := User{}

	queryStr := strings.Join(query, " AND ")

	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&user)
	if result.Error != nil {
		return user, result.Error
	}

	return user, nil
}

type UserPart struct {
	User
	Type   string `json:"type"`
	OpenId string `json:"open_id"`
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
func (model *UserPart) Show(query []string, queryArgs []interface{}) (*UserPart, error) {

	up := UserPart{}

	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix

	result := cmf.NewDb().Table(prefix+"third_part tp").Select("tp.type,tp.open_id,u.*").
		Joins("LEFT JOIN "+prefix+"user u ON tp.user_id = u.id").
		Where(queryStr, queryArgs...).Order("tp.id desc").Scan(&up)
	if result.Error != nil {
		return nil, result.Error
	}

	return &up, nil
}
