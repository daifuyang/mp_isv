package main

import (
	"gincmf/app/migrate"
	_ "gincmf/docs"
	"gincmf/plugins"
	"gincmf/router"
	cmf "github.com/gincmf/cmf/bootstrap"
)

// @title MP-ISV API
// @version 1.0
// @description 智慧餐厅saas服务.
// @termsOfService

// @contact.name codeCloud
// @contact.url https://codecloud.ltd
// @contact.email codeCloud2020@163.com

// @license.name MIT
// @license.url

// @host localhost:4002
// @BasePath /api/v1
func main() {
	//初始化配置设置
	cmf.Initialize("./data/conf/config.json")

	// 关闭连接池
	db, _ := cmf.Db().DB()
	defer db.Close()

	tenantDb, _ := cmf.NewDb().DB()
	defer tenantDb.Close()

	//初始化路由设置
	router.ApiListenRouter()
	router.WebListenRouter()
	// 数据库迁移
	migrate.AutoMigrate()
	// 注册插件
	plugins.AutoRegister()

	//启动服务
	cmf.Start()
	//执行数据库迁移

}
