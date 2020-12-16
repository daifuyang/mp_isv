/**
** @创建时间: 2020/11/1 7:44 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"fmt"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func Test_redis(t *testing.T) {
	cmf.Initialize("./data/conf/config.json")
	exists := cmf.NewRedisDb().Exists("1111")
	fmt.Println("exists",exists.Val())

}
