/**
** @创建时间: 2021/1/15 4:25 下午
** @作者　　: return
** @描述　　:
 */
package recharge

import (
	appModel "gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Log struct {
	rc controller.Rest
}

func (rest Log) Get(c *gin.Context) {
	mpUserId, _ := c.Get("mp_user_id")

	var query = []string{"user_id = ?"}
	var queryArgs = []interface{}{mpUserId}

	data, err := new(appModel.RechargeLog).Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}
