package home

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/view"
)

type Index struct {
	view.Template
}

//首页控制器
func (view *Index) Index(c *gin.Context) {
	fmt.Println("header", c.Request.Header)
	fmt.Println("tls", c.Request.TLS)
	view.Fetch("index.html")
}
