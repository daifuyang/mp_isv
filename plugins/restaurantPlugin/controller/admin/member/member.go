/**
** @创建时间: 2020/12/17 9:45 下午
** @作者　　: return
** @描述　　: 会员列表
 */
package member

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Index struct {
	rc controller.RestController
}

// @Summary 会员管理
// @Description 查看全部会员列表
// @Tags restaurant 会员管理
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.User} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/member [get]
func (rest *Index) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"u.mid = ?", "u.delete_at = ?"}
	var queryArgs = []interface{}{mid, 0}

	u := model.User{}
	data, err := u.ThirdPartIndex(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Index) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

func (rest *Index) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

func (rest *Index) Store(c *gin.Context) {
	rest.rc.Success(c, "操作成功Store", nil)
}

func (rest *Index) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
