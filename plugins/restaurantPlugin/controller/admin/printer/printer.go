/**
** @创建时间: 2020/12/31 2:44 下午
** @作者　　: return
** @描述　　:
 */
package printer

import (
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/feieSdk/base"
	"gorm.io/gorm"
	"strings"
	"time"
)

// 打印机
type Printer struct {
	rc controller.Rest
}

// @Summary 入口文件
// @Description 预览接口可访问
// @Tags index
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData "获取成功！"
// @Router / [get]
func (rest *Printer) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"mid = ?"}
	var queryArgs = []interface{}{mid}

	data, err := new(model.Printer).Index(c, query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), data)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Printer) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	data, err := new(model.Printer).Show([]string{"id = ? AND mid = ?"}, []interface{}{rewrite.Id, mid})

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), data)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Printer) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	rest.Save(rewrite.Id, c)
}

func (rest *Printer) Store(c *gin.Context) {
	rest.Save(0, c)
}

func (rest *Printer) Save(id int, c *gin.Context) {

	mid, _ := c.Get("mid")

	var form struct {
		StoreId int    `json:"store_id"`
		Name    string `json:"name"`
		Type    string `json:"type"`
		Brand   string `json:"brand"`
		Sn      string `json:"sn"`
		Key     string `json:"key"`
		Status  int    `json:"status"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	storeId := form.StoreId

	if storeId == 0 {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	name := form.Name
	if name == "" {
		rest.rc.Error(c, "门店名称不能为空！", nil)
		return
	}

	t := form.Type

	switch t {
	case "cloud":
		t = "cloud"
	default:
		rest.rc.Error(c, "打印机类型错误！", nil)
		return
	}

	sn := form.Sn
	if sn == "" {
		rest.rc.Error(c, "sn不能为空！", nil)
		return
	}

	key := form.Key
	if key == "" {
		rest.rc.Error(c, "key不能为空！", nil)
		return
	}

	status := form.Status
	if status == 1 {
		status = 1
	} else {
		status = 0
	}

	printer := model.Printer{}

	if id > 0 {
		data, err := new(model.Printer).Show([]string{"id = ? AND mid = ?"}, []interface{}{id, mid})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), data)
			return
		}
		printer = data
	}

	//验证打印机是否存在
	brand := form.Brand
	switch brand {
	case "feie":
		brand = "feie"

		// 删除原来的打印关系
		new(base.Printer).Delete(sn)

		snList := sn + "#" + key
		feieRes := new(base.Printer).Add(snList)

		if len(feieRes.Data.Ok) == 0 {
			rest.rc.Error(c, strings.Join(feieRes.Data.No, ""), nil)
			fmt.Println(feieRes.Data)
			return
		}

	default:
		rest.rc.Error(c, "打印机品牌错误！", nil)
		return
	}

	printer.Mid = mid.(int)
	printer.StoreId = storeId
	printer.Name = name
	printer.Type = t
	printer.Brand = brand
	printer.Sn = sn
	printer.Key = key
	printer.CreateAt = time.Now().Unix()
	printer.UpdateAt = time.Now().Unix()
	result, err := printer.Save()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	msg := "添加成功！"
	if id > 0 {
		msg = "更新成功！"
	}

	rest.rc.Success(c, msg, result)

}

func (rest *Printer) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	rest.rc.Success(c, "操作成功Delete", nil)
}
