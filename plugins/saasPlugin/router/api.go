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
	"gincmf/plugins/saasPlugin/controller/api/common"
	"gincmf/plugins/saasPlugin/controller/api/tenant"
	"gincmf/plugins/saasPlugin/controller/app"
	saasMigrate "gincmf/plugins/saasPlugin/migrate"
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
		tenantGroup.Get("/mp/apps", new(tenant.MpTheme).Get)
		tenantGroup.Get("/mp/apps/:id", new(tenant.MpTheme).Show)
		tenantGroup.Post("/mp/create", new(tenant.MpTheme).Store)
		tenantGroup.Post("/mp/apps/:id", new(tenant.MpTheme).Edit)
		tenantGroup.Delete("/mp/apps/:id", new(tenant.MpTheme).Delete)

		// 根据mid获取主题首页
		tenantGroup.Get("/mp/theme/home",middleware.ValidationMerchant,new(tenant.MpThemePage).Home)

		// 小程序页面管理
		tenantGroup.Rest("/mp/page", new(tenant.MpThemePage))
		// 资源管理
		tenantGroup.Rest("/assets", new(tenant.AssetsController))

		// 同步数据库
		tenantGroup.Get("/sync", func(c *gin.Context) {
			new(migrate.AdminMenu).AutoMigrate()
			migrate.StartTenantMigrate()
			saasMigrate.AutoMigrate()
			// 地址
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
	appGroup := cmf.Group("api/v1/app", middleware.ValidationMp)
	{
		appGroup.Post("/user/detail",middleware.ValidationUserId,AliMiddle.AppAuthToken,new(app.User).Show)
		appGroup.Post("/user/edit",middleware.ValidationUserId,new(app.User).Edit)
		appGroup.Post("/theme_file",new(tenant.MpThemePage).Detail)
	}
}
