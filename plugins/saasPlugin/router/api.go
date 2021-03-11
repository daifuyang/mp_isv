/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/middleware"
	"gincmf/app/migrate"
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
	tenantGroup := cmf.Group("api/tenant", middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.TenantDb, middleware.ApiBaseController, middleware.Rbac)
	{

		tenantGroup.Rest("/assets", new(tenant.Assets), middleware.UseMerchant)
		tenantGroup.Get("/mp/apps", new(tenant.MpTheme).Get)
		tenantGroup.Get("/mp/apps/:id", new(tenant.MpTheme).Show)
		tenantGroup.Get("/mp/show/mid", middleware.ValidationMerchant, new(tenant.MpTheme).ShowByMid)
		tenantGroup.Post("/mp/create", new(tenant.MpTheme).Store)
		tenantGroup.Post("/mp/apps/:id", new(tenant.MpTheme).Edit)
		tenantGroup.Delete("/mp/apps/:id", new(tenant.MpTheme).Delete)
		tenantGroup.Get("/mp/category/:id", new(tenant.MpTheme).UpdateCategory)
		tenantGroup.Get("/mp/unbind/:id", new(tenant.MpTheme).UnOauth)

		// 根据mid获取主题首页
		tenantGroup.Get("/mp/theme/home", middleware.ValidationMerchant, new(tenant.MpThemePage).Home)

		// 小程序页面管理
		tenantGroup.Rest("/mp/page", new(tenant.MpThemePage))
		// 资源管理

		// 同步数据库
		tenantGroup.Get("/sync", func(c *gin.Context) {

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
		appGroup.Post("/user/edit", middleware.ValidationBindMobile, new(app.User).Edit)
		appGroup.Post("/theme_file", new(tenant.MpThemePage).Detail)
	}
}
