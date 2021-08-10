/**
** @创建时间: 2020/12/17 11:03 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
	"strconv"
	"strings"
)

// 获取当前租户信息
func CurrentTenant(c *gin.Context) (Tenant, error) {
	t := Tenant{}
	session := sessions.Default(c)
	tenant := session.Get("tenant")
	tenantId, _ := c.Get("tenant_id")

	if tenant == nil {
		tx := cmf.Db().Where("tenant_id = ? AND user_status = 1", tenantId).First(&t)
		if tx.RowsAffected == 0 {
			return Tenant{}, errors.New("该用户不存在！")
		}
		jsonBytes, _ := json.Marshal(t)
		session.Set("tenant", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := tenant.(string)
		json.Unmarshal([]byte(jsonBytes), &t)
		if t.Id == 0 {
			tx := cmf.Db().Where("tenant_id = ? AND user_status = 1", tenantId).First(&t)
			if tx.RowsAffected == 0 {
				return Tenant{}, errors.New("该用户不存在！")
			}
			jsonBytes, _ := json.Marshal(t)
			session.Set("tenant", string(jsonBytes))
			session.Save()
			return t, nil
		}
	}
	return t, nil
}

// 获取系统配置项
func Options(db *gorm.DB, key string, mid int) (string, error) {
	option := model.Option{}
	var optionJson string
	uploadResult := db.First(&option, "option_name = ? AND  mid = ?", key, mid) // 查询
	if uploadResult.RowsAffected > 0 {
		optionJson = option.OptionValue
	}
	return optionJson, nil
}

func GetAuthAccess(c *gin.Context) ([]AuthAccessRule, error) {

	adminUser, err := new(AdminUser).CurrentUser(c)

	if err != nil {
		return []AuthAccessRule{}, err
	}

	mid, _ := c.Get("mid")

	var query []string
	var queryArgs []interface{}

	query = append(query, "access.mid = ?")
	queryArgs = append(queryArgs, mid)

	if SuperRole(c, adminUser.Id) {
		return []AuthAccessRule{}, nil
	}

	// 获取当前用户全部的权限列表
	role, _ := GetRoleById(c, adminUser.Id, mid.(int))
	var roleIds []string
	for _, v := range role {
		roleIds = append(roleIds, strconv.Itoa(v.Id))
	}

	roleIdsStr := strings.Join(roleIds, ",")

	if roleIdsStr != "" {
		query = append(query, "role_id in (?)")
		queryArgs = append(queryArgs, roleIdsStr)
	}

	db, err := util.NewDb(c)
	if err != nil {
		return []AuthAccessRule{}, err
	}

	queryStr := strings.Join(query, " AND ")

	var authAccessRule []AuthAccessRule
	prefix := cmf.Conf().Database.Prefix
	db.Table(prefix+"auth_access access").Select("access.*,r.name").
		Joins("INNER JOIN "+prefix+"auth_rule r ON access.rule_name = r.name").
		Where(queryStr, queryArgs...).
		Scan(&authAccessRule)

	return authAccessRule, nil
}

type role struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

// 获取当前用户角色
func CurrentRole(c *gin.Context) ([]role, error) {

	userId, _ := c.Get("user_id")
	mid, exist := c.Get("mid")
	midInt := 0
	if exist {
		midInt = mid.(int)
	}

	userIdInt, _ := strconv.Atoi(userId.(string))
	role, err := GetRoleById(c, userIdInt, midInt)

	return role, err
}

// 根据用户id获取所有角色
func GetRoleById(c *gin.Context, userId int, mid int) ([]role, error) {

	db, err := util.NewDb(c)
	if err != nil {
		return []role{}, err
	}

	var result []role
	prefix := cmf.Conf().Database.Prefix
	tx := db.Table(prefix+"role_user ru").Select("r.id,r.name").
		Joins("INNER JOIN "+prefix+"role r ON ru.role_id = r.id").
		Where("user_id = ? AND mid = ?", userId, mid).
		Scan(&result)

	if tx.Error != nil {
		return []role{}, nil
	}

	return result, nil
}

// 是否超级管理员
func SuperRole(c *gin.Context, uid ...int) bool {

	userId, _ := c.Get("user_id")
	if userId == 1 {
		return true
	}

	temUid := userId
	if len(uid) > 0 {
		temUid = userId
	}

	mid, exist := c.Get("mid")
	midInt := 0
	if exist {
		midInt = mid.(int)
	}

	userIdInt, _ := userId.(int)

	role, err := GetRoleById(c, userIdInt, midInt)

	if err != nil {
		return false
	}

	for _, v := range role {
		if v.Id == temUid {
			return true
		}
	}

	return false
}
