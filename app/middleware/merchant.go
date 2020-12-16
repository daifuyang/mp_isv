/**
** @创建时间: 2020/11/22 8:55 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"encoding/json"
	"fmt"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"net/http"
	"strconv"
	"strings"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description 验证当前租户的商户信息
 * @Date 2020/11/22 08:55:40
 * @Param
 * @return
 **/
func ValidationMerchant(c *gin.Context) {

	// 获取小程序mid
	r := c.Request
	r.ParseForm()
	mid := strings.Join(r.Form["mid"], "")
	fmt.Println("mid", mid)

	if mid == "" {
		c.JSON(http.StatusOK, gin.H{"code": 0, "msg": "小程序商户id不能为空"})
		c.Abort()
		return
	}

	mpIsv := model.MpIsvAuth{}
	cmf.Db().Where("mp_id = ?",mid).Order("id desc").First(&mpIsv)
	mpJson,_ := json.Marshal(&mpIsv)
	c.Set("mp_json",string(mpJson))

	c.Set("alipay_user_id",mpIsv.UserId)

	// 验证当前小程序是否存在
	result := cmf.NewDb().Where("number = ?", mid).First(&model.MpTheme{})

	if result.RowsAffected == 0 {
		controller.RestController{}.Error(c, "小程序编号不正确！", nil)
		c.Abort()
	}

	midInt, _ := strconv.Atoi(mid)
	c.Set("mid", midInt)
	c.Next()

}
