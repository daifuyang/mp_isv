package middleware

import (
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/view"
)

func BaseController(c *gin.Context) {

}

func InitDomain(c *gin.Context) {

	scheme := "http://"
	if c.Request.Header.Get("Scheme") == "https" {
		scheme = "https://"
	}

	domain := scheme + c.Request.Host
	cmf.SetConf("domain", domain)

}

func HomeBaseController(c *gin.Context) {
	t := view.Template{}
	tmpl := "/" + cmf.TemplateMap.ThemePath + "/" + cmf.TemplateMap.Theme
	template := t.Assign("tmpl", tmpl) //静态资源路径
	c.Set("template", template)
	c.Next()
}

func ApiBaseController(c *gin.Context) {

}

func ApiController(c *gin.Context) {

}

func AdminController(c *gin.Context) {

}
