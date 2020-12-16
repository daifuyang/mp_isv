/**
** @创建时间: 2020/11/4 11:46 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"fmt"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"os"
	"strings"
)

type Region struct {
	Migrate
}

func (migrate Region) AutoMigrate() {

	// cmf.Db().AutoMigrate(&model.Region{})

	f, err := os.Open(util.CurrentPath() + "/data/region.sql")
	if err != nil {
		fmt.Println("err", err)
	}
	bytes, _ := ioutil.ReadAll(f)
	result := string(bytes)
	prefix := cmf.Conf().Database.Prefix
	result = strings.ReplaceAll(result, "{prefix}", prefix)
	// fmt.Println(result)
	sqlArr := strings.Split(result, ";")
	go func() {
		for _, sql := range sqlArr {
			cmf.Db().Exec(sql)
		}
	}()
}
