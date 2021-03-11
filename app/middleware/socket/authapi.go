/**
** @创建时间: 2020/12/6 11:06 上午
** @作者　　: return
** @描述　　:
 */
package socket

import (
	"errors"
	"fmt"
	"gincmf/app/controller/api/common"
	"gincmf/plugins/saasPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"net/http"
	"strconv"
	"time"
)

var UserId int

func ValidationBearerToken(token string) error {
	s := common.Srv
	t, err := s.Manager.LoadAccessToken(token)
	if err != nil {
		return errors.New("用户登录状态已失效！")
	}

	// 增加时间
	s.SetAccessTokenExpHandler(func(w http.ResponseWriter, r *http.Request) (td time.Duration, err error) {
		tokenExp := "24"
		exp, _ := strconv.Atoi(tokenExp)
		duration := time.Duration(exp) * time.Hour
		return duration, nil
	})

	UserId, _ = strconv.Atoi(t.GetUserID())

	fmt.Println("userid", UserId)

	tenant := model.Tenant{}

	if err := cmf.Db().Where("id = ?", UserId).First(&tenant).Error; err != nil {
		return err
	}

	db := "tenant_" + strconv.Itoa(tenant.TenantId)
	cmf.ManualDb(db)

	return nil
}
