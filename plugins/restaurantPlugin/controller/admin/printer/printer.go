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
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/feieSdk/base"
	xpyunYun "github.com/gincmf/xpyunSdk/base"
	xpyunYunModel "github.com/gincmf/xpyunSdk/model"
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
		Pattern int    `json:"pattern"`
		Count   int    `json:"count"`
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
	if t == "feie" && key == "" {
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

	case "xprinter":
		brand = "xprinter"

		// 删除原来的打印关系
		new(xpyunYun.Printer).Delete(sn)

		// 添加打印机
		snList := []*xpyunYunModel.AddPrinterRequestItem{
			{
				Sn:   sn,
				Name: name,
			},
		}
		xpRes := new(xpyunYun.Printer).Add(snList)

		if xpRes.Content.Code != 0 {
			rest.rc.Error(c, xpRes.Content.Msg, nil)
			fmt.Println(xpRes.Content)
			return
		}

	default:
		rest.rc.Error(c, "打印机品牌错误！", nil)
		return
	}

	count := form.Count
	if count == 0 {
		count = 1
	}
	printer.Mid = mid.(int)
	printer.StoreId = storeId
	printer.Name = name
	printer.Type = t
	printer.Brand = brand
	printer.Pattern = form.Pattern
	printer.Count = count
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

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	id := rewrite.Id

	printer := model.Printer{}

	var err error

	if id > 0 {
		printer, err = new(model.Printer).Show([]string{"id = ? AND mid = ?"}, []interface{}{id, mid})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), printer)
			return
		}
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, id).Delete(&model.Printer{})

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if printer.Brand == "feie" {
		new(base.Printer).Delete(printer.Sn)
	}

	if printer.Brand == "xprinter" {
		new(xpyunYun.Printer).Delete(printer.Sn)
	}

	rest.rc.Success(c, "操作成功", nil)
}
