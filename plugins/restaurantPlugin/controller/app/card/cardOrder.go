/**
** @创建时间: 2021/1/15 3:28 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Order struct {
	rc controller.RestController
}

func (rest Order) Get(c *gin.Context) {

	mpUserId, _ := c.Get("mp_user_id")
	mid, _ := c.Get("mid")

	var query = []string{"user_id = ? AND co.mid = ? AND order_status = ?"}
	var queryArgs = []interface{}{mpUserId, mid, "TRADE_FINISHED"}

	data, err := new(model.MemberCardOrder).Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}
