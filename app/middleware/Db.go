/**
** @创建时间: 2020/10/6 9:28 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"fmt"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
)

// 设置主db
func MainDb(c *gin.Context) {
	cmf.ManualDb(cmf.Conf().Database.Name)
	c.Next()
}

// 设置租户id
func TenantDb(c *gin.Context) {
	currentTenant := saasModel.CurrentTenant(c)
	fmt.Println("currentTenant",currentTenant.TenantId)
	db := "tenant_" + strconv.Itoa(currentTenant.TenantId)
	cmf.ManualDb(db)
	c.Next()
}

/*func TestTenantDb(c *gin.Context) {
	cmf.ManualDb("tenant_1051453199")
	c.Next()
}*/
