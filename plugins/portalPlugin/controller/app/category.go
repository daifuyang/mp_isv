/**
** @创建时间: 2020/12/25 8:43 下午
** @作者　　: return
** @描述　　:
 */
package app

import (
	"gincmf/app/util"
	"gincmf/plugins/portalPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"strconv"
)

type Category struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看分类列表
 * @Date 2020/11/11 18:23:49
 * @Param
 * @return
 **/
func (rest *Category) List(c *gin.Context) {

	pid := c.DefaultQuery("pid", "0")
	parentId, _ := strconv.Atoi(pid)
	category := model.PortalCategory{
		ParentId: parentId,
	}
	data, err := category.ListWithTree()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 根据id寻找父类id
 * @Date 2021/1/8 15:2:48
 * @Param
 * @return
 **/

func (rest *Category) GetTopId(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	topId, err := new(model.PortalCategory).GetTopId(rewrite.Id)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", gin.H{"top_id": topId})

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询单个门户分类
 * @Date 2020/11/7 21:14:53
 * @Param
 * @return
 **/
func (rest *Category) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	portalCategory := model.PortalCategory{
		Id: rewrite.Id,
		Db: db,
	}

	data, err := portalCategory.Show()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}
