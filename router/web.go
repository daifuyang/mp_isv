/**
** @创建时间: 2021/3/25 10:55 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/controller/web/home"
	"gincmf/app/middleware"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func WebListenRouter()  {
	cmf.Get("/index",new(home.Index).Index,middleware.HomeBaseController)
	cmf.Get("/qrcode/:id",new(home.Qrcode).Index,middleware.HomeBaseController)
	cmf.Get("/call/:mobile",new(home.Call).Mobile,middleware.HomeBaseController)
}
