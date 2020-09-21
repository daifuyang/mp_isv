package router

import (
	"gincmf/app/controller/api/admin"
	cmf "github.com/gincmf/cmf/bootstrap"
)

//web路由初始化
func ApiListenRouter() {
	cmf.Get("/alipay/authRedirect", new(admin.AuthRedirectController).Get)
}
