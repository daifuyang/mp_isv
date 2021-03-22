package model

import (
	"encoding/json"
	"errors"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type User struct {
	Id                int     `json:"id"`
	UserType          int     `gorm:"type:tinyint(3);not null;default:0" json:"user_type"`
	Gender            int     `gorm:"type:tinyint(2);comment:性别;0:保密,1:男,2:女;default:0" json:"gender"`
	Birthday          int64   `gorm:"type:int(11)" json:"birthday"`
	BirthdayTime      string  `gorm:"-" json:"birthday_time"`
	LastLoginAt       int64   `gorm:"type:int(11)" json:"last_login_at"`
	Score             int     `gorm:"type:bigint(20);comment:积分;default:0;not null" json:"score"`
	Coin              int     `gorm:"type:bigint(20);comment:金币;default:0;not null" json:"coin"`
	Exp               int     `gorm:"type:bigint(20);comment:经验;default:0;not null" json:"exp"`
	Balance           float64 `gorm:"type:decimal(10,2);comment:余额;not null" json:"balance"`
	CreateAt          int64   `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt          int64   `gorm:"type:bigint(20)" json:"update_at"`
	DeleteAt          int64   `gorm:"type:bigint(20)" json:"delete_at"`
	UserStatus        int     `gorm:"type:tinyint(3);not null;default:1" json:"user_status"`
	UserLogin         string  `gorm:"type:varchar(60)" json:"user_login"`
	UserPass          string  `gorm:"type:varchar(64)" json:"-"`
	UserNickname      string  `gorm:"type:varchar(50)" json:"user_nickname"`
	UserRealName      string  `gorm:"type:varchar(50)" json:"user_realname"`
	UserEmail         string  `gorm:"type:varchar(100)" json:"user_email"`
	UserUrl           string  `gorm:"type:varchar(100)" json:"user_url"`
	Avatar            string  `json:"avatar"`
	Signature         string  `json:"signature"`
	LastLoginIp       string  `json:"last_loginip"`
	UserActivationKey string  `json:"user_activation_key"`
	Mobile            string  `gorm:"type:varchar(20);not null" json:"mobile"`
	More              string  `gorm:"type:text" json:"more"`
	paginate          cmfModel.Paginate
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

func (model *User) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var user []User
	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	cmf.NewDb().Where(queryStr, queryArgs...).Find(&user).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&user)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, errors.New("该页码内容不存在！")
	}

	type temResult struct {
		User
		LastLoginTime string `json:"last_login_time"`
		CreateTime    string `json:"create_time"`
	}
	var tempResult []temResult
	for _, v := range user {
		var (
			lastLoginTime string
			createTime    string
		)
		if v.LastLoginAt == 0 {
			lastLoginTime = "0"
		} else {
			lastLoginTime = time.Unix(v.LastLoginAt, 0).Format("2006-01-02 15:04:05")
		}
		if v.CreateAt == 0 {
			createTime = "0"
		} else {
			createTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		}
		tempResult = append(tempResult, temResult{User: v, LastLoginTime: lastLoginTime, CreateTime: createTime})
	}

	paginationData := cmfModel.Paginate{Data: tempResult, Current: current, PageSize: pageSize, Total: total}
	if len(tempResult) == 0 {
		paginationData.Data = make([]string, 0)
	}

	return paginationData, nil

}

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
	Type   string `gorm:"->" json:"type"`
	OpenId string `gorm:"->" json:"open_id"`
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
func (model UserPart) Show(query []string, queryArgs []interface{}) (*UserPart, error) {

	up := UserPart{}

	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix

	result := cmf.NewDb().Debug().Table(prefix+"third_part tp").Select("u.*,tp.type,tp.open_id").
		Joins("LEFT JOIN "+prefix+"user u ON tp.user_id = u.id").
		Where(queryStr, queryArgs...).Order("tp.id desc").Scan(&up)
	if result.Error != nil {
		return nil, result.Error
	}

	return &up, nil
}

//获取后台当前用户信息
func (model *User) CurrentUser(c *gin.Context) User {
	u := User{}
	session := sessions.Default(c)
	user := session.Get("user")
	userId, _ := c.Get("user_id")
	userIdInt, _ := userId.(int)

	if user == nil {
		cmf.NewDb().First(&u, "id = ? AND user_type = 1 AND user_status = 1 AND  delete_at = 0", userId)
		jsonBytes, _ := json.Marshal(u)
		session.Set("user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = User{}
			cmf.NewDb().First(&u, "id = ? AND user_type = 1 AND user_status = 1 AND  delete_at = 0", userId)
			jsonBytes, _ := json.Marshal(u)
			session.Set("user", string(jsonBytes))
			session.Save()
			return u
		}
	}
	return u
}
