/**
** @创建时间: 2021/3/21 11:52 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/util"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

// 管理员账号
type AdminUser struct {
	Id           int      `json:"id"`
	Gender       int      `gorm:"type:tinyint(2);comment:性别;0:保密,1:男,2:女;default:0" json:"gender"`
	LastLoginAt  int64    `gorm:"type:int(11)" json:"last_login_at"`
	CreateAt     int64    `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt     int64    `gorm:"type:bigint(20)" json:"update_at"`
	DeleteAt     int64    `gorm:"type:bigint(20)" json:"delete_at"`
	UserStatus   int      `gorm:"type:tinyint(3);not null;default:1" json:"user_status"`
	UserLogin    string   `gorm:"type:varchar(60)" json:"user_login"`
	UserPass     string   `gorm:"type:varchar(64)" json:"-"`
	UserNickname string   `gorm:"type:varchar(50)" json:"user_nickname"`
	UserRealName string   `gorm:"type:varchar(50)" json:"user_realname"`
	UserEmail    string   `gorm:"type:varchar(100)" json:"user_email"`
	Avatar       string   `gorm:"type:varchar(255)" json:"avatar"`
	LastLoginIp  string   `gorm:"type:varchar(100)" json:"last_loginip"`
	Mobile       string   `gorm:"type:varchar(20);not null" json:"mobile"`
	More         string   `gorm:"type:text" json:"more"`
}

// 自动迁移
func (model *AdminUser) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}

func (model *AdminUser) Init() {
	user := AdminUser{
		Id:           1,
		UserStatus:   1,
		UserLogin:    model.Mobile,
		UserNickname: model.Mobile,
		Mobile:       model.Mobile,
		UserPass:     model.UserPass,
		CreateAt:     time.Now().Unix(),
	}
	model.Db.FirstOrCreate(&user)
}

func (model *AdminUser) CurrentUser(c *gin.Context) (AdminUser, error) {
	u := AdminUser{}
	session := sessions.Default(c)
	user := session.Get("user")
	userId, _ := c.Get("user_id")
	userIdInt, _ := userId.(int)

	fmt.Println("user", user)
	fmt.Println("userId", userId)

	db, err := util.NewDb(c)
	if err != nil {
		return u, err
	}

	if user == nil {
		db.Debug().First(&u, "id = ? AND user_status = 1 AND delete_at = 0", userId)
		jsonBytes, _ := json.Marshal(u)
		session.Set("user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = AdminUser{}
			db.First(&u, "id = ? AND user_type = 1 AND user_status = 1 AND  delete_at = 0", userId)
			jsonBytes, _ := json.Marshal(u)
			session.Set("user", string(jsonBytes))
			session.Save()
			return u, nil
		}
	}
	return u, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 显示用户信息
 * @Date 2020/12/6 19:3:25
 * @Param
 * @return
 **/

func (model *AdminUser) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	db := model.Db
	
	var adminUser []AdminUser
	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	db.Debug().Table(prefix+"admin_user as au").
		Joins("INNER JOIN "+prefix+"mp_theme_admin_user_post p ON au.id = p.admin_user_id").
		Where(query, queryArgs...).Find(&adminUser).Count(&total)

	tx := db.Debug().Table(prefix+"admin_user as au").
		Joins("INNER JOIN "+prefix+"mp_theme_admin_user_post p ON au.id = p.admin_user_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&adminUser)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, errors.New("该页码内容不存在！")
	}

	type temResult struct {
		AdminUser
		LastLoginTime string `json:"last_login_time"`
		CreateTime    string `json:"create_time"`
	}
	var tempResult []temResult
	for _, v := range adminUser {
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
		tempResult = append(tempResult, temResult{AdminUser: v, LastLoginTime: lastLoginTime, CreateTime: createTime})
	}

	paginationData := cmfModel.Paginate{Data: tempResult, Current: current, PageSize: pageSize, Total: total}
	if len(tempResult) == 0 {
		paginationData.Data = make([]string, 0)
	}

	return paginationData, nil

}

func (model *AdminUser) Show(query []string, queryArgs []interface{}) (AdminUser, error) {

	db := model.Db

	adminUser := AdminUser{}

	queryStr := strings.Join(query, " AND ")

	result := db.Where(queryStr, queryArgs...).First(&adminUser)
	if result.Error != nil {
		return adminUser, result.Error
	}

	return adminUser, nil
}

type UserPart struct {
	AdminUser
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
