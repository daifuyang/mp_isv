/**
** @创建时间: 2020/12/17 11:03 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"gincmf/app/model"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
)

// 获取当前租户信息
func CurrentTenant(c *gin.Context) Tenant {
	t := Tenant{}
	session := sessions.Default(c)
	tenant := session.Get("tenant")
	userId, _ := c.Get("user_id")
	userIdInt, _ := strconv.Atoi(userId.(string))
	if tenant == nil {
		cmf.Db().First(&t, "id = ?", userId)
		jsonBytes, _ := json.Marshal(t)
		session.Set("tenant", string(jsonBytes))
		session.Save()
	} else {
		jsonBytes := tenant.(string)
		json.Unmarshal([]byte(jsonBytes), &t)
		if t.Id == 0 || t.Id != userIdInt {
			cmf.Db().Where("id = ?", userId).First(&t)
			jsonBytes, _ := json.Marshal(t)
			session.Set("tenant", string(jsonBytes))
			session.Save()
			return t
		}
	}
	return t
}

// 获取系统配置项
func Options(key string, mid int) string {
	option := model.Option{}
	var optionJson string
	uploadResult := cmf.NewDb().First(&option, "option_name = ? AND  mid = ?", key, mid) // 查询
	if uploadResult.RowsAffected > 0 {
		optionJson = option.OptionValue
	}
	return optionJson
}
