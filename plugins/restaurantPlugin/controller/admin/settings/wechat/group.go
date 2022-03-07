/**
** @创建时间: 2021/3/31 5:46 下午
** @作者　　: return
** @描述　　:
 */
package wechat

import (
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Group struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取支付宝云客服配置
 * @Date 2021/3/31 17:47:40
 * @Param
 * @return
 **/
func (rest *Group) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")
	group := resModel.Group{
		Db: db,
	}
	data, err := group.Show(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Group) Edit(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	group := resModel.Group{}
	if err := c.ShouldBindJSON(&group); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	group.Db = db

	data, err := group.Edit(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "修改成功！", data)

}
