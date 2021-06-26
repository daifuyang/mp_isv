/**
** @创建时间: 2020/12/2 2:51 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"errors"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfData "github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gorilla/websocket"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Index struct {
	rc controller.Rest
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
 * @Description 获取退款详情
 * @Date 2021/5/10 12:29:29
 * @Param
 * @return
 **/
func (rest *Index) RefundShow(c *gin.Context) {
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

	var result []resModel.FoodOrderRefund
	tx := cmf.NewDb().Where("mid = ? and order_id = ?", mid, data.OrderId).Find(&result)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if len(result) == 0 {
		result = make([]resModel.FoodOrderRefund, 0)
	}

	rest.rc.Success(c, "获取成功", result)

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

	refundFee := c.PostForm("refund_fee")

	if refundFee == "" {
		rest.rc.Error(c, "退款金额不能为空！", nil)
		return
	}

	refundFeeFloat, err := strconv.ParseFloat(refundFee, 64)
	if err != nil {
		rest.rc.Error(c, "退款金额不是有效值！", nil)
		return
	}

	refundReason := c.PostForm("refund_reason")

	if refundReason == "" {
		rest.rc.Error(c, "退款理由不能为空！", nil)
		return
	}

	var query = []string{"fo.mid = ?", " fo.id = ? "}
	var queryArgs = []interface{}{mid, rewrite.Id}

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

	if data.RefundFee < refundFeeFloat {
		rest.rc.Error(c, "非法退款，超出可退金额", nil)
		return
	}

	authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

	at := ""
	if akExist {
		at = authorizerAccessToken.(string)
	}

	err = data.Refund(refundFeeFloat, refundReason, at)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
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

	tx := cmf.NewDb().Begin()
	tx.SavePoint("sp1")

	defer func() {
		if r := recover(); r != nil {
			tx.RollbackTo("sp1")
		}
	}()

	tx.Where("mid = ? AND id = ?", mid, data.Id).Updates(&resModel.FoodOrder{
		OrderStatus:    orderStatus,
		DeliveryStatus: deliveryStatus,
	})

	if tx.Error != nil {
		cmfLog.Error(tx.Error.Error())
		tx.RollbackTo("sp1")
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 打印订单
	if os == "1" {
		foodOrder := resModel.FoodOrder{
			Id: data.Id,
		}

		foodOrder.Db = tx
		err := foodOrder.Printer()
		if err != nil {
			tx.RollbackTo("sp1")
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	// 拒绝订单，退款
	if os == "0" {

		authorizerAccessToken, akExist := c.Get("authorizerAccessToken")

		at := ""
		if akExist {
			at = authorizerAccessToken.(string)
		}

		err = data.Refund(data.RefundFee, "商家主动拒绝订单", at)
		if err != nil {
			tx.RollbackTo("sp1")
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	tx.Commit()

	rest.rc.Success(c, msg, nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 设置订单为完成状态
 * @Date 2021/5/10 13:36:31
 * @Param
 * @return
 **/

func (rest *Index) Finished(c *gin.Context) {

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

	if data.OrderStatus != "TRADE_SUCCESS" {
		rest.rc.Error(c, "订单状态不正确", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, data.Id).Updates(&resModel.FoodOrder{
		OrderStatus: "TRADE_FINISHED",
	})

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "订单修改成功", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 重打订单
 * @Date 2021/5/10 13:41:4
 * @Param
 * @return
 **/

func (rest *Index) OrderPrinter(c *gin.Context) {

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

	var fod []resModel.FoodOrderDetail
	tx := cmf.NewDb().Where("order_id = ?", data.OrderId).Find(&fod)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
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

	// 获取门店打印机状态
	_, err = new(resModel.FoodOrder).SendPrinter(data, printOrder, data.StoreName, appointmentTime, true)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "打印成功", nil)

}
