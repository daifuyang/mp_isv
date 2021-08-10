/**
** @创建时间: 2021/3/31 7:26 下午
** @作者　　: return
** @描述　　:
 */
package contact

import (
	"gincmf/app/util"
	"gincmf/plugins/alipayPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Contact struct {
	rc controller.Rest
}

func (rest *Contact) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")
	cb := model.ContactButton{
		Db: db,
	}
	data, err := cb.Show(mid.(int))

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}
