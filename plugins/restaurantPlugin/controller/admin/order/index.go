/**
** @创建时间: 2020/12/2 2:51 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"errors"
	"gincmf/app/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gorilla/websocket"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Index struct {
	rc controller.RestController
}

// 定义链接客户端
type Client struct {
	conn   *websocket.Conn
	userId int
	isConn bool
}

var clientsMap = make(map[Client]bool)

/**
* @Author return <1140444693@qq.com>
* @Description 查看列表
* @Date 2020/12/2 14:53:35
* @Param store_id int（所属门店）
  @Param order_type int（订单类型）
  @Param order_status string（订单类型）
* @return
**/
func (rest *Index) Index(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"fo.mid = ?"}
	var queryArgs = []interface{}{mid}

	// 订单号
	orderId := c.Query("order_id")
	if orderId != "" {
		query = append(query, "fo.order_id = ?")
		queryArgs = append(queryArgs, orderId)
	}

	// 门店id
	storeId := c.Query("store_id")
	if storeId != "" {
		query = append(query, "fo.store_id = ?")
		queryArgs = append(queryArgs, storeId)
	}

	// 订单场景
	scene := c.Query("scene")
	if scene == "eatin" {
		query = append(query, "fo.order_type < ?")
		queryArgs = append(queryArgs, 4)
	}

	if scene == "takeout" {
		query = append(query, "fo.order_type = ?")
		queryArgs = append(queryArgs, 4)
	}

	// 订单类型
	/*orderType := c.Query("order_type")
	if orderType != "" {
		query = append(query, "fo.order_type = ?")
		queryArgs = append(queryArgs, orderType)
	}*/

	// 订单状态
	orderStatus := c.Query("order_status")
	if orderStatus != "" {
		query = append(query, "fo.order_status = ?")
		queryArgs = append(queryArgs, orderStatus)
	}

	order := resModel.FoodOrder{}
	data, err := order.IndexByStore(c, query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 后台商户主动确认完成订单
 * @Date 2020/12/5 21:42:43
 * @Param
 * @return
 **/

func (rest *Index) Confirm(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"mid = ?"}
	var queryArgs = []interface{}{mid}

	// 订单号
	orderId := c.PostForm("order_id")
	if orderId == "" {
		rest.rc.Error(c, "订单号不能为空！", nil)
		return
	}

	query = append(query, "order_id = ?")
	queryArgs = append(queryArgs, orderId)

	// 门店id
	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
	}
	query = append(query, "store_id = ?")
	queryArgs = append(queryArgs, storeId)

	order := resModel.FoodOrder{}
	err := order.Confirm(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "订单确认成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 用户申请退款
 * @Date 2020/12/5 22:17:6
 * @Param
 * @return
 **/

func (rest *Index) Cancel(c *gin.Context) {

	appId, _ := c.Get("app_id")

	mid, _ := c.Get("mid")

	var query = []string{"mid = ?"}
	var queryArgs = []interface{}{mid}

	// 订单号
	orderId := c.PostForm("order_id")
	if orderId == "" {
		rest.rc.Error(c, "订单号不能为空！", nil)
		return
	}

	query = append(query, "order_id = ?")
	queryArgs = append(queryArgs, orderId)

	// 门店id
	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
	}
	query = append(query, "store_id = ?")
	queryArgs = append(queryArgs, storeId)

	order := resModel.FoodOrder{}
	err := order.Cancel(query, queryArgs, appId.(string))
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "订单作废成功！", nil)

}

/*func (rest *Index) Order(w http.ResponseWriter, r *http.Request) {

	var upgrader = websocket.Upgrader{
		// 允许跨域
		CheckOrigin: func(r *http.Request) bool {
			return true
		},
	} // use default options

	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade:", err)
		c.Close()
		return
	}

	defer c.Close()
	var client = Client{
		conn: c,
	}

	for {

		mt, message, err := c.ReadMessage()
		if err != nil {
			log.Println("read:", err)
			c.Close()
		}
		var result struct {
			Mid         string `json:"mid"`
			Token       string `json:"token"`
			OrderId     string `json:"order_id"`
			StoreId     string `json:"store_id"`
			OrderType   string `json:"order_type"`
			OrderStatus string `json:"order_status"`
			Current     int    `json:"current"`
			PageSize    int    `json:"pageSize"`
		}

		json.Unmarshal([]byte(message), &result)

		// 验证token
		err = socket.ValidationBearerToken(result.Token)

		if err != nil {
			if err = c.WriteMessage(mt, []byte( rest.rc.JsonError(err.Error(), nil) )); err != nil {
				return
			}
			return
		}

		client.userId = socket.UserId

		if !clientsMap[client] {
			clientsMap[client] = true
		}

		mid := result.Mid
		if mid == "" {
			c.WriteMessage(mt, []byte( rest.rc.JsonError("mid不能为空！", nil) ))
			return
		}

		var query = []string{"fo.mid = ?"}
		var queryArgs = []interface{}{mid}
		// 订单号
		orderId := result.OrderId
		if orderId != "" {
			query = append(query, "fo.order_id = ?")
			queryArgs = append(queryArgs, orderId)
		}

		// 门店id
		storeId := result.StoreId
		if storeId != "" {
			query = append(query, "fo.store_id = ?")
			queryArgs = append(queryArgs, storeId)
		}

		// 订单类型
		orderType := result.OrderType
		if orderType != "" {
			query = append(query, "fo.order_type = ?")
			queryArgs = append(queryArgs, orderType)
		}

		// 订单状态
		orderStatus := result.OrderStatus
		if orderStatus != "" {
			query = append(query, "fo.order_status = ?")
			queryArgs = append(queryArgs, orderStatus)
		}

		current := 1
		if result.Current > 0 {
			current = result.Current
			if err != nil {
				cmfLog.Error(err.Error())
			}
		}

		// 默认分页
		pageSize := 10
		if result.PageSize > 0 {
			pageSize = result.PageSize
			if err != nil {
				cmfLog.Error(err.Error())
			}
		}

		order := resModel.FoodOrder{}

		data, err := order.ByStore(current, pageSize, query, queryArgs)
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			if err = c.WriteMessage(mt, []byte( rest.rc.JsonError(err.Error(), nil) )); err != nil {
				return
			}
		}

		res, _ := json.Marshal(data)

		err = c.WriteMessage(mt, []byte(res))
		if err != nil {
			delete(clientsMap, client)
			client.conn.Close()
			log.Println("write:", err)
			return
		}

	}
}
*/
/**
 * @Author return <1140444693@qq.com>
 * @Description // 查订单详情
 * @Date 2021/2/21 12:51:57
 * @Param
 * @return
 **/

func (rest *Index) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	var query = []string{"fo.mid = ? AND fo.id = ?"}
	var queryArgs = []interface{}{mid, rewrite.Id}

	data, err := new(resModel.FoodOrder).ShowByStore(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 申请退款
 * @Date 2021/3/11 16:2:23
 * @Param
 * @return
 **/

func (rest *Index) Refund(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	_, exist := c.Get("alipay_user_id")

	var query = []string{"fo.mid = ?", " fo.id = ? "}
	var queryArgs = []interface{}{mid, rewrite.Id, "TRADE_SUCCESS"}

	data, err := new(resModel.FoodOrder).ShowByStore(query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if data.Id == 0 {
		rest.rc.Error(c, "订单不存在", nil)
		return
	}

	if !(data.OrderStatus == "TRADE_SUCCESS" || data.OrderStatus == "TRADE_FINISHED") {
		rest.rc.Error(c, "订单状态不正确", nil)
		return
	}

	// 如果是余额支付
	if data.PayType == "balance" {

		rLog := model.RechargeLog{}
		tx := cmf.NewDb().Where("target_id = ? AND target_type = ?", data.Id, 0).First(&rLog)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		userData, err := new(model.User).Show([]string{"id = ?", "mid = ?", "user_type = 0", "delete_at = 0"}, []interface{}{data.UserId, mid})
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		balance := userData.Balance

		reFee, err := decimal.NewFromString(rLog.Fee)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		balanceDecimal := decimal.NewFromFloat(balance).Add(reFee)
		balance, _ = balanceDecimal.Round(2).Float64()

		tx = cmf.NewDb().Model(&resModel.User{}).Where("id = ?", userData.Id).Updates(map[string]interface{}{
			"balance": balance,
		})

		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, err.Error(), nil)
		}

		balanceStr := strconv.FormatFloat(balance, 'f', -1, 64)

		rechargeLog := model.RechargeLog{
			UserId:     userData.Id,
			TargetId:   data.Id,
			TargetType: 0,
			Type:       0,
			Fee:        rLog.Fee,
			Balance:    balanceStr,
			Remark:     "订单退款",
			CreateAt:   time.Now().Unix(),
		}

		tx = cmf.NewDb().Create(&rechargeLog)
		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, err.Error(), nil)
		}
	}

	if data.PayType == "alipay" {

		if !exist {
			rest.rc.Error(c, "请先授权支付宝小程序！", nil)
			return
		}

		log := model.PayLog{}
		tx := cmf.NewDb().Where("order_id = ?", data.OrderId).First(&log)

		if tx.Error != nil {
			cmfLog.Error(tx.Error.Error())
			rest.rc.Error(c, err.Error(), nil)
		}

		bizContent := make(map[string]interface{}, 0)
		bizContent["out_trade_no"] = data.OrderId
		bizContent["trade_no"] = data.TradeNo
		bizContent["refund_amount"] = log.TotalAmount
		refundResult := new(payment.Common).Refund(bizContent)

		if refundResult.Response.Code != "10000" {
			rest.rc.Error(c, "退款失败！", refundResult.Response.SubMsg)
			return
		}
	}

	tx := cmf.NewDb().Model(&resModel.FoodOrder{}).Where("id = ?", data.Id).Update("order_status", "TRADE_REFUND")
	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		rest.rc.Error(c, err.Error(), nil)
	}

	rest.rc.Success(c, "退款成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 接单拒单
 * @Date 2021/3/12 21:21:17
 * @Param
 * @return
 **/

func (rest *Index) ReceivedOrRefused(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	var query = []string{"fo.mid = ?", " fo.id = ? "}
	var queryArgs = []interface{}{mid, rewrite.Id, "TRADE_SUCCESS"}

	data, err := new(resModel.FoodOrder).ShowByStore(query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if data.Id == 0 {
		rest.rc.Error(c, "订单不存在", nil)
		return
	}

	if !((data.OrderStatus == "TRADE_SUCCESS" && data.DeliveryStatus == "") || data.OrderStatus == "TRADE_REFUSED") {
		rest.rc.Error(c, "订单状态不正确", nil)
		return
	}

	os := c.PostForm("order_status")
	if os == "" {
		rest.rc.Error(c, "订单类型不能为空！", nil)
		return
	}

	orderStatus := ""
	deliveryStatus := ""

	msg := ""
	if os == "0" {
		orderStatus = "TRADE_REFUSED"
		msg = "拒单成功！"
	}

	if os == "1" {
		orderStatus = "TRADE_SUCCESS"
		deliveryStatus = "TRADE_RECEIVED"
		msg = "接单成功！"
	}

	if orderStatus == "" {
		rest.rc.Error(c, "订单类型不正确！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, data.Id).Updates(&resModel.FoodOrder{
		OrderStatus:    orderStatus,
		DeliveryStatus: deliveryStatus,
	})

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, msg, nil)

}
