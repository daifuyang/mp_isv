/**
** @创建时间: 2021/5/28 10:18 上午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/360EntSecGroup-Skylar/excelize/v2"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
	"os"
	"strconv"
	"strings"
	"sync"
	"testing"
	"time"
)

func TestFood_Import(t *testing.T) {

	cmf.Initialize("../../../../../data/conf/config.json")
	cmf.ManualDb("tenant_562847651")

	fp, _ := os.Open("./menu.xlsx") // 只读方式打开
	f, err := excelize.OpenReader(fp)

	if err != nil {
		fmt.Println(err)
		return
	}

	mid := 2100695345

	// Get all the rows in the Sheet1.
	rows, err := f.GetRows("菜品列表")

	if len(rows) == 0 {
		fmt.Println("err", "表内容为空！")
	}

	name := ""

	foodInventory := -1

	var wg sync.WaitGroup

	wg.Add(1)

	go func() {
	for k, v := range rows {

		if k > 1 {
			food := model.Food{}
			tx := cmf.NewDb().Where("name = ?", v[0]).First(&food)
			food.StoreId = 2
			food.Name = strings.TrimSpace(v[0])
			food.Excerpt = strings.TrimSpace(v[2])
			food.Mid = mid

			food.Unit = v[3]

			status := 1
			if v[4] == "下架" {
				status = 0
			}

			scene := 0

			if v[5] == "堂食" {
				scene = 1
			}

			if v[5] == "外卖" {
				scene = 2
			}

			food.Status = status
			food.Scene = scene

			isRecommend := 0

			if v[6] == "推荐" {
				isRecommend = 1
			}

			food.IsRecommend = isRecommend

			// 分类

			startSale := 1

			// 起售
			if v[8] != "" {
				startSaleInt, err := strconv.Atoi(v[8])
				if err != nil {
					startSale = 1
				} else {
					startSale = startSaleInt
				}
			}
			food.StartSale = startSale

			// 餐盒费
			var boxFee float64 = 0
			bf, err := strconv.ParseFloat(v[9], 64)
			if err != nil {
				boxFee = 0
			} else {
				boxFee = bf
			}

			food.BoxFee = boxFee

			food.FoodCode = v[13]

			// 重量
			var weight float64 = 0
			w, err := strconv.ParseFloat(v[14], 64)
			if err != nil {
				weight = 0
			} else {
				weight = w
			}
			food.Weight = weight

			// 售价
			var price float64 = 0
			priceFloat, err := strconv.ParseFloat(v[15], 64)
			if err != nil {
				price = 0
			} else {
				price = priceFloat
			}
			food.Price = price

			// 原价
			var originalPrice float64 = 0
			originalPriceFloat, err := strconv.ParseFloat(v[16], 64)
			if err != nil {
				originalPrice = 0
			} else {
				originalPrice = originalPriceFloat
			}
			food.OriginalPrice = originalPrice

			// 会员价
			var memberPrice float64 = 0
			memberPriceFloat, err := strconv.ParseFloat(v[17], 64)
			if err != nil {
				memberPrice = 0
			} else {
				memberPrice = memberPriceFloat
			}
			food.MemberPrice = memberPrice

			// 库存
			var inventory = -1
			inventoryInt, err := strconv.Atoi(v[18])
			if err != nil {
				inventory = -1
			} else {
				inventory = inventoryInt
			}

			// 设置规格库存
			if name == v[1] && v[10] == "启用" {
				inventory = foodInventory
			} else {
				name = v[1]
				foodInventory = inventory
			}

			food.Inventory = inventory
			food.DefaultInventory = inventory

			// 销量
			var volume = 0

			volumeInt, err := strconv.Atoi(v[19])
			if err != nil {
				volume = 0
			} else {
				volume = volumeInt
			}

			food.Volume = volume

			// 口味

			var tastyJson []Tasty

			var tasty = ""
			if len(v) == 19 {
				tasty = v[20]
			}

			tastyArr := strings.Split(tasty, ";")

			for _, tastyItem := range tastyArr {

				if strings.TrimSpace(tastyItem) != "" {

					tastyItemArr := strings.Split(tastyItem, ":")

					if len(tastyArr) > 1 {
						tastyKey := tastyItemArr[0]
						tastyValue := tastyItemArr[1]

						tastyJson = append(tastyJson, Tasty{
							AttrKey: tastyKey,
							AttrVal: strings.Split(tastyValue, ","),
						})

					}
				}
			}

			tastyStr, _ := json.Marshal(tastyJson)

			if len(tastyJson) > 0 {
				food.UseTasty = 1
				food.Tasty = string(tastyStr)
			}

			// 缩略图不存在
			if food.Thumbnail == "" {

				filePath, err := new(saasModel.Asset).SyncUpload(mid, v[1])

				if err == nil {
					food.Thumbnail = filePath
					/*alipayMaterialId := ""
					if food.Thumbnail != filePath || food.AlipayMaterialId == "" {

						if alipayExist && alipay.(bool) {
							// 上传缩略图到阿里支付宝
							file := util.GetAbsPath(thumbnail)
							bizContent := make(map[string]string, 0)
							fileResult, err := new(merchant.File).Upload(bizContent, file)
							if err != nil {
								rest.rc.Error(c, err.Error(), nil)
								return
							}
							alipayMaterialId = fileResult.Response.MaterialId
						}
					}*/
				}

			}

			if v[10] == "启用" {
				food.UseSku = 1
			}

			if tx.RowsAffected == 0 {
				food.CreateAt = time.Now().Unix()
				cmf.NewDb().Create(&food)
			} else {
				food.UpdateAt = time.Now().Unix()
				cmf.NewDb().Save(&food)
			}

			// 规格更新

			if v[10] == "启用" {

				name := strings.TrimSpace(v[11])
				// 获取当前键是否存在
				attrKey := model.FoodAttrKey{
					Name: name,
				}

				result := cmf.NewDb().Where("name = ?", name).First(&attrKey)
				if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
					fmt.Println("result.Error", result.Error.Error())
				}

				if result.RowsAffected == 0 {
					cmf.NewDb().Create(&attrKey)
				}

				// 获取规格key
				attrVal := strings.TrimSpace(v[12])

				attrValue := model.FoodAttrValue{
					AttrId:    attrKey.AttrId,
					AttrValue: attrVal,
				}

				// 获取规格值id
				attrValue, err = attrValue.AddAttrValue()
				if err != nil {
					fmt.Println("AddAttrValue",attrValue)
				}

				// 获取键值和商品的关联信息
				attrPost := model.FoodAttrPost{
					FoodId:      food.Id,
					AttrValueId: attrValue.AttrValueId,
				}

				attrPost, err = attrPost.AddAttrPost()
				if err != nil {
					fmt.Println("AddAttrPost err:",err.Error())
				}

				// 获取规格唯一对应的键值id,多个用|分隔
				attrPostId := strconv.Itoa(attrPost.AttrPostId)

				code := strings.TrimSpace(v[13])

				fmt.Println("sku-name",v[0])

				fmt.Println("sku-id", food.Id)

				sku := model.FoodSku{
					AttrPost:         attrPostId,
					FoodId:           food.Id,
					AttrValue:        attrVal,
					Code:             code,
					Weight:           weight,
					Inventory:        inventory,
					DefaultInventory: inventory,
					MemberPrice:      memberPrice,
					UseMember:        0,
					OriginalPrice:    originalPrice,
					Price:            price,
					Volume:           volume,
					Remark:           attrValue.AttrValue,
				}

				foodInventory += inventory

				if foodInventory < -1 {
					foodInventory = -1
				}

				_, err := sku.FirstOrSave()
				if err != nil {
					fmt.Println("FirstOrSave err", err.Error())
				}

			}

		}

	}
	wg.Done()
	}()

	wg.Wait()
}
