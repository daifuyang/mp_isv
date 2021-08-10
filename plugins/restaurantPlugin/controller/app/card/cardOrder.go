/**
** @创建时间: 2021/1/15 3:28 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Order struct {
	rc controller.Rest
}

func (rest Order) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mpUserId, _ := c.Get("mp_user_id")
	mid, _ := c.Get("mid")

	var query = []string{"user_id = ? AND co.mid = ? AND order_status = ?"}
	var queryArgs = []interface{}{mpUserId, mid, "TRADE_FINISHED"}

	memberCardOrder := model.MemberCardOrder{
		Db: db,
	}

	data, err := memberCardOrder.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}
