/**
** @创建时间: 2021/2/21 10:33 下午
** @作者　　: return
** @描述　　:
 */
package mini

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/mini"
	"github.com/gincmf/cmf/controller"
)

type Members struct {
	rc controller.RestController
}

func (rest *Members) Get(c *gin.Context) {

	bizContent := make(map[string]interface{}, 0)
	bizContent["role"] = "EXPERIENCER"

	result := new(mini.Member).Query(bizContent)

	if result.Response.Code == "10000" {
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}

func (rest *Members) Store(c *gin.Context) {

	logonId := c.PostForm("logon_id")
	if logonId == "" {
		rest.rc.Error(c, "邀请人不能为空！", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["role"] = "EXPERIENCER"
	bizContent["logon_id"] = logonId

	result := new(mini.Member).Create(bizContent)

	if result.Response.Code == "10000" {
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}

func (rest *Members) Delete(c *gin.Context) {

	userId := c.Query("user_id")
	if userId == "" {
		rest.rc.Error(c, "邀请人不能为空！", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["role"] = "EXPERIENCER"
	bizContent["user_id"] = userId

	result := new(mini.Member).Delete(bizContent)

	if result.Response.Code == "10000" {
		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}
