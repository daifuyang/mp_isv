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

type Scan struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 扫码领券配置
 * @Date 2021/3/31 17:47:40
 * @Param
 * @return
 **/
func (rest *Scan) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")
	scan := resModel.Scan{
		Db: db,
	}
	data, err := scan.Show(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Scan) Edit(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	var scan = resModel.Scan{
		Db: db,
	}
	if err := c.ShouldBindJSON(&scan); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	data, err := scan.Edit(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "修改成功！", data)

}
