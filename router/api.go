package router

import (
	"gincmf/app/controller/api/admin"
	"gincmf/app/controller/api/common"
	"gincmf/app/controller/api/tenant"
	"gincmf/app/middleware"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
)

//web路由初始化
func ApiListenRouter() {

	adminGroup := cmf.Group("api/admin",middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.ApiBaseController, middleware.Rbac)
	{
		adminGroup.Rest("/settings", new(admin.SettingsController))
		adminGroup.Rest("/assets", new(admin.AssetsController))
		adminGroup.Rest("/upload", new(admin.UploadController))
		adminGroup.Rest("/role", new(admin.RoleController))
		adminGroup.Rest("/user", new(admin.UserController))
		adminGroup.Get("/admin_menu", new(admin.MenuController).Get)
		adminGroup.Get("/authorize", new(admin.AuthorizeController).Get)
		adminGroup.Get("/authorize/:id", new(admin.AuthorizeController).Show)
		adminGroup.Get("/auth_access/:id", new(admin.AuthAccessController).Show)
		adminGroup.Post("/auth_access/:id", new(admin.AuthAccessController).Edit)
		adminGroup.Post("/auth_access", new(admin.AuthAccessController).Store)
	}


	// 租户注册
	cmf.Post("api/tenant/register",middleware.MainDb,new(tenant.TenantController).Register)

	tenantGroup := cmf.Group("api/tenant",middleware.ValidationBearerToken,middleware.TenantDb, middleware.ValidationAdmin, middleware.ApiBaseController, middleware.Rbac)
	{
		tenantGroup.Get("/mp/apps",new(tenant.MpThemeController).Get)
		tenantGroup.Post("/mp/create",new(tenant.MpThemeController).Store)
		// 小程序页面管理
		tenantGroup.Rest("/mp/page",new(tenant.MpThemePageController))
		// 资源管理
		tenantGroup.Rest("/assets", new(tenant.AssetsController))
	}



	// 获取短信验证码
	cmf.Post("api/sms_code",new(common.SmsCodeController).Post)

	// 获取当前用户信息
	cmf.Get("/api/currentUser", middleware.ValidationBearerToken, middleware.ValidationAdmin, func(c *gin.Context) {
		scope,_ := c.Get("scope")
		if scope == "tenant" {
			new(tenant.TenantController).CurrentUser(c)
		}else{
			new(admin.UserController).CurrentUser(c)
		}
	})

	common.RegisterOauthRouter(middleware.MainDb)
	common.RegisterTenantRouter(middleware.MainDb)
}
