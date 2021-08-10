/**
** @创建时间: 2020/11/4 11:46 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"fmt"
	"gincmf/app/model"
	"github.com/360EntSecGroup-Skylar/excelize/v2"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
	"testing"
)

func Test_Region(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	cmf.Db().Migrator().DropTable(&model.Region{})
	cmf.Db().AutoMigrate(&model.Region{})

	f, err := os.Open("../../data/region.sql")
	if err != nil {
		fmt.Println("err", err)
	}
	bytes, _ := ioutil.ReadAll(f)
	result := string(bytes)
	result = strings.ReplaceAll(result, "{prefix}", "cmf_")

	sqlArr := strings.Split(result, ";")

	// fmt.Println("sqlArr", sqlArr)

	for _, sql := range sqlArr {
		cmf.Db().Debug().Exec(sql)
	}

}

func Test_importRegion(t *testing.T) {
	cmf.Initialize("../../data/conf/config.json")

	cmf.Db().Migrator().DropTable(&model.Region{})

	cmf.Db().AutoMigrate(&model.Region{})

	f, err := excelize.OpenFile("region.xlsx")
	if err != nil {
		fmt.Println(err)
		return
	}

	rowKey := map[string]int{"name": 5, "code": 2, "parent": 6, "type": 8}

	// 获取 Sheet1 上所有单元格
	rows, err := f.GetRows("sheet1")
	for key, row := range rows {

		if key > 7 {

			name := row[rowKey["name"]]

			t := row[rowKey["type"]]
			tInt, _ := strconv.Atoi(t)

			code := row[rowKey["code"]]
			codeInt, _ := strconv.Atoi(code)

			parent := row[rowKey["parent"]]
			parentInt, _ := strconv.Atoi(parent)

			if parentInt == 1 {
				parentInt = 0
			}

			if tInt - 1 > 0 {
				tInt = tInt - 1

				cmf.Db().Create(&model.Region{
					AreaId:   codeInt,
					AreaName: name,
					AreaType: tInt,
					ParentId: parentInt,
				})

			}

		}

	}

}
