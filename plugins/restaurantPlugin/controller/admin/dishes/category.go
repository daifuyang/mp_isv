/**
** @创建时间: 2020/10/29 11:16 下午
** @作者　　: return
** @描述　　: 菜单分类管理
 */
package controller

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type CategoryController struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部菜品分类列表
 * @Date 2020/10/30 00:02:36
 * @Param 
 * @return 
 **/
func (rest *CategoryController) Get(c *gin.Context) {
	rest.rc.Success(c, "操作成功Get", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单个菜品分类
 * @Date 2020/10/30 00:03:07
 * @Param 
 * @return 
 **/
func (rest *CategoryController) Show(c *gin.Context) {
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
 * @Description 修改单个菜品分类
 * @Date 2020/10/30 00:03:20
 * @Param 
 * @return 
 **/
func (rest *CategoryController) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个菜单分类
 * @Date 2020/10/30 00:07:18
 * @Param 
 * @return 
 **/
func (rest *CategoryController) Store(c *gin.Context) {

	// 获取菜品名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c,"菜品分类名称不能为空！",nil)
		return
	}

	//// 获取菜品图标
	//icon := c.PostForm("icon")
	//
	//// 必选品
	//isRequired := c.DefaultPostForm("is_required","0")
	//
	//
	//// 场景（默认支持全部）
	//isRequired := c.DefaultPostForm("is_required","0")
	//
	//store := c.PostFormArray("store")


	rest.rc.Success(c, "添加成功！", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个菜单分类
 * @Date 2020/10/30 00:08:18
 * @Param
 * @return
 **/
func (rest *CategoryController) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
