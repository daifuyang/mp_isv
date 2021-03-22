package middleware

import (
	"fmt"
	"gincmf/app/controller/api/common"
	"gincmf/app/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gopkg.in/oauth2.v3"
	"net/http"
	"strconv"
	"strings"
	"time"
)

var Token oauth2.TokenInfo

//验证oauth token值
func ValidationBearerToken(c *gin.Context) {

	s := common.Srv
	t, err := s.ValidationBearerToken(c.Request)
	Token = t
	if err != nil {
		c.JSON(http.StatusOK, gin.H{"code": 400, "msg": err.Error()})
		fmt.Println("err", err.Error())
		c.Abort()
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

	c.Next()
}

//验证是否为管理员
func ValidationAdmin(c *gin.Context) {
	var userType int
	scope, _ := c.Get("scope")
	if scope == "tenant" {
		currentUser := new(saasModel.AdminUser).CurrentUser(c)
		if currentUser.Id > 0 {
			userType = 1
		}
	} else {
		cmf.ManualDb(cmf.Conf().Database.Name)
		currentUser := new(model.User).CurrentUser(c)
		userType = currentUser.UserType
	}

	c.Set("userType", userType)

	if userType != 1 {
		fmt.Println("您不是管理员，无权访问！")
		new(controller.RestController).Error(c, "您不是管理员，无权访问！", nil)
		c.Abort()
		return
	}

	c.Next()
}
