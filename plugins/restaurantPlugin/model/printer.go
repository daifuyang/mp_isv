/**
** @创建时间: 2020/12/31 2:45 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type Printer struct {
	Id         int    `json:"id"`
	Mid        int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId    int    `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	Name       string `gorm:"type:varchar(20);comment:设备名称;not null" json:"name"`
	Type       string `gorm:"type:varchar(20);comment:打印机类型（cloud：云打印机）;not null" json:"type"`
	Brand      string `gorm:"type:varchar(20);comment:设备品牌（feie：品牌）;not null" json:"brand"`
	Sn         string `gorm:"type:varchar(20);comment:设备SN号;not null" json:"sn"`
	Key        string `gorm:"type:varchar(20);comment:设备Key;not null" json:"key"`
	CreateAt   int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt   int64  `gorm:"type:int(11)" json:"update_at"`
	DeleteAt   int64  `gorm:"type:int(11)" json:"delete_at"`
	CreateTime string `gorm:"-" json:"create_time"`
	UpdateTime string `gorm:"-" json:"update_time"`
	paginate   cmfModel.Paginate
}

func (model *Printer) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
}

// 获取打印机列表
func (model *Printer) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	var printer []Printer
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&printer).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&printer)

	for k, v := range printer {
		printer[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		printer[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(data.TimeLayout)
	}

	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: printer, Current: current, PageSize: pageSize, Total: total}
	if len(printer) == 0 {
		paginate.Data = make([]Printer, 0)
	}

	return paginate, nil

}

// 查看单个打印机配置
func (model *Printer) Show(query []string, queryArgs []interface{}) (Printer, error) {

	queryStr := strings.Join(query, " AND ")
	printer := Printer{}
	tx := cmf.NewDb().Where(queryStr, queryArgs...).First(&printer)

	if tx.Error != nil {
		return Printer{}, tx.Error
	}

	printer.CreateTime = time.Unix(printer.CreateAt, 0).Format(data.TimeLayout)
	printer.UpdateTime = time.Unix(printer.UpdateAt, 0).Format(data.TimeLayout)

	return printer, nil
}

// 添加更新打印机
func (model *Printer) Save() (Printer, error) {

	id := model.Id
	mid := model.Mid

	query := []string{"id = ? AND mid = ?"}
	queryArgs := []interface{}{id,mid}

	tempPrinter, err := new(Printer).Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return Printer{}, err
	}

	exist, err := new(Printer).Show([]string{"`sn` = ? AND `key` = ? AND mid = ?"}, []interface{}{model.Sn, model.Key,mid})

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return Printer{}, err
	}

	printer := *model

	if tempPrinter.Id == 0 {
		if exist.Id > 0 {
			return Printer{}, errors.New("该打印机已存在！")
		}
		tx := cmf.NewDb().Create(&printer)
		if tx.Error != nil {
			return Printer{}, tx.Error
		}
	} else {

		printer.Id = tempPrinter.Id
		if exist.Id > 0 {
			printer.DeleteAt = 0
		}

		tx := cmf.NewDb().Save(&printer)
		if tx.Error != nil {
			return Printer{}, tx.Error
		}

	}

	return printer, nil

}
