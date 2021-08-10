/**
** @创建时间: 2021/2/22 6:28 下午
** @作者　　: return
** @描述　　:店铺异步通知
 */
package getway

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"net/url"
	"strings"
)

type Merchant struct{}

func (rest *Merchant) Passed(c *gin.Context, param url.Values) error {

	bizContent := strings.Join(param["biz_content"], "")
	reason := strings.Join(param["reason"], "")

	var biz struct {
		ShopId   string `json:"shop_id"`
		ShopName string `json:"shop_name"`
		OrderId  string `json:"order_id"`
		StoreId  string `json:"store_id"`
	}

	_ = json.Unmarshal([]byte(bizContent), &biz)

	db, err := util.NewDb(c)
	if err != nil {
		return err
	}

	store := model.Store{
		Db: db,
	}
	tx := db.Where("id = ?", biz.StoreId).First(&store)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return tx.Error
	}

	// 更新门店状态
	tx = db.Where("id = ?", biz.StoreId).Updates(map[string]string{"audit_status": "passed", "reason": reason})
	if tx.Error != nil {
		return tx.Error
	}

	return nil

}

func (rest *Merchant) Rejected(c *gin.Context, param url.Values) error {

	bizContent := strings.Join(param["biz_content"], "")
	reason := strings.Join(param["reason"], "")

	var biz struct {
		ShopId   string `json:"shop_id"`
		ShopName string `json:"shop_name"`
		OrderId  string `json:"order_id"`
		StoreId  string `json:"store_id"`
	}

	_ = json.Unmarshal([]byte(bizContent), &biz)

	db, err := util.NewDb(c)
	if err != nil {
		return err
	}

	store := model.Store{
		Db: db,
	}
	tx := db.Where("id = ?", biz.StoreId).First(&store)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return tx.Error
	}

	// 更新门店状态
	tx = db.Where("id = ?", biz.StoreId).Updates(map[string]string{"audit_status": "passed", "reason": reason})
	if tx.Error != nil {
		return tx.Error
	}

	return nil

}
