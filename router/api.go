package router

import (
	"gincmf/app/controller/api/admin"
	"gincmf/app/controller/api/common"
	"gincmf/app/middleware"
	"gincmf/app/migrate"
	"gincmf/app/model"
	"gincmf/plugins/saasPlugin/controller/api/tenant"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
)

//web路由初始化
func ApiListenRouter() {

	// 全局中间件
	cmf.HandleFunc = append(cmf.HandleFunc, middleware.AllowCors)

	adminGroup := cmf.Group("api/admin", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationAdmin, middleware.ApiBaseController)
	{
		adminGroup.Rest("/settings", new(admin.Settings))
		adminGroup.Rest("/upload", new(admin.Upload))
		adminGroup.Rest("/role", new(admin.Role))
		adminGroup.Rest("/user", new(admin.User))
		adminGroup.Get("/admin_menu", new(admin.Menu).Get)
		adminGroup.Get("/authorize", new(admin.Authorize).Get)
		adminGroup.Get("/authorize/:id", new(admin.Authorize).Show)
		adminGroup.Get("/auth_access/:id", new(admin.AuthAccess).Show)
		adminGroup.Post("/auth_access/:id", new(admin.AuthAccess).Edit)
		adminGroup.Post("/auth_access", new(admin.AuthAccess).Store)
		adminGroup.Get("/notice/:id", new(admin.Notice).Show)
		adminGroup.Post("/notice/:id/read", new(admin.Notice).Read)
	}

	// 获取短信验证码
	cmf.Post("api/sms_code", new(common.SmsCode).Post)

	// 获取当前用户信息
	cmf.Get("/api/currentUser", new(tenant.User).CurrentUser, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationAdmin, middleware.ApiBaseController)

	v1 := cmf.Group("/api/v1")
	{
		v1.Get("/", new(admin.IndexController).Get)
		// 获取省市区
		v1.Get("/region", new(common.RegionController).Get)
		v1.Get("/region/list/:id", new(common.RegionController).List)
		v1.Get("/region/detail/:id", new(common.RegionController).One)

		// 获取门店类目
		v1.Get("/shop_category", new(common.ShopCategory).Get)
		v1.Get("/shop_category/list/:id", new(common.ShopCategory).List)
		v1.Get("/shop_category/last/:id", new(common.ShopCategory).Last)
		v1.Get("/shop_category/detail/:id", new(common.ShopCategory).One)

		// 获取小程序类目
		v1.Get("/mini_category/sync", new(common.MiniCategory).Sync)
		v1.Get("/mini_category", new(common.MiniCategory).Get)
		v1.Get("/mini_category/list/:id", new(common.MiniCategory).List)
		v1.Get("/mini_category/last/:id", new(common.MiniCategory).Last)
		v1.Get("/mini_category/detail/:id", new(common.MiniCategory).One)
	}

	// 清除缓存
	cmf.Get("/api/clear", func(c *gin.Context) {
		session := sessions.Default(c)
		session.Clear()
		session.Options(sessions.Options{MaxAge: -1})
		session.Save()
		c.JSON(200, model.ReturnData{
			Code: 1,
			Data: nil,
			Msg:  "清除成功！",
		})
	})

	cmf.Get("/api/sync", func(c *gin.Context) {
		migrate.StartMigrate()
		c.JSON(200, model.ReturnData{
			Code: 1,
			Data: nil,
			Msg:  "同步成功！",
		})
	})

	cmf.Get("/api/alipay_isv_app", new(admin.Settings).AlipayApp)

	common.RegisterOauthRouter()
}
