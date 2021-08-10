/**
** @创建时间: 2021/6/12 4:08 下午
** @作者　　: return
** @描述　　:
 */
package delivery

import (
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"time"
)

type ImmediateDelivery struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取绑定的三方配送列表
 * @Date 2021/6/12 16:17:56
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var immediateDelivery []model.ImmediateDelivery

	tx := db.Find(&immediateDelivery)

	for k, _ := range immediateDelivery {
		immediateDelivery[k].AppSecret = ""
	}

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", immediateDelivery)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看三方配送详情
 * @Date 2021/6/12 16:18:17
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}
	rest.rc.Success(c, "操作成功show", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 修改单个三方配送的详情信息
 * @Date 2021/6/12 16:18:30
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	var form struct {
		Field string `json:"field"`
		Value int    `json:"value"`
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

	immediateDelivery := model.ImmediateDelivery{}

	tx := db.Where("id = ?", rewrite.Id).First(&immediateDelivery)
	if tx.Error != nil {

		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "同城公司不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if form.Field == "status" {
		immediateDelivery.Status = form.Value
	}

	if form.Field == "is_main" {
		// 修改全部配送状态
		tx = db.Model(&immediateDelivery).Where("is_main", 1).Update("is_main", 0)
		immediateDelivery.IsMain = form.Value
	}

	tx = db.Save(&immediateDelivery)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新状态成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增三方配送信息
 * @Date 2021/6/12 16:18:49
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Store(c *gin.Context) {
	rest.Handle(c)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增编辑
 * @Date 2021/6/12 21:21:49
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Handle(c *gin.Context) {

	var form struct {
		DeliveryId string `json:"delivery_id"`
		AppKey     string `json:"shop_id"`
		AppSecret  string `json:"app_secret"`
		Remark     string `json:"remark"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	immediateDelivery := model.ImmediateDelivery{
		Shopid:    form.AppKey,
		AppKey:    form.AppKey,
		AppSecret: form.AppSecret,
		CreateAt:  time.Now().Unix(),
	}
	msg := "操作成功"

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	tx := db.Where("delivery_id = ?", form.DeliveryId).First(&immediateDelivery)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected > 0 {
		immediateDelivery.Shopid = form.AppKey
		immediateDelivery.AppKey = form.AppKey
		immediateDelivery.AppSecret = form.AppSecret
		immediateDelivery.Status = 1
		tx = db.Save(&immediateDelivery)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
	}

	rest.rc.Success(c, msg, nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个三方配送信息
 * @Date 2021/6/12 16:19:5
 * @Param
 * @return
 **/
func (rest *ImmediateDelivery) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}
