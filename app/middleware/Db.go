/**
** @创建时间: 2020/10/6 9:28 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"strconv"
)

// 设置主db
func MainDb(c *gin.Context) {
	cmf.ManualDb(cmf.Conf().Database.Name)
	c.Next()
}

// 设置租户id
func TenantDb(c *gin.Context) {

	currentTenant, err := saasModel.CurrentTenant(c)
	aliasName := strconv.Itoa(currentTenant.TenantId)
	if currentTenant.AliasName != "" {
		aliasName = currentTenant.AliasName
	}

	c.Set("aliasName", aliasName)
	if err != nil {
		cmfLog.Error("err："+err.Error())
		new(controller.Rest).Error(c, "该租户不存在！", nil)
		c.Abort()
		return
	}
	db := "tenant_" + strconv.Itoa(currentTenant.TenantId)
	cmf.ManualDb(db)
	c.Next()
}

/*func TestTenantDb(c *gin.Context) {
	cmf.ManualDb("tenant_1051453199")
	c.Next()
}*/
