/**
** @创建时间: 2021/4/27 10:59 上午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Bank struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取银行主列表
 * @Date 2021/4/27 11:2:51
 * @Param
 * @return
 **/
func (rest *Bank) Get(c *gin.Context) {
	result, err := new(model.Bank).List()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", result)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 其他行模糊搜索
 * @Date 2021/4/27 11:3:11
 * @Param
 * @return
 **/

func (rest *Bank) GetLike(c *gin.Context) {

	keywords := c.Query("keywords")
	if keywords == "" {
		rest.rc.Error(c, "银行关键词不能为空！", nil)
		return
	}
	result, err := new(model.Bank).ListLike(keywords)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", result)
}
