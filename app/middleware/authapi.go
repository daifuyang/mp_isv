package middleware

import (
	"fmt"
	"gincmf/app/controller/api/common"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gopkg.in/oauth2.v3"
	"net/http"
	"strconv"
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

	fmt.Println("scope", t.GetScope())
	fmt.Println("user_id", t.GetUserID())
	c.Set("scope", t.GetScope())
	c.Set("user_id", t.GetUserID())
	c.Next()
}

//验证是否为管理员
func ValidationAdmin(c *gin.Context) {

	currentUser := model.CurrentUser(c)
	userType := currentUser.UserType
	c.Set("userType", userType)
	scope, _ := c.Get("scope")
	if !(userType == 1 || scope == "tenant") {
		fmt.Println("您不是管理员，无权访问！")
		controller.RestController{}.Error(c, "您不是管理员，无权访问！", nil)
		c.Abort()
	}
	c.Next()
}
