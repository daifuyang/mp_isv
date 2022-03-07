/**
** @创建时间: 2021/8/28 9:44 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/logistics"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

// 配送商家门店关联信息
type ImmediateDeliveryPost struct {
	Id         int      `json:"id"`
	OutBizNo   string   `gorm:"type:string(32);comment:外部业务编号" json:"out_biz_no"`
	DeliveryId string   `gorm:"type:varchar(20);comment:配送公司id" json:"delivery_id"`
	Channel    string   `gorm:"type:varchar(20);comment:渠道" json:"channel"`
	StoreId    int      `gorm:"type:int(11);comment:门店id;not null;comment:门店id" json:"store_id"`
	Status     string   `gorm:"type:varchar(32);comment:状态" json:"status"`
	AuditDesc  string   `gorm:"type:varchar(32);comment:审核说明" json:"audit_desc"`
	Db         *gorm.DB `gorm:"-" json:"-"`
}

func (model *ImmediateDeliveryPost) AutoMigrate() {
	model.Db.AutoMigrate(&ImmediateDeliveryPost{})
}

// 查询全部配送列表
func (model *ImmediateDeliveryPost) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	db := model.Db

	// 查询全部的配送机构下关联的门店
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix

	var total int64 = 0

	tx := db.Table(prefix+"immediate_delivery id").
		Joins("INNER JOIN "+prefix+"immediate_delivery_post idp ON id.delivery_id = idp.delivery_id").
		Joins("INNER JOIN "+prefix+"store s ON s.id = idp.store_id").
		Where(queryStr, queryArgs...).Count(&total)

	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	var result []Store
	tx = db.Debug().Table(prefix+"immediate_delivery id").Select("s.*").
		Joins("INNER JOIN "+prefix+"immediate_delivery_post idp ON id.delivery_id = idp.delivery_id").
		Joins("INNER JOIN "+prefix+"store s ON s.id = idp.store_id").
		Where(queryStr, queryArgs...).
		Limit(pageSize).Offset((current - 1) * pageSize).
		Scan(&result)

	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: result, Current: current, PageSize: pageSize, Total: total}
	if len(result) == 0 {
		paginate.Data = make([]FoodOrder, 0)
	}

	return paginate, nil

}

// 新创建门店即时配送
func (model *ImmediateDeliveryPost) Add() error {

	db := model.Db

	var store Store

	storeId := model.StoreId

	tx := db.Where("id = ?", storeId).First(&store)

	if tx.Error != nil {
		return tx.Error
	}

	outBizNo := time.Now().Unix()
	bizContent := make(map[string]interface{}, 0)
	bizContent["out_biz_no"] = outBizNo
	bizContent["shop_no"] = store.StoreNumber
	bizContent["shop_name"] = store.StoreName
	bizContent["shop_category"] = store.ShopCategory
	bizContent["enterprise_province"] = store.Province
	bizContent["enterprise_city"] = store.City
	bizContent["enterprise_district"] = store.District
	bizContent["detail_address"] = store.Address
	bizContent["contact_name"] = store.ContactPerson
	bizContent["phone"] = store.Phone
	bizContent["longitude"] = store.Longitude
	bizContent["latitude"] = store.Latitude
	result := new(logistics.MerchantShop).Create(bizContent)

	if result.Code != "10000" {
		return errors.New(result.SubMsg)
	}

	idp := ImmediateDeliveryPost{
		OutBizNo:   strconv.FormatInt(outBizNo, 10),
		DeliveryId: model.DeliveryId,
		Channel:    model.Channel,
		StoreId:    storeId,
		Status:     result.LogisticsShopStatus[0].Status,
		AuditDesc:  result.LogisticsShopStatus[0].AuditDesc,
	}

	tx = db.Create(&idp)

	if tx.Error != nil {
		return tx.Error
	}

	return nil

}
