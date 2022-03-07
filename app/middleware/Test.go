/**
** @创建时间: 2021/8/1 12:00 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"fmt"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

var Db *gorm.DB

func Test(c *gin.Context) {

	index := c.Query("index")

	db := cmf.ManualDb("abc"+index)

	fmt.Println("db" + index,db)

	dbCopy := *db
	Db = &dbCopy

	// fmt.Println(u.String(), "testDb：" + *testDb)

	c.Set("URL", c.Request.URL)
	c.Next()
}
