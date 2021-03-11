/**
** @创建时间: 2020/11/4 11:46 下午
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

func Test_Region(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	// cmf.Db().Migrator().DropTable(&model.Region{})
	cmf.Db().AutoMigrate(&model.Region{})

	f, err := os.Open("../../data/region.sql")
	if err != nil {
		fmt.Println("err", err)
	}
	bytes, _ := ioutil.ReadAll(f)
	result := string(bytes)
	result = strings.ReplaceAll(result, "{prefix}", "cmf_")

	sqlArr := strings.Split(result, ";")

	// fmt.Println("sqlArr", sqlArr)

	for _, sql := range sqlArr {
		cmf.Db().Debug().Exec(sql)
	}

}
