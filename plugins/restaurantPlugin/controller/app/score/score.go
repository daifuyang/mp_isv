/**
** @创建时间: 2021/1/3 10:44 上午
** @作者　　: return
** @描述　　:
 */
package score

import (
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Score struct {
	rc controller.Rest
}

func (rest *Score) Score(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	var query = []string{"user_id = ?"}
	var queryArgs = []interface{}{userId}

	scoreLog := appModel.ScoreLog{
		Db: db,
	}

	data, err := scoreLog.Index(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}
