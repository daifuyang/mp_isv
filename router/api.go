package router

import (
	"gincmf/app/controller/api/admin"
	"gincmf/app/controller/api/common"
	"gincmf/app/middleware"
	"gincmf/app/model"
	"gincmf/plugins/saasPlugin/controller/api/tenant"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
)

//web路由初始化
func ApiListenRouter() {

	adminGroup := cmf.Group("api/admin", middleware.ValidationBearerToken, middleware.ValidationAdmin, middleware.ApiBaseController, middleware.Rbac)
	{
		adminGroup.Rest("/settings", new(admin.SettingsController))
		adminGroup.Rest("/assets", new(admin.AssetsController))
		adminGroup.Rest("/upload", new(admin.UploadController))
		adminGroup.Rest("/role", new(admin.RoleController))
		adminGroup.Rest("/user", new(admin.User))
		adminGroup.Get("/admin_menu", new(admin.MenuController).Get)
		adminGroup.Get("/authorize", new(admin.AuthorizeController).Get)
		adminGroup.Get("/authorize/:id", new(admin.AuthorizeController).Show)
		adminGroup.Get("/auth_access/:id", new(admin.AuthAccessController).Show)
		adminGroup.Post("/auth_access/:id", new(admin.AuthAccessController).Edit)
		adminGroup.Post("/auth_access", new(admin.AuthAccessController).Store)
	}

	// 获取短信验证码
	cmf.Post("api/sms_code", new(common.SmsCodeController).Post)

	// 获取当前用户信息
	cmf.Get("/api/currentUser", middleware.ValidationBearerToken, middleware.ValidationAdmin,middleware.ApiBaseController, func(c *gin.Context) {
		scope, _ := c.Get("scope")
		if scope == "tenant" {
			new(tenant.User).CurrentUser(c)
		} else {
			new(admin.User).CurrentUser(c)
		}
	})

	v1 := cmf.Group("/api/v1")
	{
		v1.Get("/",new(admin.IndexController).Get)
		// 获取省市区
		v1.Get("/region", new(common.RegionController).Get)
		v1.Get("/region/list/:id", new(common.RegionController).List)
		v1.Get("/region/detail/:id", new(common.RegionController).One)

		// 获取门店类目
		v1.Get("/shop_category",new(common.ShopCategory).Get)
		v1.Get("/shop_category/list/:id",new(common.ShopCategory).List)
		v1.Get("/shop_category/last/:id",new(common.ShopCategory).Last)
		v1.Get("/shop_category/detail/:id",new(common.ShopCategory).One)
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

	common.RegisterOauthRouter()
}
