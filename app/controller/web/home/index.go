package home

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/view"
)

type Index struct {
	view.Template
}

//首页控制器
func (v *Index) Index(c *gin.Context) {

	iTemplate, _ := c.Get("template")
	v.Template = iTemplate.(view.Template)
	v.Fetch("index.html")
}
