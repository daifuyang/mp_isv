/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　: 插件名采用大驼峰命名法，都带 Plugin类名后缀，如 DemoPlugin,CustomAdminLoginPlugin
 */
package controller

import (
	"encoding/json"
	"fmt"
	"gincmf/plugins/queuePlugin/model"
	rModel "gincmf/plugins/restaurantPlugin/model"
	sModel "gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/go-redis/redis"
	"strconv"
	"time"
)

type Queue struct {
	rc  controller.RestController
}

func (rest Queue) Init() {

	tenant, err := sModel.Tenant{}.List(nil, nil)
	if err != nil {
		fmt.Println("err", err.Error())
	}

	var toAdd []redis.Z

	for _, tv := range tenant {

		db := "tenant_" + strconv.Itoa(tv.TenantId)
		cmf.ManualDb(db)

		fo := rModel.FoodOrder{}
		orderData, err := fo.List([]string{"order_status = ?"}, []interface{}{"WAIT_BUYER_PAY"})

		if err != nil {
			fmt.Println("err", err.Error())
		}

		for _, v := range orderData {
			tenantId := strconv.Itoa(tv.TenantId)
			q := model.Queue{
				DbName:    "tenant_" + tenantId,
				CreateAt:  v.CreateAt,
				ExpireAt:  600,
				QueueType: "order",
				TargetId:  v.Id,
			}

			toAddJson, err := json.Marshal(&q)
			if err != nil {
				fmt.Println("err", err.Error())
			}

			score := float64(v.CreateAt + 600)
			toAdd = append(toAdd, redis.Z{
				Score:  score,
				Member: toAddJson,
			})
		}

	}

	q := model.Queue{
		Key: "mp_isv:queue_order",
	}
	q.AddAll(toAdd)

}

func (rest Queue) Queue() {
	ticker := time.NewTicker(time.Second * 1)
	go func() {
		for _ = range ticker.C {

			// 获取当前redis中运行的队列
			q := model.Queue{
				Key: "mp_isv:queue_order",
			}

			result ,err := q.ExpireAllData()
			if err != nil {
				fmt.Println("err",err.Error())
			}

			// 获取全部失效订单
			for _,v := range result{
				// 解析为go结构体对象
				q = model.Queue{
					Key: "mp_isv:queue_order",
				}
				json.Unmarshal([]byte(v.Member.(string)),&q)
				// 关闭订单
				result := cmf.ManualDb(q.DbName).Model(rModel.FoodOrder{}).Where("id = ?",q.TargetId).Update("order_status","TRADE_CLOSED")
				if result.Error != nil {
					fmt.Println(result.Error)
				}

				// 移出队列
				cmd := cmf.NewRedisDb().ZRem(q.Key,v.Member)
				if cmd.Err() != nil {
					fmt.Println("cmd.err",cmd.Err())
				}
			}

		}
	}()
}
