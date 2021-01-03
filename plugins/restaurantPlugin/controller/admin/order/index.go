/**
** @创建时间: 2020/12/2 2:51 下午
** @作者　　: return
** @描述　　:
 */
package order

import (
	"encoding/json"
	"errors"
	"gincmf/app/middleware/socket"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gorilla/websocket"
	"gorm.io/gorm"
	"log"
	"net/http"
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

	var query = []string{"mid = ?"}
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

	// 订单类型
	orderType := c.Query("order_type")
	if orderType != "" {
		query = append(query, "fo.order_type = ?")
		queryArgs = append(queryArgs, orderType)
	}

	// 订单状态
	orderStatus := c.Query("order_status")
	if orderStatus != "" {
		query = append(query, "fo.order_status = ?")
		queryArgs = append(queryArgs, orderStatus)
	}

	order := model.FoodOrder{}
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

	order := model.FoodOrder{}
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

	order := model.FoodOrder{}
	err := order.Cancel(query, queryArgs, appId.(string))
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "订单作废成功！", nil)

}

func (rest *Index) Order(w http.ResponseWriter, r *http.Request) {

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
			Mid         int `json:"mid"`
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
		if mid == 0 {
			c.WriteMessage(mt, []byte( rest.rc.JsonError("mid不能为空！", nil) ));
			return
		}

		var query = []string{"mid = ?"}
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

		order := model.FoodOrder{}

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
