/**
** @创建时间: 2020/11/9 5:46 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"fmt"
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
	"time"
)

func Test_Migrate(t *testing.T) {
	cmf.Initialize("./data/conf/config.json")

	redisDb, err := cmf.RedisDb("52.130.144.34", "codecloud2020")
	if err == nil {
		redisDb.Set("componentVerifyTicket", "ticket@@@JPI_QKD8CnY0fqhATzSZrQwIybDnJgM8lAupQ6hKhVvMqUix5JB8jCrCbdGgBNhPmM360ZrEIGKELrpOavw2fw", time.Hour*12)
	}

	fmt.Println(redisDb.Get("componentVerifyTicket"))

	// appMigrate.StartMigrate()
	// cmf.ManualDb("tenant_562847651")
	// cmf.NewDb().Debug().AutoMigrate(&wechatModel.Applyment{})
	// saasMigrate.AutoMigrate()
	//new(saasModel.Role).Init(123456)
	// 创建当前租户的七牛云空间

	/*user := saasModel.AdminUser{
		UserLogin: "17625458588",
		Mobile:    "17625458588",
		UserPass:  "3ffc0ef0ced4e6824cc61b5afdedcff4",
		CreateAt:  time.Now().Unix(),
	}
	user.Init()*/
}

func Test_menu(t *testing.T) {

	cmf.Initialize("./data/conf/config.json")
	cmf.ManualDb("tenant_562847651")
	cmf.NewDb().Migrator().DropTable(&model.AdminMenu{})
	cmf.NewDb().AutoMigrate(&model.AdminMenu{})
	model.AutoAdminMenu("562847651")

}
