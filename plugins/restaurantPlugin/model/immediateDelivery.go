/**
** @创建时间: 2021/6/5 9:18 上午
** @作者　　: return
** @描述　　: 即时配送
 */
package model

import (
	"fmt"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfData "github.com/gincmf/cmf/data"
	"time"
)

type ImmediateDelivery struct {
	Id           int    `json:"id"`
	DeliveryId   string `gorm:"type:varchar(20);comment:配送公司Id" json:"delivery_id"`
	DeliveryName string `gorm:"type:varchar(32);comment:配送公司名称" json:"delivery_name"`
	Shopid       string `gorm:"type:varchar(64);comment:配送公司开发平台app_key" json:"shop_id"`
	AppKey       string `gorm:"type:varchar(64);comment:配送公司开发平台app_key" json:"app_key"`
	AppSecret    string `gorm:"type:varchar(128);comment:配送公司开发平台app_secret" json:"app_secret"`
	AuditResult  int    `gorm:"type:tinyint(3);comment:审核状态;default:0" json:"audit_result"`
	IsOpen       int    `gorm:"type:tinyint(3);comment:是否开通物流权限;default:0" json:"is_open"`
	Status       int    `gorm:"type:tinyint(3);comment:状态（启用，停用）;default:0" json:"status"`
	IsMain       int    `gorm:"type:tinyint(3);comment:主配送公司;default:0" json:"is_main"`
	CreateAt     int64  `gorm:"type:bigint(20)" json:"create_at"`
	CreateTime   string `gorm:"-" json:"create_time"`
}

func (model *ImmediateDelivery) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&ImmediateDelivery{})
}

type DeliveryGoods struct {
	GoodCount int     `json:"good_count"`
	GoodName  string  `json:"good_name"`
	GoodPrice float64 `json:"good_price"`
	GoodUnit  string  `json:"good_unit"`
}

type Cargo struct {
	GoodsValue       int             `json:"goods_value"`
	GoodsWeight      float64         `json:"goods_weight"`
	GoodsDetail      []DeliveryGoods `json:"goods_detail"`
	CargoFirstClass  string          `json:"cargo_first_class"`
	CargoSecondClass string          `json:"cargo_second_class"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 自动下配送订单
 * @Date 2021/6/15 13:52:7
 * @Param
 * @return
 **/
func (model *ImmediateDelivery) CanUseTime(dt []deliveryTimes) bool {
	now := time.Now()
	today := now.Format("2006-01-02")
	for _, v := range dt {

		startTime, _ := time.ParseInLocation(cmfData.TimeLayout, today+" "+v.StartTime+":00", time.Local)
		endTime, _ := time.ParseInLocation(cmfData.TimeLayout, today+" "+v.EndTime+":59", time.Local)

		if now.After(startTime) && now.Before(endTime) {
			fmt.Println("hit", "击中")
			return true
		}

	}
	return true
}
