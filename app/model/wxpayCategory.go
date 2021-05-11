/**
** @创建时间: 2021/4/27 1:48 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"fmt"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"os"
	"strings"
	"sync"
)

// 微信支付类目
type WxpayCategory struct {
	CategoryId   int    `gorm:"primaryKey;type:bigint(20) AUTO_INCREMENT;not null" json:"category_id"`
	CategoryName string `gorm:"type:varchar(48);comment:类目名称;not null" json:"category_name"`
	Type         int    `gorm:"type:tinyint(3);comment:(0=>全部,1=>个体,2=>企业 );default:0;not null" json:"type"`
}

func (model *WxpayCategory) AutoMigrate() {

	cmf.Db().Migrator().DropTable(&WxpayCategory{})
	cmf.Db().AutoMigrate(&WxpayCategory{})

	f, err := os.Open(util.CurrentPath() + "/data/wxpay_category.sql")
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

func (model *WxpayCategory) List(typ string) ([]WxpayCategory, error) {

	// 第一步查询出全部的省市区
	var w []WxpayCategory
	tx := cmf.Db().Where("type = 0 || type = ?", typ).Find(&w)
	if tx.Error != nil {
		return w, tx.Error
	}
	return w, nil
}
