/**
** @创建时间: 2021/3/4 10:40 上午
** @作者　　: return
** @描述　　:
 */
package desk

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
)

type Desk struct {
	rc controller.RestController
}

func (rest *Desk) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	desk := model.Desk{}

	var query []string
	var queryArgs []interface{}

	query = append(query, "d.desk_number = ? AND d.mid = ?")
	queryArgs = append(queryArgs, rewrite.Id, mid)

	data, err := desk.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该桌位不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}
