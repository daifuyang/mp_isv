/**
** @创建时间: 2021/2/20 1:30 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"strings"
)

type Recharge struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取全部会员订单
 * @Date 2021/2/20 13:31:3
 * @Param
 * @return
 **/
func (rest Recharge) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"ro.mid = ?"}
	var queryArgs = []interface{}{mid}

	keywords := c.Query("keywords")

	if keywords != "" {
		var querySub = []string{"(ro.order_id LIKE ?", "ro.trade_no LIKE ?", "u.user_nickname LIKE ?", "u.user_realname LIKE ?)"}

		querySubStr := strings.Join(querySub, " OR ")

		querySubStr = strings.ReplaceAll(querySubStr, "?", "'%"+keywords+"%'")

		query = append(query, querySubStr)
	}

	data, err := new(model.RechargeOrder).Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}
