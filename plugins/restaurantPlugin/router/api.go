/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/plugins/restaurantPlugin/controller/admin/dishes"
	cmf "github.com/gincmf/cmf/bootstrap"

)

func ApiListenRouter() {
	adminGroup := cmf.Group("api/admin", middleware.ValidationBearerToken, middleware.ValidationAdmin,middleware.TenantDb, middleware.ApiBaseController, middleware.Rbac)
	{
		// 注册后台菜单路由
		adminGroup.Rest("/dishes/index",new(controller.IndexController))
		adminGroup.Rest("/dishes/category",new(controller.CategoryController))
	}
}
