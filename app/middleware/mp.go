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
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"log"
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
		fmt.Println("ValidationMp,小程序app_id不能为空")
		controller.RestController{}.Error(c, "小程序app_id不能为空！", nil)
		c.Abort()
		return
	}

	// 验证当前小程序是否存在
	mpAuth := model.MpIsvAuth{}
	result := cmf.Db().Where("auth_app_id = ?", appId).First(&mpAuth)

	if result.RowsAffected == 0 {
		fmt.Println("ValidationMp,小程序app_id不正确")
		cmfLog.Error("小程序app_id不正确")
		controller.RestController{}.Error(c, "小程序auth_app_id不正确！", nil)
		c.Abort()
		return
	}

	// 设置访问数据库
	db := "tenant_" + strconv.Itoa(mpAuth.TenantId)
	cmf.ManualDb(db)

	mpJson,_ := json.Marshal(&mpAuth)

	appIdInt, _ := strconv.Atoi(appId)

	mid := mpAuth.MpId

	c.Set("mid",mid)
	c.Set("app_id", appIdInt)
	c.Set("mp_type",mpAuth.Type)
	c.Set("mp_json",string(mpJson))
	c.Next()
}

func ValidationUserId(c *gin.Context)  {

	r := c.Request
	r.ParseForm()
	openId := strings.Join(r.Form["open_id"], "")

	fmt.Println("openId",openId)

	if openId == "" {
		controller.RestController{}.Error(c, "小程序open_id不能为空！", nil)
		c.Abort()
		return
	}

	tp :=  model.ThirdPart{}
	result :=  cmf.NewDb().Where("open_id",openId).First(&tp)
	if result.RowsAffected == 0 {
		controller.RestController{}.Error(c, "用户open_id不存在！", nil)
		c.Abort()
		return
	}

	c.Set("mp_user_id",tp.UserId)
	c.Set("open_id",tp.OpenId)
	c.Next()

}
