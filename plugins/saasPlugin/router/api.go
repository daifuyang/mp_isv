/**
** @创建时间: 2020/10/29 4:33 下午
** @作者　　: return
** @描述　　:
 */
package router

import (
	"gincmf/app/controller/api/admin"
	"gincmf/app/middleware"
	"gincmf/app/middleware/socket"
	"gincmf/plugins/saasPlugin/controller/api/common"
	"gincmf/plugins/saasPlugin/controller/api/tenant"
	"gincmf/plugins/saasPlugin/controller/app"
	saasMigrate "gincmf/plugins/saasPlugin/migrate"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/model"
)

func ApiListenRouter() {

	// 租户注册
	cmf.Post("api/tenant/register", new(tenant.User).Register)
	cmf.Post("api/tenant/forget", new(tenant.User).Forget)
	cmf.Post("api/tenant/edit/:id", new(tenant.User).Edit)

	cmf.Post("api/tenant/fast_register", new(tenant.User).FastRegister)

	// 租户通用管理
	tenantGroup := cmf.Group("api/tenant", middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationAdmin, middleware.ApiBaseController, middleware.Rbac)
	{
		tenantGroup.Get("/admin_menu", new(tenant.Menu).Get, middleware.ValidationMerchant)

		tenantGroup.Rest("/assets", new(tenant.Assets), middleware.UseMerchant)

		tenantGroup.Post("/wechat/assets", new(tenant.Assets).WechatStore, middleware.UseMerchant)

		tenantGroup.Rest("/role", new(tenant.Role), middleware.ValidationMerchant)
		tenantGroup.Rest("/user", new(tenant.AdminUser), middleware.ValidationMerchant)

		// 展现当前全部规则
		tenantGroup.Get("/authorize", new(admin.Authorize).Get, middleware.ValidationMerchant)

		tenantGroup.Get("/auth_access/:id", new(tenant.AuthAccess).Show, middleware.ValidationMerchant)
		tenantGroup.Post("/auth_access/:id", new(tenant.AuthAccess).Edit, middleware.ValidationMerchant)
		tenantGroup.Post("/auth_access", new(tenant.AuthAccess).Store, middleware.ValidationMerchant)

		tenantGroup.Get("/mp/apps", new(tenant.MpTheme).Get)
		tenantGroup.Get("/mp/apps/:id", new(tenant.MpTheme).Show)
		tenantGroup.Get("/mp/show/mid", new(tenant.MpTheme).ShowByMid, middleware.ValidationMerchant)
		tenantGroup.Post("/mp/create", new(tenant.MpTheme).Store)
		tenantGroup.Post("/mp/apps/:id", new(tenant.MpTheme).Edit)
		tenantGroup.Delete("/mp/apps/:id", new(tenant.MpTheme).Delete)
		tenantGroup.Get("/mp/category/:id", new(tenant.MpTheme).UpdateCategory, middleware.ValidationMerchant)
		tenantGroup.Get("/mp/unbind/:id", new(tenant.MpTheme).UnOauth, middleware.ValidationMerchant)

		// 根据mid获取主题首页
		tenantGroup.Get("/mp/theme/home", new(tenant.MpThemePage).Home, middleware.ValidationMerchant)

		// 小程序页面管理
		tenantGroup.Rest("/mp/page", new(tenant.MpThemePage))
		// 资源管理

		// 查看全部通知
		tenantGroup.Get("/notice", new(tenant.Notice).Get, middleware.ValidationMerchant)

		// 标记通知已读
		tenantGroup.Get("/notice/:id", new(tenant.Notice).Show, middleware.ValidationMerchant)

		// 标记已经播放已读
		tenantGroup.Get("/notice_play/:id", new(tenant.Notice).IsPlay, middleware.ValidationMerchant)

		tenantGroup.Get("/notice_read_all", new(tenant.Notice).ReadAll, middleware.ValidationMerchant)

	}

	// 同步数据库
	cmf.Get("api/tenant/sync", func(c *gin.Context) {

		mid, _ := c.Get("mid")
		saasMigrate.AutoMigrate()
		new(saasModel.Role).Init(mid.(int))

		// 地址
		c.JSON(200, model.ReturnData{
			Code: 1,
			Data: nil,
			Msg:  "升级成功！",
		})
	}, middleware.ValidationBearerToken, middleware.TenantDb, middleware.ValidationMerchant)

	// 注册租户信息
	common.RegisterTenantRouter()

	// 小程序路由注册
	appGroup := cmf.Group("api/v1/app", middleware.ValidationMp)
	{
		appGroup.Post("/user/edit", new(app.User).Edit, middleware.ValidationBindMobile)
		appGroup.Post("/theme_file", new(tenant.MpThemePage).Detail)
		appGroup.Get("/mp/theme", new(tenant.MpTheme).ShowByMid)
	}

	cmf.Socket("api/v1/admin/notice", new(tenant.Notice).SocketGet, socket.ConnPools)
}
