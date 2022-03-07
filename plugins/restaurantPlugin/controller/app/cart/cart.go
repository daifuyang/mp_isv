/**
** @创建时间: 2021/7/4 5:43 下午
** @作者　　: return
** @描述　　:
 */
package cart

import (
	"encoding/json"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/cmfWebsocket"
	"github.com/gincmf/cmf/controller"
	"github.com/shopspring/decimal"
	"strconv"
	"time"
)

type Cart struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 获取点餐数据
 * @Date 2021/7/4 18:0:27
 * @Param
 * @return
 **/

/*
	key userid json [{
		"food_id":1,
		"name":测试名称,
		"sku_id":1,
		"tasty":[{
			"attr_key":"",
			"attr_value":""
		}],
		"material":[{
			"id":"",
			"count":"",
			"material_name":"",
			"material_price":""
		}],
		"count":1
	}]
*/

func (rest *Cart) SocketGet(c *gin.Context) {

	var (
		conn      *cmfWebsocket.Connection
		err       error
		cartsConn = make(map[*cmfWebsocket.Connection]string, 0)
	)

	userId, _ := c.Get("user_id")
	userIdInt := userId.(int)
	userIdStr := strconv.Itoa(userIdInt)

	// 获取租户信息
	tenantId, _ := c.Get("tenant_id")
	tenantIdInt := tenantId.(int)
	tenantIdStr := strconv.Itoa(tenantIdInt)

	// 获取门店信息
	deskNumber, _ := c.Get("desk_number")

	conn = new(cmfWebsocket.Client).GetClient(userIdStr).Conn

	for {

		/*
				1.获取当前租户
				2.获取当前mid
				3.获取当前门店id
				4.获取当前桌号
				5.获取当前openId
				6.获取当前userId
				7.查询当前redis数据库中的数据

				mp_isv123456:carts:desk666666

				key food_id json {
				2:jsonstr,
				3:jsonstr,
			}


		*/

		key := "mp_isv" + tenantIdStr + ":cart:desk" + strconv.Itoa(deskNumber.(int))

		allData, _ :=cmf.RedisDb().Get(key).Result()

		cartStr := cartsConn[conn]
		allDataByte, _ := json.Marshal(allData)

		if cartStr != string(allDataByte) {

			cartsConn[conn] = string(allDataByte)

			var allCarts = make(map[string]foodItem, 0)

			// 遍历所有的购物车，并合并数据
			cart := make(map[string]foodItem, 0)
			json.Unmarshal([]byte(allData), &cart)

			for ck, cv := range cart {

				cartItem := allCarts[ck]

				isNew := false

				// 如果当前商品不存在，则创建该商品
				if cartItem.FoodId == 0 {
					isNew = true
					cartItem = cv
					cartItem.Count = 0
					cartItem.Sku = make(map[string]Sku, 0)
				}

				cartItem.Food.PrevPath = util.GetFileUrl(cartItem.Food.Thumbnail, "thumbnail500x500")

				// 判断当前商品是否启用规格
				if cv.Food.UseSku == 1 || cv.Food.UseTasty == 1 || cv.Food.UseMaterial == 1 {

					cartItem.Count = cartItem.Count + cv.Count

					if cv.Sku != nil {

						var total float64 = 0

						for sk, sv := range cv.Sku {

							sItem := cartItem.Sku[sk]
							if isNew {
								sItem.FoodId = sv.FoodId
								sItem.SkuId = sv.SkuId
								sItem.Count = 0
							}

							sItem.Remark = sv.Remark

							sItem.Count = sItem.Count + sv.Count
							sItem.Type = ""

							sItem.Price = sv.Price
							sItem.Total, _ = decimal.NewFromFloat(float64(sItem.Count)).Mul(decimal.NewFromFloat(sItem.Price)).Round(2).Float64()

							total += sItem.Total

							sItem.Material = sv.Material
							sItem.Tasty = sv.Tasty

							cartItem.Sku[sk] = sItem

						}

						cartItem.Total = total
					}

				} else {

					cartItem.Count = cartItem.Count + cv.Count
					cartItem.Type = ""
					cartItem.Price = cv.Price
					cartItem.Total, _ = decimal.NewFromFloat(float64(cartItem.Count)).Mul(decimal.NewFromFloat(cartItem.Price)).Round(2).Float64()

				}

				if cartItem.FoodId > 0 {
					allCarts[ck] = cartItem
				}
			}

			// 查询当前用户订单
			if err = conn.Success("获取成功！", allCarts); err != nil {
				new(cmfWebsocket.Client).DelClient(userIdStr)
			}

		}

		time.Sleep(time.Millisecond * 500)

	}

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 设置购物车
 * @Date 2021/7/4 20:12:5
 * @Param
 * @return
 **/
type tasty struct {
	Key   string `json:"key"`
	Value string `json:"val"`
}

type material struct {
	Id            int     `json:"id,omitempty"`
	Count         int     `json:"count,omitempty"`
	MaterialName  string  `json:"material_name,omitempty"`
	MaterialPrice float64 `json:"material_price,omitempty"`
}

type Sku struct {
	FoodId    int                `json:"food_id"`
	Inventory int                `json:"inventory,omitempty"`
	SkuId     int                `json:"sku_id"`
	Remark    string             `json:"remark"`
	Price     float64            `json:"price"`
	Total     float64            `json:"total"`
	Type      string             `json:"type,omitempty"`
	Count     int                `json:"count"`
	Material  map[int]material `json:"material"`
	Tasty     map[string]tasty   `json:"tasty"`
}

type foodItem struct {
	FoodId     int                  `json:"food_id"`
	Food       model.FoodStoreHouse `json:"food,omitempty"`
	Price      float64              `json:"price"`
	Total      float64              `json:"total"`
	CategoryId int                  `json:"category_id"`
	Count      int                  `json:"count"`
	Type       string               `json:"type,omitempty"`
	Sku        map[string]Sku       `json:"sku,omitempty"`
}

func (rest *Cart) SetCart(c *gin.Context) {

	/*userId, _ := c.Get("mp_user_id")

	userInt := userId.(int)
	userIdStr := strconv.Itoa(userInt)*/

	tenantId, _ := c.Get("tenant_id")
	tenantIdInt := tenantId.(int)
	tenantIdStr := strconv.Itoa(tenantIdInt)

	dbName := "tenant_"+tenantIdStr

	// deskId

	/*
		1.添加商品
		food_id:{
			sku:{
				mqstr:{

				}
			}
		}
	*/

	var form struct {
		DeskNumber int                 `json:"desk_number"`
		Carts      map[string]foodItem `json:"carts"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if form.DeskNumber == 0 {
		rest.rc.Error(c, "桌号不能为空！", nil)
		return
	}

	db := cmf.ManualDb(dbName)
	desk := model.Desk{}
	tx := db.Where("desk_number = ?", form.DeskNumber).First(&desk)
	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "该桌号不存在！", nil)
		return
	}

	key := "mp_isv" + tenantIdStr + ":cart:desk" + strconv.Itoa(desk.DeskNumber)
	allCart, _ :=cmf.RedisDb().Get(key).Result()

	var carts = make(map[string]*foodItem, 0)

	if allCart != "" {
		_ = json.Unmarshal([]byte(allCart), &carts)
	}

	// 遍历用户传进来的参数，进行合并处理
	for k, v := range form.Carts {

		fmt.Println(k, v)

		food := model.Food{}
		tx := db.Where("id = ?", k).First(&food)
		if tx.Error != nil {
			rest.rc.Error(c, food.Name+"菜品不存在！", nil)
			return
		}

		fItem := carts[k]

		if fItem == nil {
			fItem = new(foodItem)
		}

		startSale := food.StartSale

		// 判断是否为sku操作
		if food.UseSku == 1 || food.UseTasty == 1 || food.UseMaterial == 1 {

			fmt.Println("use sku")

			if fItem.Sku == nil {
				fItem.Sku = make(map[string]Sku, 0)
			}

			skuCount := 0

			fItem.Count = 0

			for skuK, skuV := range v.Sku {

				isNew := false
				if fItem.FoodId == 0 {
					fItem.FoodId = v.FoodId
					fItem.CategoryId = v.CategoryId
					fItem.Price = v.Price
					isNew = true
				}

				remark := ""

				for _, sv := range skuV.Tasty {
					remark += sv.Value + " | "
				}

				if len(remark) > 2 {
					remark = remark[0 : len(remark)-2]
				}

				fItem.Food = food.FoodStoreHouse
				fItem.Price = fItem.Food.Price

				sItem := fItem.Sku[skuK]

				sItem.FoodId = fItem.Food.Id
				sItem.Price = fItem.Food.Price
				sItem.Remark = remark

				if isNew {
					sItem.Count = 0
				}

				count := skuV.Count

				// 刚开始点击
				if fItem.Count == 0 && count < startSale {
					count = startSale
				}

				sItem.FoodId = food.Id
				if food.UseSku == 1 {
					foodSku := model.FoodSku{}
					tx := db.Where("sku_id = ?", skuV.SkuId).First(&foodSku)
					if tx.Error != nil {
						rest.rc.Error(c, food.Name+"规格不存在！", nil)
						return
					}

					sItem.SkuId = foodSku.SkuId
					sItem.Inventory = foodSku.Inventory
					sItem.Price = foodSku.Price
				}

				sItem.Tasty = skuV.Tasty
				sItem.Material = skuV.Material

				// 规格增加
				if skuV.Type == "add" {

					// 库存
					if skuV.Count > 0 && (skuV.Count > sItem.Inventory || skuV.Inventory == -1) {
						sItem.Count = sItem.Count + skuV.Count

					} else {

						rest.rc.Error(c, "该规格商品数量必须大于0或库存不足！", nil)
						return

					}

				} else {
					// 减少规格
					if sItem.Count-skuV.Count > 0 {
						sItem.Count = sItem.Count - skuV.Count
					} else {
						sItem = Sku{}
						delete(fItem.Sku, skuK)
					}
				}

				if sItem.FoodId > 0 {
					sItem.Type = ""
					skuCount += sItem.Count

					skuTotal, _ := decimal.NewFromFloat(sItem.Price).Mul(decimal.NewFromFloat(float64(skuCount))).Round(2).Float64()
					sItem.Total = skuTotal

					fItem.Sku[skuK] = sItem
				}

			}

			if fItem.FoodId > 0 {
				fItem.Type = ""
				fItem.Count = fItem.Count + skuCount
				carts[k] = fItem
			}

			if len(fItem.Sku) == 0 {
				delete(carts, k)
			}

		} else {
			// 判断是增加还是删除

			if fItem.FoodId == 0 {
				fItem.FoodId = v.FoodId
				fItem.CategoryId = v.CategoryId
				fItem.Count = 0
			}

			count := v.Count

			// 刚开始点击
			if fItem.Count == 0 && count < startSale {
				count = startSale
			}

			fItem.Type = ""
			fItem.Food = food.FoodStoreHouse
			fItem.Price = fItem.Food.Price

			if v.Type == "add" {
				if v.Count > 0 && (v.Count <= food.Inventory || food.Inventory == -1) {
					fItem.Count = fItem.Count + count
				} else {
					rest.rc.Error(c, "该商品数量必须大于0或库存不足！", nil)
					return
				}
			} else {
				// 没超过库存
				if fItem.Count-count > 0 {
					fItem.Count = fItem.Count - count
				} else {
					fItem = new(foodItem)
					delete(carts, k)
				}
			}

			if fItem.FoodId > 0 {
				total, _ := decimal.NewFromFloat(fItem.Price).Mul(decimal.NewFromFloat(float64(fItem.Count))).Round(2).Float64()
				fItem.Total = total
				carts[k] = fItem
			}
		}
	}

	cartsJson, _ := json.Marshal(carts)
	cmf.RedisDb().Set(key, cartsJson, 0)

	rest.rc.Success(c, "设置成功！", carts)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 清空购物车
 * @Date 2021/7/7 22:32:16
 * @Param
 * @return
 **/
func (rest *Cart) ClearCart(c *gin.Context) {

	tenantId, _ := c.Get("tenant_id")
	tenantIdInt := tenantId.(int)
	tenantIdStr := strconv.Itoa(tenantIdInt)

	dbName := "tenant_"+tenantIdStr

	db := cmf.ManualDb(dbName)

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	deskNumber := rewrite.Id

	desk := model.Desk{}
	tx := db.Where("desk_number = ?", deskNumber).First(&desk)
	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "该桌号不存在！", nil)
		return
	}

	key := "mp_isv" + tenantIdStr + ":cart:desk" + strconv.Itoa(desk.DeskNumber)

	cmf.RedisDb().Del(key)

	rest.rc.Success(c,"操作成功！",nil)

}
