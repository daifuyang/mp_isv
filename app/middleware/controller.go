package middleware

import (
	"fmt"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/view"
)

func BaseController(c *gin.Context) {

}

func HomeBaseController(c *gin.Context) {
	t := view.Template{
		Context: c,
	}

	tmpl :=  "/"+cmf.TemplateMap.ThemePath+"/"+cmf.TemplateMap.Theme
	fmt.Println("tmpl",tmpl)
	template := t.Assign("tmpl",tmpl) //静态资源路径
	c.Set("template",template)
	c.Next()
}

func ApiBaseController(c *gin.Context) {

}

func ApiController(c *gin.Context) {

}

func AdminController(c *gin.Context) {

}
