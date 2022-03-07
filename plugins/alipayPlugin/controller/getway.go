/**
** @创建时间: 2020/12/30 9:48 下午
** @作者　　: return
** @描述　　:
 */
package controller

import (
	"encoding/json"
	"errors"
	cmfModel "gincmf/app/model"
	"gincmf/plugins/alipayPlugin/controller/getway"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type GetWay struct {
	rc controller.Rest
}

func (rest *GetWay) GetWay(c *gin.Context) {

	req := c.Request
	req.ParseForm()
	// 获取订单id
	param := req.Form

	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	getParams = getParams[:len(getParams)-1]
	cmfLog.Save(getParams, "getway.log")

	inParam := make(map[string]string, 0)

	for k, v := range param {
		item := strings.Join(v, "")
		if k == "sign" || k == "sign_type" || item == "" {
			continue
		}
		inParam[k] = item
	}

	sign := strings.ReplaceAll(strings.Join(param["sign"], ""), " ", "+")

	encode := easyUtil.SortParam(inParam)

	err := easyUtil.AliVerifySign(encode, sign)

	if err != nil {
		rest.rc.Error(c, "非法访问！", err.Error())
		return
	}

	method := strings.Join(param["msg_method"], "")

	switch method {
	case "ant.merchant.expand.shop.save.passed":

		// 主动通知
		err := new(getway.Merchant).Passed(c, param)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		// 同意门店审核
	case "ant.merchant.expand.shop.save.rejected":

		// 拒绝
		err := new(getway.Merchant).Rejected(c, param)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	notifyType := strings.Join(param["notify_type"], "")

	switch notifyType {
	case "open_app_auth_notify":

		// 绑定授权关系
		bizContentStr := strings.Join(param["biz_content"], "")

		type triggerContext struct {
			OutBizNo string `json:"out_biz_no"`
		}

		type notifyContext struct {
			Trigger        string         `json:"trigger"`
			TriggerContext triggerContext `json:"trigger_context"`
		}

		type detail struct {
			AppAuthToken    string `json:"app_auth_token"`
			UserId          string `json:"user_id"`
			ReExpiresIn     string `json:"re_expires_in"`
			AuthTime        int64  `json:"auth_time"`
			AppRefreshToken string `json:"app_refresh_token"`
			AuthAppId       string `json:"auth_app_id"`
			AppId           string `json:"app_id"`
			ExpiresIn       string `json:"expires_in"`
			AppAuthCode     string `json:"app_auth_code"`
		}

		var bizContent struct {
			NotifyContext notifyContext `json:"notify_context"`
			Detail        detail        `json:"detail"`
		}

		_ = json.Unmarshal([]byte(bizContentStr), &bizContent)

		if bizContent.NotifyContext.TriggerContext.OutBizNo != "" {

			tenantIdArr := strings.Split(bizContent.NotifyContext.TriggerContext.OutBizNo, "|")

			if len(tenantIdArr) == 3 {

				tenantId := tenantIdArr[0]

				mid := tenantIdArr[1]

				mpId, _ := strconv.Atoi(mid)

				userId := bizContent.Detail.UserId
				appAuthToken := bizContent.Detail.AppAuthToken
				appRefreshToken := bizContent.Detail.AppRefreshToken
				expiresIn := bizContent.Detail.ExpiresIn
				reExpiresIn := bizContent.Detail.ReExpiresIn
				authAppId := bizContent.Detail.AuthAppId

				tenant := saasModel.Tenant{}
				tx := cmf.Db().Where("tenant_id = ?", tenantId).First(&tenant)
				if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, tx.Error.Error(), nil)
					return
				}

				if tx.RowsAffected == 0 {
					rest.rc.Error(c, "租户不存在或已删除", nil)
					return
				}

				db := "tenant_" + strconv.Itoa(tenant.TenantId)
				mp := saasModel.MpTheme{}
				tx = cmf.ManualDb(db).Where("mid = ?", mid).First(&mp)
				if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, tx.Error.Error(), nil)
					return
				}

				if tx.RowsAffected == 0 {
					rest.rc.Error(c, "小程序不存在", nil)
					return
				}

				query := []string{"user_id = ?", "mp_id = ?", "type = ?"}
				queryArgs := []interface{}{userId, mpId, "alipay"}
				queryStr := strings.Join(query, " AND ")

				auth := cmfModel.MpIsvAuth{}

				tx = cmf.Db().Where(queryStr, queryArgs...).Order("id desc").First(&auth)
				if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, "获取失败！"+tx.Error.Error(), nil)
				}

				tenantIdInt, _ := strconv.Atoi(tenantId)

				auth.TenantId = tenantIdInt
				auth.MpId = mpId
				auth.Type = "alipay"
				auth.UserId = userId
				auth.AppAuthToken = appAuthToken
				auth.AppRefreshToken = appRefreshToken
				auth.ExpiresIn = expiresIn
				auth.ReExpiresIn = reExpiresIn

				if auth.Id == 0 {
					auth.AuthAppId = authAppId
					auth.CreateAt = time.Now().Unix()
					cmf.Db().Create(&auth)
				} else {

					if authAppId != auth.AuthAppId {
						rest.rc.Error(c, "重新授权的账号与当前绑定的账号不一致，如需换绑请先解绑", nil)
						return
					}

					auth.UpdateAt = time.Now().Unix()
					cmf.Db().Updates(&auth)
				}

			}

		}

	}

	// 线下授权

	rest.rc.Success(c, "回调成功！", nil)

}
