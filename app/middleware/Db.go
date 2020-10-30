/**
** @创建时间: 2020/10/6 9:28 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"fmt"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
)

// 设置主db
func MainDb (c *gin.Context) {
	conf := cmf.Conf()
	dsn := cmfModel.NewDsn(conf.Database.Name,conf)
	cmf.Db = cmfModel.NewDb(dsn,conf.Database.Prefix)
	c.Next()
}

// 设置租户id
func TenantDb(c *gin.Context)  {
	currentTenant := util.CurrentTenant(c)

	fmt.Println("currentTenant",currentTenant)

	conf := cmf.Conf()
	dsn := cmfModel.NewDsn("tenant_"+currentTenant.TenantId,conf)
	cmf.Db = cmfModel.NewDb(dsn,conf.Database.Prefix)
	c.Next()
}
