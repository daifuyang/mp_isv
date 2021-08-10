/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/plugins/portalPlugin/controller/admin"
	"gincmf/plugins/portalPlugin/controller/app"
	cmf "github.com/gincmf/cmf/bootstrap"
)

func ApiListenRouter() {

	adminGroup := cmf.Group("api/v1/admin", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationAdmin, middleware.AllowCors, middleware.ValidationMerchant)
	{
		adminGroup.Rest("/portal/category", new(admin.Category))
		adminGroup.Get("/portal/category_list", new(admin.Category).List)
		adminGroup.Get("/portal/category_options", new(admin.Category).Options)
		adminGroup.Rest("/portal/article", new(admin.PortalPost))
	}

	appGroup := cmf.Group("api/v1/app", middleware.ValidationMerchant, middleware.ApiBaseController)
	{
		appGroup.Get("/portal/category", new(app.Category).List)
		appGroup.Get("/portal/category/:id", new(app.Category).Show)

		appGroup.Get("/portal/top_category_id/:id", new(app.Category).GetTopId)
		appGroup.Get("/portal/list/:id", new(app.Post).Get) // 根据id获取分页列表
		appGroup.Post("/portal/list_with_id", new(app.Post).ListWithCid)

		appGroup.Get("/portal/article/:id", new(app.Post).Show)

	}

	appGroup = cmf.Group("api/v1/mp", middleware.ValidationMp, middleware.ApiBaseController)
	{
		appGroup.Get("/portal/list/:id", new(app.Post).Get) // 根据id获取分页列表
		appGroup.Get("/portal/article/:id", new(app.Post).Show)
	}

}
