/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　:
 */
package controller

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type IndexController struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜单列表管理
 * @Date 11:43 下午 2020/10/29
 * @Param 
 * @return 
 **/
func (rest *IndexController) Get(c *gin.Context) {

	query := []string{"delete_at = ?"}
	queryArgs := []interface{}{"0"}

	// 菜品管理模型
	food := model.Food{}
	data, err := food.Index(c,query,queryArgs)
	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 预览单个菜品
 * @Date 11:44 下午 2020/10/29
 * @Param
 * @return
 **/
func (rest *IndexController) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 编辑单个菜品
 * @Date 11:45 下午 2020/10/29
 * @Param
 * @return
 **/
func (rest *IndexController) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增一项菜品
 * @Date 2020/10/29 23:58:18
 * @Param
 * @return
 **/
func (rest *IndexController) Store(c *gin.Context) {
	rest.rc.Success(c, "添加成功！", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一个菜品
 * @Date 2020/10/29 23:59:03
 * @Param
 * @return
 **/
func (rest *IndexController) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
