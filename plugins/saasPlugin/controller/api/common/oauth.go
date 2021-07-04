/**
** @创建时间: 2020/10/5 2:34 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"context"
	"errors"
	"fmt"
	"gincmf/app/controller/api/common"
	"gincmf/app/model"
	"gincmf/app/util"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfUtil "github.com/gincmf/cmf/util"
	"golang.org/x/oauth2"
	oaErrors "gopkg.in/oauth2.v3/errors"
	"gopkg.in/oauth2.v3/generates"
	"gopkg.in/oauth2.v3/manage"
	"gopkg.in/oauth2.v3/models"
	"gopkg.in/oauth2.v3/server"
	"gopkg.in/oauth2.v3/store"
	"gorm.io/gorm"
	"net/http"
	"strconv"
	"strings"
	"time"
)

var (
	token *oauth2.Token
	rc    controller.Rest
)

func RegisterTenantRouter(handlers ...gin.HandlerFunc) {

	oaErrors.ErrInvalidAccessToken = errors.New("登录状态已失效！")

	conf := cmf.Conf()
	authServerURL := "http://localhost:" + conf.App.Port
	clientSecret := cmfUtil.GetMd5(conf.Database.AuthCode)

	config := oauth2.Config{
		ClientID:     "1",
		ClientSecret: clientSecret,
		Scopes:       []string{"all"},
		RedirectURL:  authServerURL,
		Endpoint: oauth2.Endpoint{
			AuthURL:  authServerURL + "/tenant/authorize",
			TokenURL: authServerURL + "/tenant/token",
		},
	}

	manager := manage.NewDefaultManager()
	manager.SetAuthorizeCodeTokenCfg(manage.DefaultAuthorizeCodeTokenCfg)

	// token store
	manager.MustTokenStorage(store.NewFileTokenStore("./data.db"))

	// generate jwt access token
	accessToken := generates.NewJWTAccessGenerate([]byte("gincmf"+conf.Database.AuthCode), jwt.SigningMethodHS512)
	manager.MapAccessGenerate(accessToken)
	clientStore := store.NewClientStore()
	clientStore.Set(config.ClientID, &models.Client{
		ID:     config.ClientID,
		Secret: config.ClientSecret,
		Domain: authServerURL,
	})

	manager.MapClientStorage(clientStore)
	common.Srv = server.NewServer(server.NewConfig(), manager)

	cmf.Post("api/tenant/token", func(c *gin.Context) {

		common.Srv.SetPasswordAuthorizationHandler(func(username, password string) (userID string, err error) {

			nameArr := strings.Split(username, "@")

			var (
				tx       *gorm.DB
				userPass string
				tenantId int    = 0
				typ      string = ""
				userId   int    = 0
			)

			if len(nameArr) == 1 {

				userLogin := nameArr[0]
				typ = "main"
				t := saasModel.Tenant{}
				tx = cmf.Db().First(&t, "user_login = ?", userLogin) // 查询
				if tx.RowsAffected > 0 {
					userId = 1
					tenantId = t.TenantId
					userPass = t.UserPass
				}
			}

			if len(nameArr) == 2 {

				typ = "ram"
				// 查询用户所属租户
				t := saasModel.Tenant{}
				tx = cmf.Db().First(&t, "alias_name = ?", nameArr[1]) // 查询
				if tx.Error != nil {
					if !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
						return "", errors.New("该租户不存在！")
					}
					return "", tx.Error
				}

				tenantId = t.TenantId
				cmf.ManualDb("tenant_" + strconv.Itoa(tenantId))

				u := saasModel.AdminUser{}
				tx = cmf.NewDb().Debug().First(&u, "user_login = ? AND user_status = 1 AND delete_at = 0", nameArr[0]) // 查询
				if tx.RowsAffected > 0 {
					userId = u.Id
					userPass = u.UserPass
				}
			}

			if tx.RowsAffected > 0 {

				//验证密码
				if cmfUtil.GetMd5(password) == userPass || password == "" {

					// 清除用户缓存
					session := sessions.Default(c)
					session.Delete("tenant")
					session.Delete("user")
					session.Save()

					userID = strconv.Itoa(userId)
					userID = userID + "@" + typ + "@" + strconv.Itoa(tenantId)
					return userID, nil
				}
				return "", errors.New("账号密码不正确！")
			}

			return "", errors.New("当前用户不存在！")
		})

		username := c.PostForm("username")
		password := c.PostForm("password")
		autoLogin := c.DefaultPostForm("autoLogin", "false")

		typ := c.PostForm("type")

		captcha := c.PostForm("captcha")
		if typ == "mobile" && captcha == "" {
			rc.Error(c, "验证码不能为空！", nil)
			return
		}

		nameArr := strings.Split(username, "@")
		mobile := nameArr[0]
		mobileInt, _ := strconv.Atoi(mobile)

		if typ == "account" && password == "" {
			rc.Error(c, "密码不能为空！", nil)
			return
		}

		if typ == "mobile" {
			err := util.ValidateSms(mobileInt, captcha)
			if err != nil {
				rc.Error(c, err.Error(), nil)
				return
			}
		}

		tokenExp := "24"
		if autoLogin == "true" {
			tokenExp = "168"
		}

		exp, err := strconv.Atoi(tokenExp)

		if err != nil {
			fmt.Println("err", err.Error())
			rc.Error(c, "失效时间应该是整数，单位为小时！", nil)
			return
		}

		fn := common.Srv.PasswordAuthorizationHandler
		userID, err := fn(username, password)
		if err != nil {
			rc.Error(c, err.Error(), nil)
			return
		} else {
			// 更新最后登录记录
			u := model.User{
				LastLoginIp: c.ClientIP(),
				LastLoginAt: time.Now().Unix(),
			}
			cmf.NewDb().Where("id = ?", userID).Updates(u)
		}

		duration := time.Duration(exp) * time.Hour
		req := &server.AuthorizeRequest{
			RedirectURI:    config.RedirectURL,
			ResponseType:   "code",
			ClientID:       config.ClientID,
			State:          "jwt",
			Scope:          "tenant",
			UserID:         userID,
			AccessTokenExp: duration,
			Request:        c.Request,
		}

		ti, err := common.Srv.GetAuthorizeToken(req)
		if err != nil {
			fmt.Println(err.Error())
		}

		code := ti.GetCode()

		token, err = config.Exchange(context.Background(), code)

		if err != nil {
			rc.Error(c, err.Error(), nil)
			return
		}

		c.JSON(http.StatusOK, token)
	}, handlers...)

	cmf.Post("api/tenant/refresh", func(c *gin.Context) {

		grantType := c.Query("grant_type")
		if grantType != "refresh_token" {
			rc.Error(c, "grant_type类型错误！", nil)
			return
		}

		refreshToken := c.Query("refresh_token")
		if refreshToken == "" {
			rc.Error(c, "refresh_token不能为空！", nil)
			return
		}
		token = &oauth2.Token{RefreshToken: refreshToken}
		tkr := config.TokenSource(context.Background(), token)
		tk, err := tkr.Token()

		if err != nil {
			c.JSON(http.StatusOK, gin.H{
				"error":             "invalid_client",
				"error_description": "Client authentication failed",
			})
			return
		}

		c.JSON(http.StatusOK, tk)

	}, handlers...)

	cmf.Post("/tenant/token", func(c *gin.Context) {
		err := common.Srv.HandleTokenRequest(c.Writer, c.Request)
		if err != nil {
			panic(err.Error())
		}
	})
}
