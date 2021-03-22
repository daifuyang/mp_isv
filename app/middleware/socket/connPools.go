/**
** @创建时间: 2021/3/14 1:48 下午
** @作者　　: return
** @描述　　: 连接池
 */
package socket

import (
	"encoding/json"
	"fmt"
	"gincmf/app/cmfWebsocket"
	"gincmf/app/controller/api/common"
	"gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gorilla/websocket"
	"net/http"
	"strconv"
	"time"
)

func ConnPools(c *gin.Context) {

	connInterface, _ := c.Get("websocket")
	wsConn := connInterface.(*websocket.Conn)
	defer wsConn.Close()

	var (
		conn *cmfWebsocket.Connection
		err  error
	)
	if conn, err = cmfWebsocket.InitConnection(wsConn); err != nil {
		goto ERR
	}

	for {
		var (
			data []byte
			err  error
		)
		if data, err = conn.ReadMessage(); err != nil {
			goto ERR
		}

		var inParams cmfWebsocket.Params
		json.Unmarshal(data, &inParams)

		token := inParams.Token

		if token == "" {
			conn.Error("用户登录状态已失效！", nil)
			goto Exit
		}

		s := common.Srv
		t, err := s.Manager.LoadAccessToken(token)
		if err != nil {
			fmt.Println("err", err)
			conn.Error("用户登录状态已失效！", nil)
			goto Exit
		}

		// 增加时间
		s.SetAccessTokenExpHandler(func(w http.ResponseWriter, r *http.Request) (td time.Duration, err error) {
			tokenExp := "24"
			exp, _ := strconv.Atoi(tokenExp)
			duration := time.Duration(exp) * time.Hour
			return duration, nil
		})

		userId, _ := strconv.Atoi(t.GetUserID())
		fmt.Println("userId", userId)

		tenant := model.Tenant{}

		if err := cmf.Db().Where("id = ?", userId).First(&tenant).Error; err != nil {
			fmt.Println("err", err)
			conn.Error(err.Error(), nil)
			goto Exit
		}

		db := "tenant_" + strconv.Itoa(tenant.TenantId)
		cmf.ManualDb(db)

		client := cmfWebsocket.Client{
			Conn:  conn,
			Token: token,
		}

		client.SetClient(strconv.Itoa(userId))
		c.Set("userId", userId)
		c.Set("tenantId", tenant.TenantId)
		c.Next()

	}

ERR:
	wsConn.Close()

Exit:
	c.Abort()
	return
}
