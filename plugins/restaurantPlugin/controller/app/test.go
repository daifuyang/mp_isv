/**
** @创建时间: 2021/7/31 11:55 下午
** @作者　　: return
** @描述　　:
 */
package app

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Test struct {
	rc controller.Rest
}

func (rest *Test) Get(c *gin.Context) {

	//t, _ := c.Get("URL")

	//ut := t.(*url.URL)

}
