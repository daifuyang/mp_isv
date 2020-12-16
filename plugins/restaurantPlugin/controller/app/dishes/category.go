/**
** @创建时间: 2020/11/23 11:36 下午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Category struct {
	rc controller.RestController
}

func (rest *Category) List(c *gin.Context) {

	storeId,_ := c.Get("store_id")

	category := model.FoodCategory{}

	var query []string
	var queryArgs []interface{}

	query = append(query,"store_id = ? AND delete_at = ? AND status = ?")
	queryArgs = append(queryArgs,storeId,0,1)

	data ,err :=  category.ListByStore(query,queryArgs)

	if err != nil {
		rest.rc.Error(c,"获取失败！",err.Error())
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}
