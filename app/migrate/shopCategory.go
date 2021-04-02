/**
** @创建时间: 2020/12/20 2:41 下午
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
	"time"
)

type shopCategory struct {
	Migrate
}

func (migrate shopCategory) AutoMigrate() {

	cmf.Db().Migrator().DropTable(&model.ShopCategory{})
	cmf.Db().AutoMigrate(&model.ShopCategory{})

	time.Sleep(time.Second * 1)

	f, err := os.Open(util.CurrentPath() + "/data/shop_category.sql")
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
