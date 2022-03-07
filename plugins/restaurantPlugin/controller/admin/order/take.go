/**
** @创建时间: 2021/7/12 10:41 下午
** @作者　　: return
** @描述　　: 取餐叫号
 */
package order

import (
	appUtil "gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	cmfData "github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	"strconv"
	"time"
)

type Take struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 叫号通知
 * @Date 2021/7/12 22:46:54
 * @Param
 * @return
 **/

func (rest *Take) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

	queue := rewrite.Id

	db, err := appUtil.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	foodOrder := model.FoodOrder{
		Db: db,
	}

	tx := db.Debug().Where("mid = ? AND store_id = ? AND queue_no = ? AND order_status = ?", mid, storeId, queue, "TRADE_SUCCESS").Order("id desc").First(&foodOrder)

	if tx.Error != nil {
		rest.rc.Error(c, "该取餐号不存在！", nil)
		return
	}

	// 消息推送
	createTime := time.Unix(foodOrder.CreateAt, 0).Format(cmfData.TimeLayout)

	orderRemark := ""

	if foodOrder.QueueNo != "" {
		orderRemark = foodOrder.QueueNo
	}

	mpType := "alipay"

	if foodOrder.FormId == "" {
		mpType = "wechat"
	}

	userMpType := ""

	if mpType == "wechat" {
		userMpType = "wechat-mp"
	}

	if mpType == "alipay" {
		userMpType = "alipay-mp"
	}

	// 获取当前会员信息
	user := model.User{
		Db: db,
	}

	u, err := user.GetMpUser(foodOrder.UserId, userMpType)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	store := model.Store{
		Db: db,
	}

	data, err := store.Show([]string{"mid = ?", "id = ?"}, []interface{}{mid, foodOrder.StoreId})
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	wxSubscribe := model.Subscribe{
		Id:         foodOrder.Id,
		Mid:        foodOrder.Mid,
		Type:       mpType,
		OpenId:     u.OpenId,
		StoreName:  data.StoreName,
		OrderId:    foodOrder.OrderId,
		Fee:        strconv.FormatFloat(foodOrder.TotalAmount, 'f', -1, 64),
		CreateTime: createTime,
		Remark:     orderRemark,
		Db:         db,
	}

	if mpType == "wechat" && akExist {
		wxSubscribe.AccessToken = authorizerAccessToken.(string)
	}

	if mpType == "alipay" {
		wxSubscribe.AccessToken = foodOrder.FormId
	}

	err = wxSubscribe.TradeTake()
	if err != nil {
		rest.rc.Error(c, "叫餐通知失败！", err.Error())
		return
	}

	rest.rc.Success(c, "叫餐通知成功！", foodOrder)

}
