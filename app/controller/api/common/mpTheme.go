/**
** @创建时间: 2021/3/28 10:40 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type MpTheme struct {
	rc controller.Rest
}

func (rest *MpTheme) Get(c *gin.Context) {

	var query = []string{"status = ?"}
	var queryArgs = []interface{}{"1"}

	data, err := new(model.MpTheme).Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
}
