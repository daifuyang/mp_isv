/**
** @创建时间: 2020/12/17 11:03 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"fmt"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
)

// 获取当前租户信息
func CurrentTenant(c *gin.Context) Tenant {
	t := Tenant{}
	session :=sessions.Default(c)
	tenant := session.Get("tenant")
	userId, _ := c.Get("user_id")
	userIdInt, _ := strconv.Atoi(userId.(string))

	fmt.Println("tenant",tenant)
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
