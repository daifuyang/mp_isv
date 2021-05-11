/**
** @创建时间: 2021/3/1 12:22 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func Test_minCategory(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	cmf.Db().AutoMigrate(&MiniCategory{})
}
