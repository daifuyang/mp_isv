/**
** @创建时间: 2020/11/23 10:11 上午
** @作者　　: return
** @描述　　:
 */
package qiniuPlugin

import (
	"gincmf/plugins/qiniuPlugin/router"
)

func Init() {
	router.ApiListenRouter()

	//bm := cmf.QiuNiuConf().BucketManager
	/*err := bm.CreateBucket("tenant-1051453199",storage.RIDHuadong)

	if err != nil {
		fmt.Printf("CreateBucket() error: %v\n", err)
	}*/

}
