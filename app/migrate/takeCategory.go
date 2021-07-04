/**
** @创建时间: 2021/4/4 10:41 上午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"os"
	"strings"
	"sync"
)

type takeCategory struct {
	Migrate
}

func (migrate takeCategory) AutoMigrate() {

	cmf.Db().Migrator().DropTable(&model.TakeoutCategory{})
	cmf.Db().AutoMigrate(&model.TakeoutCategory{})

	f, err := os.Open(util.CurrentPath() + "/data/takeout_category.sql")
	if err != nil {
		fmt.Println("err", err)
	}
	bytes, _ := ioutil.ReadAll(f)
	result := string(bytes)
	prefix := cmf.Conf().Database.Prefix
	result = strings.ReplaceAll(result, "{prefix}", prefix)
	// fmt.Println(result)
	sqlArr := strings.Split(result, ";")
	mutex := sync.Mutex{}
	for _, sql := range sqlArr {
		sql := sql
		go func() {
			mutex.Lock()
			if sql != "" {
				cmf.Db().Exec(sql)
			}
			mutex.Unlock()
		}()
	}
}
