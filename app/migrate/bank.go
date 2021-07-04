/**
** @创建时间: 2021/4/27 9:59 上午
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
	"sync"
	"time"
)

type Bank struct {
	Id           int    `json:"id"`
	BankName     string `gorm:"type:varchar(128);comment:银行全称;not null" json:"bank_name"`
	BankBranchId string `gorm:"type:varchar(128);comment:联行号" json:"bank_branch_id"`
	Type         string `gorm:"type:tinyint(3);comment:类型（0 => 银行大类，1=> 支行详情）;default:0;not null" json:"type"`
}

func (migrate Bank) AutoMigrate() {

	cmf.Db().Migrator().DropTable(&migrate)
	cmf.Db().AutoMigrate(&migrate)

	time.Sleep(time.Second * 1)

	f, err := os.Open(util.CurrentPath() + "/data/bank.sql")
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
