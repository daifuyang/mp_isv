/**
** @创建时间: 2021/6/29 10:27 上午
** @作者　　: return
** @描述　　:
 */
package test

import (
	"fmt"
	"gincmf/app/middleware"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"time"
)

type Index struct {
	rc controller.Rest
}

func (rest *Index) Test1(c *gin.Context) {

	index := c.Query("index")

	user := model.User{}
	middleware.Db.Where("id = 1").First(&user)

	fmt.Println("cmf.NewDb()" + index, middleware.Db)
	fmt.Println("cmf.NewDb() user" + index, user)

	time.Sleep(6 * time.Second)

	fmt.Println("defer6 cmf.NewDb()"+index, middleware.Db)

	middleware.Db.Where("id = 1").First(&user)
	fmt.Println("cmf.NewDb() user"+index, user)

	rest.rc.Success(c, "获取成功！", nil)

}

func (rest *Index) Test2(c *gin.Context) {

	db := "tenant_722216550"
	newDb := cmf.ManualDb(db)

	fmt.Println("tenant_722216550",newDb)

	rest.rc.Success(c, "获取成功！", nil)
}
