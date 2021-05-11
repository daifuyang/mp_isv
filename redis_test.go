/**
** @创建时间: 2020/11/1 7:44 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"fmt"
	cmf "github.com/gincmf/cmf/bootstrap"
	"net/url"
	"testing"
)

func Test_redis(t *testing.T) {
	cmf.Initialize("./data/conf/config.json")
	exists := cmf.NewRedisDb().Exists("1111")
	fmt.Println("exists", exists.Val())

}

func Test_encode(t *testing.T)  {
	s := "scene=eatin&store_number=1019753356&desk_number=745883686"
	query := url.QueryEscape(s)
	fmt.Println("query",query)
}
