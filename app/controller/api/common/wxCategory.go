/**
** @创建时间: 2021/4/27 2:29 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type WxCategory struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取微信分类
 * @Date 2021/4/27 14:29:54
 * @Param
 * @return
 **/

func (rest *WxCategory) Get(c *gin.Context) {
	typ := c.Query("type")
	if typ == "" {
		 rest.rc.Error(c,"类型不能为空！",nil)
		return
	}

	result, err := new(model.WxpayCategory).List(typ)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", result)
}
