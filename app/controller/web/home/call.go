/**
** @创建时间: 2021/4/5 3:57 下午
** @作者　　: return
** @描述　　:
 */
package home

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/view"
	"strconv"
)

type Call struct {
	view.Template
}

// 拨打电话
func (v *Call) Mobile(c *gin.Context) {

	iTemplate, _ := c.Get("template")
	v.Template = iTemplate.(view.Template)

	// 完成业务
	var rewrite struct {
		Mobile int `uri:"mobile"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	c.Redirect(301, "tel:"+strconv.Itoa(rewrite.Mobile))

}
