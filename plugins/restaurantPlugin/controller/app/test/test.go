/**
** @创建时间: 2021/6/29 10:27 上午
** @作者　　: return
** @描述　　:
 */
package test

import (
	"fmt"
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

	fmt.Println("test1")
	user := model.User{}
	cmf.NewDb().Where("id = 2").First(&user)

	fmt.Println("cmf.NewDb()", cmf.NewDb())
	fmt.Println("cmf.NewDb() user", user)

	time.Sleep(6 * time.Second)

	fmt.Println("defer6 cmf.NewDb()", cmf.NewDb())

	cmf.NewDb().Where("id = 2").First(&user)
	fmt.Println("cmf.NewDb() user", user)

	rest.rc.Success(c, "获取成功！", nil)

}

func (rest *Index) Test2(c *gin.Context) {

	db := "tenant_722216550"
	cmf.ManualDb(db)

	rest.rc.Success(c, "获取成功！", nil)
}
