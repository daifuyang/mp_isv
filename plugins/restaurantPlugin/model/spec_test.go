/**
** @创建时间: 2020/11/16 2:37 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"fmt"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"log"
	"testing"
)


func Test_attr(t *testing.T) {

	cmf.Initialize("../../../data/conf/config.json")

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	var tempAttr []tempAttrPost
	prefix := cmf.Conf().Database.Prefix
	result := cmf.ManualDb("tenant_1051453199").Select("ap.food_id,v.attr_value_id,v.attr_value,k.attr_id,k.name").Table(prefix+"food_attr_post ap").
		Joins("INNER JOIN "+prefix+"food_attr_value v ON ap.attr_value_id = v.attr_value_id").
		Joins("INNER JOIN "+prefix+"food_attr_key k ON k.attr_id = v.attr_id").
		Where("ap.food_id = ?", 7).Scan(&tempAttr)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		log.Fatal(result.Error)
	}
	
	fmt.Println(tempAttr)
}