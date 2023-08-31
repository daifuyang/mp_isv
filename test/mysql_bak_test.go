/**
** @创建时间: 2021/11/6 17:43
** @作者　　: return
** @描述　　:
 */
package test

import (
	"database/sql"
	"fmt"
	"gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"os/exec"
	"strconv"
	"testing"
)

func Test_MysqlBack(t *testing.T) {
	cmf.Initialize("../data/conf/config.json")
	var tenant []model.Tenant
	cmf.Db().Find(&tenant)
	fmt.Println("tenant",tenant)

	// targetSource :=  "root:123456@tcp(127.0.0.1:3306)/"

	var createNames = []string{"dt_web", "mp_isv", "msd_web"}

	for _,dbName := range createNames{
		if dbName != "" {

			fmt.Println("dbName",dbName)

			// CreateTable(dbName,targetSource)

			// ImportCommand(dbName)

			ExportCommand(dbName)

			// CreateTable(dbName,targetSource)
		}
	}

	for _,v := range tenant {
		if v.TenantId > 0 {
			dbName := "tenant_"+strconv.Itoa(v.TenantId)
			fmt.Println("dbName", dbName)
			ExportCommand(dbName)
			// CreateTable("tenant_"+strconv.Itoa(v.TenantId),targetSource)
		}
	}

}

func CreateTable(dbName string, dataSource string) {
	//创建不存在的数据库
	tempDb, tempErr := sql.Open("mysql", dataSource)
	if tempErr != nil {
		panic(new(error))
	}
	_, err := tempDb.Exec("CREATE DATABASE IF NOT EXISTS " + dbName + " CHARACTER set utf8mb4 COLLATE utf8mb4_general_ci")
	if err != nil {
		panic(err)
	}
	fmt.Println("create "+ dbName +" success")
	tempDb.Close()
}

func Test_MysqlDump(t *testing.T)  {

	command := "docker exec  739758f7a93b  mysqldump -hrm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com -P3306 -uroot -pcodecloud2020 mp_isv > bak/mp_isv.sql"
	cmd := exec.Command("/bin/bash", "-c",command)

	err := cmd.Run()
	if err != nil {
		fmt.Println("Execute Command failed:" + err.Error())
		return
	}

}

func ExportCommand(dbName string)  {
	command := "docker exec  739758f7a93b  mysqldump -hrm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com -P3306 -ump_isv -pcodecloud2020 --databases "+dbName+" --set-gtid-purged=OFF --triggers --routines --events > bak/"+dbName+".sql"

	cmd := exec.Command("/bin/bash", "-c",command)

	err := cmd.Start()
	if err != nil {
		fmt.Println("Execute Command failed:" + err.Error())
		return
	}

	err = cmd.Wait()
	if err != nil {
		fmt.Println(err)
	}
}

func ImportCommand(dbName string){
	//command := "docker exec  739758f7a93b  mysql -hrm-bp1sz0va1gb9943hjio.mysql.rds.aliyuncs.com -P3306 -ump_isv -pcodecloud2020  < bak/"+dbName+".sql"

	command := "docker exec  739758f7a93b  mysql -h127.0.0.1 -P3306 -uroot -p123456 "+dbName+" < bak/"+dbName+".sql"

	cmd := exec.Command("/bin/bash", "-c",command)

	err := cmd.Start()
	if err != nil {
		fmt.Println("Execute Command failed:" + err.Error())
		return
	}

	err = cmd.Wait()
	if err != nil {
		fmt.Println(err)
	}
}