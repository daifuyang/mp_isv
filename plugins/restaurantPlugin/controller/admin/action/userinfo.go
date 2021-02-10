/**
** @创建时间: 2021/1/23 1:47 下午
** @作者　　: return
** @描述　　:
 */
package action

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type USerInfo struct {
	rc controller.RestController
}

func (rest USerInfo) Options(c *gin.Context) {

	var options []map[string]string

	options = []map[string]string{{
		"label": "我的积分",
		"value": "score",
	},{
		"label": "我的优惠券",
		"value": "voucher",
	},{
		"label": "我的余额",
		"value": "balance",
	}}

	rest.rc.Success(c, "获取成功！", options)

}