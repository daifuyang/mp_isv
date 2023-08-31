/**
** @创建时间: 2021/7/31 11:47 下午
** @作者　　: return
** @描述　　:
 */
package test

import (
	"fmt"
	"gincmf/app/util"
	"strconv"
	"testing"
	"time"
)

func Test_runtime(t *testing.T) {

	for k := 0; k < 10; k++ {
		kk := k
		go func() {
			util.Request("GET", "http://localhost:4002/api/v1/test/test1?index="+strconv.Itoa(kk), nil, map[string]string{})
		}()

		go func() {
			code,_:= util.Request("GET", "http://localhost:4002/api/v1/test/test2?index="+strconv.Itoa(kk), nil, map[string]string{})
			fmt.Println(code)
		}()
	}

	time.Sleep(1 * time.Second)

}
