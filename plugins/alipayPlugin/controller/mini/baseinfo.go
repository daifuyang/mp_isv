/**
** @创建时间: 2021/2/21 9:25 下午
** @作者　　: return
** @描述　　:
 */
package mini

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/mini"
	"github.com/gincmf/cmf/controller"
)

type BaseInfo struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看小程序详情
 * @Date 2021/2/21 20:26:8
 * @Param
 * @return
 **/
func (rest *BaseInfo) Detail(c *gin.Context) {

	bizContent := make(map[string]interface{}, 0)

	result := new(mini.BaseInfo).Query(bizContent)

	if result.Response.Code == "10000" {
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}
