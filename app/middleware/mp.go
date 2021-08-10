/**
** @创建时间: 2020/11/22 8:56 上午
** @作者　　: return
** @描述　　: 前台小程序的中间件
 */
package middleware

import (
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"log"
	"net/http"
	"strconv"
	"strings"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据小程序id获取用户的数据库
 * @Date 2020/11/22 08:56:47
 * @Param
 * @return
 **/

func ValidationMp(c *gin.Context) {

	// 获取小程序的app_id
	req := c.Request
	req.ParseMultipartForm(32 << 20)
	err := req.ParseForm()

	if err != nil {
		// handle error http.Error() for example
		log.Fatal("ParseForm: ", err)
	}

	param := req.Form
	appId := strings.Join(param["app_id"], "")

	authAppId := strings.Join(param["auth_app_id"], "")

	if authAppId != "" {
		appId = authAppId
	}

	if appId == "" {
		controller.Rest{}.Error(c, "小程序app_id不能为空！", nil)
		c.Abort()
		return
	}

	// 验证当前小程序是否存在
	mpAuth := model.MpIsvAuth{}
	result := cmf.Db().Where("auth_app_id = ?", appId).Order("id desc").First(&mpAuth)

	if result.RowsAffected == 0 {
		cmfLog.Error("小程序app_id不正确，appId：" + appId)
		controller.Rest{}.Error(c, "小程序auth_app_id不正确！", nil)
		c.Abort()
		return
	}

	// 设置访问数据库
	db := "tenant_" + strconv.Itoa(mpAuth.TenantId)
	c.Set("DB", db)

	alipayJson, _ := json.Marshal(&mpAuth)

	mid := mpAuth.MpId

	c.Set("mid", mid)
	c.Set("tenant_id", mpAuth.TenantId)
	c.Set("app_id", appId)
	c.Set("mp_type", mpAuth.Type)
	c.Set("alipay_json", string(alipayJson))
	c.Next()
}

func UseMp(c *gin.Context) {

	// 获取小程序的app_id
	req := c.Request
	req.ParseMultipartForm(32 << 20)
	err := req.ParseForm()

	if err != nil {
		// handle error http.Error() for example
		log.Fatal("ParseForm: ", err)
	}

	param := req.Form

	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	getParams = getParams[:len(getParams)-1]
	cmfLog.Info("alipay-getway：" + getParams)

	appId := strings.Join(param["app_id"], "")

	authAppId := strings.Join(param["auth_app_id"], "")

	notifyType := strings.Join(param["notify_type"], "")

	if authAppId != "" {
		appId = authAppId
	}

	if appId == "" {
		fmt.Println("ValidationMp,小程序app_id不能为空")
		controller.Rest{}.Error(c, "小程序app_id不能为空！", nil)
		c.Abort()
		return
	}

	// 验证当前小程序是否存在
	if notifyType != "open_app_auth_notify" {

		mpAuth := model.MpIsvAuth{}
		result := cmf.Db().Where("auth_app_id = ?", appId).Order("id desc").First(&mpAuth)

		if result.RowsAffected == 0 {
			fmt.Println("ValidationMp,小程序app_id不正确")
			cmfLog.Error("小程序app_id不正确，appId：" + appId)
			new(controller.Rest).Error(c, "小程序auth_app_id不正确！", nil)
			c.Abort()
			return
		}

		// 设置访问数据库
		db := "tenant_" + strconv.Itoa(mpAuth.TenantId)
		c.Set("DB", db)

		alipayJson, _ := json.Marshal(&mpAuth)
		mid := mpAuth.MpId

		c.Set("mid", mid)
		c.Set("mp_type", mpAuth.Type)
		c.Set("alipay_json", string(alipayJson))

	}

	c.Set("app_id", appId)
	c.Next()
}

func ValidationOpenId(c *gin.Context) {

	r := c.Request
	r.ParseForm()
	openId := strings.Join(r.Form["open_id"], "")

	if openId == "" || openId == "0" {
		new(controller.Rest).Error(c, "小程序open_id不能为空！", nil)
		c.Abort()
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	tp := model.ThirdPart{}
	result := db.Where("open_id = ?", openId).First(&tp)
	if result.RowsAffected == 0 {
		new(controller.Rest).Error(c, "用户open_id不存在！", nil)
		c.Abort()
		return
	}
	c.Set("open_id", tp.OpenId)
	c.Next()

}

func ValidationBindMobile(c *gin.Context) {

	r := c.Request
	r.ParseForm()
	openId := strings.Join(r.Form["open_id"], "")

	if openId == "" || openId == "0" {
		new(controller.Rest).Error(c, "小程序open_id不能为空！", nil)
		c.Abort()
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mid, _ := c.Get("mid")

	u := resModel.User{
		Db: db,
	}
	// 查询当前手机号用户是否存在
	prefix := cmf.Conf().Database.Prefix

	tx := db.Table(prefix+"user u").Select("u.*,part.open_id,part.user_id,part.type").
		Joins("INNER JOIN "+prefix+"third_part part ON u.id = part.user_id").
		Where("open_id = ? AND  u.mid = ?", openId, mid).
		Scan(&u)

	if tx.RowsAffected == 0 {
		new(controller.Rest).Error(c, "用户open_id不存在！", nil)
		c.Abort()
		return
	}

	if u.Id == 0 {
		c.JSON(http.StatusOK, model.ReturnData{Code: 20000, Msg: "请先绑定手机号！"})
		c.Abort()
		return
	}

	c.Set("mp_user_id", u.UserId)
	c.Set("open_id", u.OpenId)
	c.Next()

}
