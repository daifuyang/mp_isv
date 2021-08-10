/**
** @创建时间: 2020/12/31 2:45 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/nsqPlugin/Producer"
	"github.com/gin-gonic/gin"
	cmfData "github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
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
	Pattern    int    `gorm:"type:tinyint(3);comment:打印模式（0：全部，1：一菜一单）;default:0;not null" json:"pattern"`
	Count      int    `gorm:"type:int(11);comment:打印联数;default:1;not null" json:"count"`
	Sn         string `gorm:"type:varchar(20);comment:设备SN号;not null" json:"sn"`
	Key        string `gorm:"type:varchar(20);comment:设备Key;not null" json:"key"`
	CreateAt   int64  `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt   int64  `gorm:"type:bigint(20)" json:"update_at"`
	DeleteAt   int64  `gorm:"type:bigint(20)" json:"delete_at"`
	CreateTime string `gorm:"-" json:"create_time"`
	UpdateTime string `gorm:"-" json:"update_time"`
	paginate   cmfModel.Paginate
	Db         *gorm.DB `gorm:"-" json:"-"`
}

func (model *Printer) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}

// 获取打印机列表
func (model *Printer) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	db, err := util.NewDb(c)
	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	var printer []Printer
	db.Where(queryStr, queryArgs...).Find(&printer).Count(&total)
	tx := db.Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&printer)

	for k, v := range printer {
		printer[k].CreateTime = time.Unix(v.CreateAt, 0).Format(cmfData.TimeLayout)
		printer[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(cmfData.TimeLayout)
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

	db := model.Db

	queryStr := strings.Join(query, " AND ")
	printer := Printer{}
	tx := db.Where(queryStr, queryArgs...).First(&printer)

	if tx.Error != nil {
		return Printer{}, tx.Error
	}

	printer.CreateTime = time.Unix(printer.CreateAt, 0).Format(cmfData.TimeLayout)
	printer.UpdateTime = time.Unix(printer.UpdateAt, 0).Format(cmfData.TimeLayout)

	return printer, nil
}

// 添加更新打印机
func (model *Printer) Save() (Printer, error) {

	id := model.Id
	mid := model.Mid

	db := model.Db

	query := []string{"id = ? AND mid = ?"}
	queryArgs := []interface{}{id, mid}

	printerModel := Printer{
		Db: db,
	}

	tempPrinter, err := printerModel.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return Printer{}, err
	}

	exist, err := printerModel.Show([]string{"`sn` = ? AND `key` = ? AND mid = ?"}, []interface{}{model.Sn, model.Key, mid})

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return Printer{}, err
	}

	printer := *model

	if tempPrinter.Id == 0 {
		if exist.Id > 0 {
			return Printer{}, errors.New("该打印机已存在！")
		}
		tx := db.Create(&printer)
		if tx.Error != nil {
			return Printer{}, tx.Error
		}
	} else {

		printer.Id = tempPrinter.Id
		if exist.Id > 0 {
			printer.DeleteAt = 0
		}

		tx := db.Save(&printer)
		if tx.Error != nil {
			return Printer{}, tx.Error
		}

	}

	return printer, nil

}

func (model *Printer) Send(mid int, foId int) error {

	var query = []string{"fo.mid = ?", " fo.id = ? "}
	var queryArgs = []interface{}{mid, foId, "TRADE_SUCCESS"}

	db := model.Db
	fo := FoodOrder{
		Db: db,
	}

	data, err := fo.ShowByStore(query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return err
	}

	if data.Id == 0 {
		return errors.New("订单不存在")
	}

	var fod []FoodOrderDetail
	tx := db.Where("order_id = ?", data.OrderId).Find(&fod)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return tx.Error
	}

	var printOrder = make([]map[string]string, 0)

	for _, v := range fod {

		// 打印订单详情信息
		var printOrderItem = make(map[string]string, 0)

		title := v.FoodName
		if v.SkuDetail != "" {
			title += "-" + v.SkuDetail
		}

		printOrderItem["title"] = title
		printOrderItem["count"] = strconv.Itoa(v.Count)
		printOrderItem["food_id"] = strconv.Itoa(v.FoodId)
		printOrderItem["total"] = strconv.FormatFloat(v.Total, 'f', -1, 64)
		printOrder = append(printOrder, printOrderItem)

	}

	// 打印机打印订单
	appointmentTime := time.Unix(data.AppointmentAt, 0).Format(cmfData.TimeLayout)

	foodOrder := FoodOrder{
		Db: db,
	}

	// 获取门店打印机状态
	_, err = foodOrder.SendPrinter(data, printOrder, data.StoreName, appointmentTime, true)
	if err != nil {
		return err
	}

	return nil
}

func (model *Printer) NsqProducer(mid int, targetId int) {
	p, err := new(Producer.Producer).NewProducer()
	if err == nil {
		database, err := util.Database(model.Db)
		if err == nil {
			messageJson := Producer.MessageJson{
				Database: database,
				Type:     "printer",
				TargetId: targetId,
				Mid:      mid,
			}

			body, _ := json.Marshal(&messageJson)

			p.Publish("mpIsv", body)
		}
	}
}
