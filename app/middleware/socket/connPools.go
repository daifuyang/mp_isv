/**
** @创建时间: 2021/3/14 1:48 下午
** @作者　　: return
** @描述　　: 连接池
 */
package socket

import (
	"encoding/json"
	"fmt"
	"gincmf/app/controller/api/common"
	"gincmf/app/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/cmfWebsocket"
	cmfLog "github.com/gincmf/cmf/log"
	"github.com/gorilla/websocket"
	"net/http"
	"strconv"
	"strings"
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
		mid := inParams.Mid

		if token == "" {
			conn.Error("用户登录状态已失效！", nil)
			goto Exit
		}

		if mid == 0 {
			conn.Error("mid错误！", nil)
			goto Exit
		}

		s := common.Srv
		t, err := s.Manager.LoadAccessToken(token)
		if err != nil {
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

		scope := t.GetScope()
		userID := t.GetUserID()

		userArr := strings.Split(userID, "@")

		userId := userArr[0]
		userType := userArr[1]
		tenantId := userArr[2]

		userIdInt, _ := strconv.Atoi(userId)
		tenantIdInt, _ := strconv.Atoi(tenantId)

		c.Set("scope", scope)
		c.Set("user_id", userIdInt)
		c.Set("account_type", userType)
		c.Set("tenant_id", tenantIdInt)
		c.Set("mid", mid)

		db := "tenant_" + tenantId
		cmf.ManualDb(db)

		client := cmfWebsocket.Client{
			Conn: conn,
		}

		client.SetClient(userId)
		c.Next()

	}

ERR:
	wsConn.Close()

Exit:
	c.Abort()
	return
}

// 桌号参数
type weAppPrams struct {
	AppId       string `json:"app_id"`
	OpenId      string `json:"open_id"`
	StoreNumber int    `json:"store_number"`
	DeskNumber  int    `json:"desk_number"`
}

func WeAppPools(c *gin.Context) {

	connInterface, _ := c.Get("websocket")
	wsConn := connInterface.(*websocket.Conn)
	defer wsConn.Close()

	var (
		conn *cmfWebsocket.Connection
		err  error
	)
	if conn, err = cmfWebsocket.InitConnection(wsConn); err != nil {
		fmt.Println("conn err",err)
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

		var inParams weAppPrams
		json.Unmarshal(data, &inParams)

		fmt.Println("inParams",inParams)

		appId := inParams.AppId

		mpAuth := model.MpIsvAuth{}
		result := cmf.Db().Where("auth_app_id = ?", appId).Order("id desc").First(&mpAuth)

		if result.RowsAffected == 0 {
			cmfLog.Error("小程序app_id不正确，appId：" + appId)
			conn.Error("小程序app_id不正确，appId："+appId, nil)
			goto Exit
		}

		mid := mpAuth.MpId
		tenantId := mpAuth.TenantId
		openId := inParams.OpenId

		storeNumber := inParams.StoreNumber
		deskNumber := inParams.DeskNumber

		if openId == "" {
			conn.Error("用户登录状态已失效！", nil)
			goto Exit
		}

		if mid == 0 {
			conn.Error("mid错误！", nil)
			goto Exit
		}

		if storeNumber == 0 {
			conn.Error("门店错误，请先扫秒桌上的二维码！", nil)
			goto Exit
		}

		if deskNumber == 0 {
			conn.Error("桌号错误，请先扫秒桌上的二维码！", nil)
			goto Exit
		}

		tenantIdStr := strconv.Itoa(tenantId)

		db := "tenant_" + tenantIdStr

		u := resModel.User{}
		// 查询当前手机号用户是否存在
		prefix := cmf.Conf().Database.Prefix

		tx := cmf.ManualDb(db).Table(prefix+"user u").Select("u.*,part.open_id,part.user_id,part.type").
			Joins("INNER JOIN "+prefix+"third_part part ON u.id = part.user_id").
			Where("open_id = ? AND  u.mid = ?", openId, mid).
			Scan(&u)

		if tx.RowsAffected == 0 {
			conn.Error("用户open_id不存在！", nil)
			goto Exit
		}

		if u.Id == 0 {
			conn.Error("请先绑定手机号！", nil)
			goto Exit
		}

		desk := resModel.Desk{}
		tx = cmf.ManualDb(db).Where("desk_number = ?", deskNumber).First(&desk)
		if tx.RowsAffected == 0 {
			conn.Error("该桌号不存在！", nil)
			goto Exit
		}

		store := resModel.Store{}
		tx = cmf.ManualDb(db).Where("id = ?", desk.StoreId).First(&store)
		if tx.RowsAffected == 0 {
			conn.Error("该门店不存在或已下架！", nil)
			goto Exit
		}

		c.Set("tenant_id", tenantId)
		c.Set("mp_user_id", u.UserId)
		c.Set("open_id", u.OpenId)
		c.Set("store_number", store.StoreNumber)
		c.Set("desk_number", desk.DeskNumber)
		c.Set("mid", mid)

		userId := strconv.Itoa(u.Id)

		c.Set("user_id", u.Id)

		client := cmfWebsocket.Client{
			Conn:  conn,
			Token: userId,
		}

		client.SetClient(userId)
		c.Next()

	}

ERR:

	fmt.Println("发生错误")

	wsConn.Close()

Exit:
	fmt.Println("发生Exit")
	c.Abort()
	return
}
