/**
** @创建时间: 2021/3/10 5:49 下午
** @作者　　: return
** @描述　　:
 */
package queuePlugin

import (
	"fmt"
	"gincmf/plugins/queuePlugin/controller"
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"strconv"
	"strings"
	"testing"
	"time"
)

func TestFoodClearSell(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	var tenant []saasModel.Tenant
	tx := cmf.Db().Find(&tenant)

	if tx.Error != nil {
	}

	m := time.Now().Minute()
	h := time.Now().Hour()

	nowSecond := h*3600 + m*60
	fmt.Println("nowSecond", nowSecond)

	insertKey := "mp_isv:food:sellClear:"

	for _, t := range tenant {

		if t.TenantId > 0 {
			mid := strconv.Itoa(t.TenantId)

			dbName := "tenant_" + mid
			// 获取堂食配置
			var store []resModel.Store
			cmf.ManualDb(dbName).Find(&store)

			for _, v := range store {
				if v.EnabledSellClear == 1 {
					fmt.Println("启动堂食沽清")

					// 读取redis 是否完成沽清
					val, _ :=cmf.RedisDb().Get(insertKey + mid).Result()
					if val != "" {

						sellClearTime := v.SellClear
						if sellClearTime == "" {
							sellClearTime = "23:00"
						}

						// 时间转换
						sc := strings.Split(v.SellClear, ":")
						fmt.Println("sc", sc)
						if len(sc) == 2 {
							h, _ := strconv.Atoi(sc[0])
							m, _ := strconv.Atoi(sc[1])
							scSecond := h*3600 + m*60

							if nowSecond >= scSecond {
								controller.SellClear(dbName)
								cmf.RedisDb().Set(insertKey, "1", 0)
								year, month, day := time.Now().Date()
								today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
								cmf.RedisDb().ExpireAt(insertKey, today)
							}

						}

					}

				}
			}

		}

	}

}
