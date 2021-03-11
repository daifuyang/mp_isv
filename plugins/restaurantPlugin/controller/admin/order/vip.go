/**
** @创建时间: 2021/2/20 1:29 下午
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

type Vip struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取全部会员订单
 * @Date 2021/2/20 13:31:3
 * @Param
 * @return
 **/
func (rest *Vip) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"co.mid = ?"}
	var queryArgs = []interface{}{mid}

	keywords := c.Query("keywords")

	if keywords != "" {
		var querySub = []string{"(co.order_id LIKE ?", "co.vip_num LIKE ?", "co.trade_no LIKE ?", "co.vip_name LIKE ?", "co.vip_level LIKE ?", "u.user_nickname LIKE ?", "u.user_realname LIKE ?)"}

		querySubStr := strings.Join(querySub, " OR ")

		querySubStr = strings.ReplaceAll(querySubStr, "?", "'%"+keywords+"%'")

		query = append(query, querySubStr)
	}

	data, err := new(model.MemberCardOrder).Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}
