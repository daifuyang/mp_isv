/**
** @创建时间: 2021/4/27 10:51 上午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"fmt"
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"os"
	"strings"
	"testing"
)

func Test_Bank(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	cmf.Db().Migrator().DropTable(&model.Bank{})

	cmf.Db().AutoMigrate(&model.Bank{})

	f, err := os.Open("../../data/bank.sql")
	if err != nil {
		fmt.Println("err", err)
	}
	bytes, _ := ioutil.ReadAll(f)
	result := string(bytes)
	result = strings.ReplaceAll(result, "{prefix}", "cmf_")

	sqlArr := strings.Split(result, ";")

	// fmt.Println("sqlArr", sqlArr)

	for _, sql := range sqlArr {
		cmf.Db().Exec(sql)
	}

}
