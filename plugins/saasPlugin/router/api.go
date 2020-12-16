/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/app/migrate"
	AliMiddle "gincmf/plugins/alipayPlugin/middleware"
	"gincmf/plugins/restaurantPlugin"
	model2 "gincmf/plugins/restaurantPlugin/model"
	"gincmf/plugins/saasPlugin/controller/api/common"
	"gincmf/plugins/saasPlugin/controller/api/tenant"
	"gincmf/plugins/saasPlugin/controller/app"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/model"
)

func ApiListenRouter() {

	// 租户注册
	cmf.Post("api/tenant/register", middleware.MainDb, new(tenant.User).Register)

	// 租户通用管理
	tenantGroup := cmf.Group("api/tenant", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationAdmin, middleware.ApiBaseController, middleware.Rbac)
	{
		tenantGroup.Get("/mp/apps", new(tenant.MpThemeController).Get)
		tenantGroup.Post("/mp/create", new(tenant.MpThemeController).Store)
		// 小程序页面管理
		tenantGroup.Rest("/mp/page", new(tenant.MpThemePageController))
		// 资源管理
		tenantGroup.Rest("/assets", new(tenant.AssetsController))

		// 同步数据库
		tenantGroup.Get("/sync", func(c *gin.Context) {
			new(migrate.AdminMenu).AutoMigrate()
			migrate.StartTenantMigrate()
			restaurantPlugin.AutoMigrate()
			// 地址
			cmf.NewDb().AutoMigrate(&model2.Address{})
			c.JSON(200, model.ReturnData{
				Code: 1,
				Data: nil,
				Msg:  "同步成功！",
			})
		})
	}

	// 注册租户信息
	common.RegisterTenantRouter()

	// 小程序路由注册
	appGroup := cmf.Group("api/v1/app", middleware.ValidationMp,middleware.ValidationUserId,AliMiddle.AppAuthToken)
	{
		appGroup.Post("/user/detail",new(app.User).Show)
		appGroup.Post("/user/edit",new(app.User).Edit)
	}
}
