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
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/go-redis/redis"
	"strconv"
	"strings"
	"time"
)

type Queue struct {
	rc controller.Rest
}

func (rest Queue) Init() {
	foodInit()
}

func (rest Queue) Queue() {
	// ticker := time.NewTicker(time.Second * 1)

	hTicker := time.NewTicker(time.Minute * 30)
	go func() {
		for range hTicker.C {
			foodInit()
		}
	}()
}

// -------订单相关
func orderInit() {

	tenant, err := new(saasModel.Tenant).List(nil, nil)
	if err != nil {
		fmt.Println("err", err.Error())
	}

	var toAdd []redis.Z

	for _, tv := range tenant {

		db := "tenant_" + strconv.Itoa(tv.TenantId)
		cmf.ManualDb(db)

		fo := resModel.FoodOrder{}
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

func orderTask() {
	// 获取当前redis中运行的队列
	q := model.Queue{
		Key: "mp_isv:queue_order",
	}

	result, err := q.ExpireAllData()
	if err != nil {
		fmt.Println("err", err.Error())
	}

	// 获取全部失效订单
	for _, v := range result {
		// 解析为go结构体对象
		q = model.Queue{
			Key: "mp_isv:queue_order",
		}
		json.Unmarshal([]byte(v.Member.(string)), &q)
		// 关闭订单
		result := cmf.ManualDb(q.DbName).Model(resModel.FoodOrder{}).Where("id = ?", q.TargetId).Update("order_status", "TRADE_CLOSED")
		if result.Error != nil {
			fmt.Println(result.Error)
		}

		// 移出队列
		cmd := cmf.NewRedisDb().ZRem(q.Key, v.Member)
		if cmd.Err() != nil {
			fmt.Println("cmd.err", cmd.Err())
		}
	}
}

// ------堂食沽清
func foodInit() {

	var tenant []saasModel.Tenant
	tx := cmf.Db().Find(&tenant)

	if tx.Error != nil {
	}

	m := time.Now().Minute()
	h := time.Now().Hour()

	nowSecond := h*3600 + m*60
	insertKey := "mp_isv:food:sellClear:"

	for _, t := range tenant {

		if t.TenantId > 0 {
			mid := strconv.Itoa(t.TenantId)
			cmf.ManualDb("tenant_" + mid)

			// 获取堂食配置
			var store []resModel.Store
			cmf.NewDb().Find(&store)

			for _, v := range store {
				if v.EnabledSellClear == 1 {

					// 读取redis 是否完成沽清
					val, _ := cmf.NewRedisDb().Get(insertKey + mid).Result()
					if val != "1" {
						sellClearTime := v.SellClear
						if sellClearTime == "" {
							sellClearTime = "23:00"
						}

						// 时间转换
						sc := strings.Split(v.SellClear, ":")
						if len(sc) == 2 {
							h, _ := strconv.Atoi(sc[0])
							m, _ := strconv.Atoi(sc[1])
							scSecond := h*3600 + m*60

							if nowSecond >= scSecond {
								SellClear()
								cmf.NewRedisDb().Set(insertKey, "1", 0)
								year, month, day := time.Now().Date()
								today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
								cmf.NewRedisDb().ExpireAt(insertKey, today)
							}

						}

					}

				}
			}

		}

	}

}

func SellClear() error {
	var food []resModel.Food
	tx := cmf.NewDb().Find(&food)
	if tx.Error != nil {
		return tx.Error
	}

	for _, f := range food {
		foodItem := f
		foodItem.Inventory = f.DefaultInventory
		tx := cmf.NewDb().Updates(foodItem)
		if tx.Error != nil {
			return tx.Error
		}
	}

	return nil
}
