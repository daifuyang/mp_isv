/**
** @创建时间: 2020/12/31 1:16 下午
** @作者　　: return
** @描述　　: 消息通知
 */
package admin

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gorilla/websocket"
)

type Notice struct {
	rc controller.Rest
}

// 定义链接客户端
type Client struct {
	conn   *websocket.Conn
	userId int
	isConn bool
}

var clientsMap = make(map[Client]bool)

/*
	查询全部通知
	1.新订单通知（堂食，外卖）
	2.门店审核通知
*/
/*func (rest *Notice) WsGet(w http.ResponseWriter, r *http.Request) {

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
			Token    string `json:"token"`
			Current  int    `json:"current"`
			PageSize int    `json:"pageSize"`
		}

		current := 0
		if result.Current > 0 {
			current = result.Current
		}

		pageSize := 10
		if result.PageSize > 0 {
			pageSize = result.PageSize
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

		var query []string
		var queryArgs []interface{}

		data, err := new(model.AdminNotice).PaginateGet(current, pageSize, query, queryArgs)
		if err != nil {
			if err = c.WriteMessage(mt, []byte( rest.rc.JsonError(err.Error(), nil) )); err != nil {
				return
			}
			return
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
func (rest *Notice) Get(c *gin.Context) {
	result, err := new(model.AdminNotice).Get(c, nil, nil)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", result)
}

func (rest *Notice) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	notice, err := new(model.AdminNotice).Show([]string{"id = ?"}, []interface{}{rewrite.Id})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", notice)

}

func (rest *Notice) Read(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	tx := cmf.NewDb().Model(&model.AdminNotice{}).Where("id = ?", rewrite.Id).Update("status", 1)

	err := tx.Error
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", nil)
}
