/**
** @创建时间: 2021/8/28 4:08 下午
** @作者　　: return
** @描述　　:
 */
package delivery

import (
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

// 阿里门店配送关系
type Alipay struct {
	rc controller.Rest
}

// 列出门店列表
func (rest *Alipay) Get(c *gin.Context) {
	var query []string
	var queryArgs []interface{}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	idp := model.ImmediateDeliveryPost{
		Db: db,
	}
	data, err := idp.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Alipay) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

func (rest *Alipay) Store(c *gin.Context) {

	var form struct {
		DeliveryId string `json:"delivery_id"`
		Channel    string `json:"channel"`
		StoreId    int    `json:"store_id"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	idp := model.ImmediateDeliveryPost{
		Db:         db,
		DeliveryId: form.DeliveryId,
		Channel:    form.Channel,
		StoreId:    form.StoreId,
	}

	// 添加即使配送门店
	err = idp.Add()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "添加成功", nil)

}

func (rest *Alipay) Edit(c *gin.Context) {
	rest.rc.Success(c, "操作成功Edit", nil)
}

func (rest *Alipay) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
