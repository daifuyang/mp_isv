package home

import (
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/view"
)

type Index struct {
	view.Template
}

//首页控制器
func (web *Index) Index(c *gin.Context) {
	view := web.GetView(c)
	view.Fetch("index.html")
}