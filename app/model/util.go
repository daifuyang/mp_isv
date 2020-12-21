/**
** @创建时间: 2020/12/17 11:02 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"gincmf/app/util"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
	"strings"
	"time"
)

func SiteSettings() map[string]interface{} {
	option := Option{}
	cmf.NewDb().First(&option, "option_name = ?", "site_info") // 查询

	m := make(map[string]interface{}, 5)
	err := json.Unmarshal([]byte([]byte(option.OptionValue)), &m) //第二个参数要地址传递
	if err != nil {
		return m
	}
	return nil
}

// 获取系统配置项
func Options(key string) string {
	option := Option{}
	var optionJson string
	uploadResult := cmf.NewDb().First(&option, "option_name = ?", key) // 查询
	if uploadResult.RowsAffected > 0 {
		optionJson = option.OptionValue
	}
	return optionJson
}


//获取网站上传配置信息
func GetUploadSetting(c *gin.Context) *UploadSetting {
	session := sessions.Default(c)
	uploadSettingStr := session.Get("uploadSetting")
	option := Option{}
	uploadSetting := &UploadSetting{}
	if uploadSettingStr == nil {
		uploadResult := cmf.Db().First(&option, "option_name = ?", "upload_setting") // 查询
		if uploadResult.RowsAffected > 0 {
			uploadSettingStr = option.OptionValue
			//存入session
			session.Set("uploadSetting", uploadSettingStr)
		}
	}

	//读取的数据为json格式，需要进行解码
	json.Unmarshal([]byte(uploadSettingStr.(string)), uploadSetting)
	return uploadSetting
}

//添加用户操作日志
func SetLog(c *gin.Context, module string, controller string, action string, message string) {
	currentUser := CurrentUser(c)
	cmf.NewDb().Create(&Log{
		ModuleName:     module,
		ControllerName: controller,
		ActionName:     action,
		Url:            c.Request.URL.String(),
		RequestIp:      c.ClientIP(),
		UserId:         currentUser.Id,
		UserNickname:   currentUser.UserNickname,
		Message:        message,
		CreateAt:       time.Now().Unix(),
	})
}

func GetAuthAccess(c *gin.Context) []AuthAccessRule {

	session := sessions.Default(c)
	res := session.Get("authAccessRule")
	if session.Get("authAccessRule") == nil {

		user := CurrentUser(c)
		// 获取当前用户全部的权限列表
		role := util.GetRoleById(user.Id)
		var roleIds []string
		for _, v := range role {
			roleIds = append(roleIds, strconv.Itoa(v.Id))
		}

		roleIdsStr := strings.Join(roleIds, ",")

		var query []string
		var queryArgs []interface{}

		if roleIdsStr != "" {
			query = append(query, "role_id in (?)")
			queryArgs = append(queryArgs, roleIdsStr)
		}

		queryStr := strings.Join(query, " AND ")

		var authAccessRule []AuthAccessRule
		prefix := cmf.Conf().Database.Prefix
		cmf.NewDb().Table(prefix+"auth_access access").Select("access.*,r.name").
			Joins("INNER JOIN "+prefix+"auth_rule r ON access.rule_id = r.id").Where(queryStr, queryArgs...).Scan(&authAccessRule)
		session.Set("authAccessRule", authAccessRule)
		session.Save()

		return authAccessRule

	}

	return res.([]AuthAccessRule)

}

func CurrentUser(c *gin.Context) User {
	u := User{}
	session :=sessions.Default(c)
	user := session.Get("user")
	userId, _ := c.Get("user_id")
	userIdInt, _ := strconv.Atoi(userId.(string))
	if user == nil {
		cmf.NewDb().First(&u, "id = ?", userId)
		jsonBytes, _ := json.Marshal(u)
		session.Set("user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = User{}
			cmf.NewDb().Where("id = ?", userId).First(&u)
			jsonBytes, _ := json.Marshal(u)
			session.Set("user", string(jsonBytes))
			session.Save()
			return u
		}
	}
	return u
}

func CurrentMpUser(c *gin.Context) User {
	u := User{}
	session :=sessions.Default(c)
	user := session.Get("mp_user")
	userId, _ := c.Get("mp_user_id")
	userIdInt, _ := userId.(int)

	if user == nil {
		cmf.NewDb().First(&u, "id = ?", userId)
		jsonBytes, _ := json.Marshal(u)
		session.Set("mp_user", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := user.(string)
		json.Unmarshal([]byte(jsonBytes), &u)
		if u.Id == 0 || u.Id != userIdInt {
			u = User{}
			cmf.NewDb().Where("id = ?", userId).First(&u)
			jsonBytes, _ := json.Marshal(u)
			session.Set("mp_user", string(jsonBytes))
			session.Save()
			return u
		}
	}
	return u
}
