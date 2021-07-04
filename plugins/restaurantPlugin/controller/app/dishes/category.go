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
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2021/5/15 21:12:45
 * @Param
 * @return
 **/
func (rest *Category) List(c *gin.Context) {

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")

	scene := c.DefaultQuery("scene", "1")

	if !(scene == "1" || scene == "2") {
		rest.rc.Error(c, "场景参数不正确", nil)
		return
	}

	category := model.FoodCategory{}

	var query []string
	var queryArgs []interface{}

	query = append(query, "mid = ? AND store_id = ? AND delete_at = ? AND status = ?")
	queryArgs = append(queryArgs, mid, storeId, 0, 1)

	query = append(query, "(scene = 0 OR scene = ?)")
	queryArgs = append(queryArgs, scene)

	data, err := category.ListByStore(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, "获取失败！", err.Error())
		return
	}
	rest.rc.Success(c, "获取成功！", data)

}
