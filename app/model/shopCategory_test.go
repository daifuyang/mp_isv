/**
** @创建时间: 2020/12/20 1:20 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"fmt"
	"github.com/360EntSecGroup-Skylar/excelize/v2"
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

func TestShopCategory_AutoMigrate(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	f, err := excelize.OpenFile("/Users/return/Downloads/ShopCategory.xlsx")
	if err != nil {
		fmt.Println(err)
		return
	}

	// Get all the rows in the Sheet1.
	rows, err := f.GetRows("支付宝门店类目")
	for pk, row := range rows {
		if row[0] == "超市便利店" || row[0] == "美食" {

			top := ShopCategory{}

			second := ShopCategory{
				CategoryType: 1,
			}

			third := ShopCategory{
				CategoryType: 2,
			}

			for k, colCell := range row {
				if pk > 1 {

				}

				//顶级
				if k == 0 {
					top.CategoryName = colCell
				}
				if k == 3 {
					top.CategoryId = colCell
					second.TopId = colCell
					second.ParentId = colCell

					third.TopId = colCell
				}

				// 二级
				if k == 1 {
					second.CategoryName = colCell
				}

				if k == 4 {
					second.CategoryId = colCell
					third.ParentId = colCell
				}

				// 三级

				if k == 2 {
					third.CategoryName = colCell
				}

				if k == 5 {
					third.CategoryId = colCell
				}

			}

			// cmf.Db().Debug().FirstOrCreate(&top)
			// cmf.Db().Debug().Updates(&second)
			cmf.Db().Debug().Updates(&third)
			fmt.Println()
		}
	}

}
