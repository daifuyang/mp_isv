/**
** @创建时间: 2020/7/19 7:24 下午
** @作者　　: return
 */
package admin

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Role struct {
	rc controller.Rest
}

func (rest *Role) Get(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	mid, exist := c.Get("mid")

	if exist {
		query = append(query, "mid = ?")
		queryArgs = append(queryArgs, mid)
	}

	//  用户状态
	status := c.Query("status")
	if status != "" {
		query = append(query, "status = ?")
		queryArgs = append(queryArgs, status)
	}

	// 名称模糊搜索
	name := c.Query("name")
	if name != "" {
		query = append(query, "name LIKE ?")
		queryArgs = append(queryArgs, "%"+name+"%")
	}
	role := model.Role{}

	data, err := role.Get(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功", data)
}

func (rest *Role) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

func (rest *Role) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

func (rest *Role) Store(c *gin.Context) {
	rest.rc.Success(c, "操作成功Store", nil)
}

func (rest *Role) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
