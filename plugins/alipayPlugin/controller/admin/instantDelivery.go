/**
** @创建时间: 2021/8/26 10:52 下午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"fmt"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/logistics"
	"github.com/gincmf/cmf/controller"
	"time"
)

type InstantDelivery struct {
	rc controller.Rest
}

func (rest *InstantDelivery) OpenDelivery(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	deliveryId := rewrite.Id

	deliveryName := ""
	switch deliveryId {
	case "DADA":
		deliveryName = "达达"
	default:

	}

	fmt.Println("deliveryName", deliveryName)

	bizContent := make(map[string]interface{}, 0)
	bizContent["out_biz_no"] = time.Now().Unix()
	bizContent["logistics_codes"] = []string{"DADA"}
	result := new(logistics.InstantDelivery).AccountCreate(bizContent)

	if result.Code != "10000" {
		rest.rc.Error(c, result.SubMsg, nil)
		return
	}

	immediateDelivery := resModel.ImmediateDelivery{
		Type:         1,
		DeliveryId:   deliveryId,
		DeliveryName: deliveryName,
		AuditResult:  0,
	}
	tx := db.Where("delivery_id = ? and type = 1", deliveryId).First(&immediateDelivery)

	if tx.RowsAffected == 0 {
		db.Create(&immediateDelivery)
	} else {
		db.Save(&immediateDelivery)
	}

	rest.rc.Success(c, result.Msg, result.LogisticsAccountStatus)

}
