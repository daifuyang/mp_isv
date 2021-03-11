/**
** @创建时间: 2020/11/22 8:55 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	saasModel "gincmf/plugins/saasPlugin/model"
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
	midMap := r.Form["mid"]

	if len(midMap) == 0 {
		c.JSON(http.StatusOK, gin.H{"code": 0, "msg": "小程序商户id不能为空"})
		c.Abort()
		return
	}

	mid := midMap[0]

	// 验证当前小程序是否存在
	result := cmf.NewDb().Where("mid = ?", mid).First(&saasModel.MpTheme{})

	if result.RowsAffected == 0 {
		controller.RestController{}.ErrorCode(c, 20001, "小程序编号不正确！", nil)
		c.Abort()
		return
	}

	midInt, _ := strconv.Atoi(mid)
	c.Set("mid", midInt)
	c.Next()

}

func UseMerchant(c *gin.Context) {

	// 获取小程序mid
	r := c.Request
	r.ParseForm()
	midMap := r.Form["mid"]
	mid := strings.Join(midMap, "")

	midInt, err := strconv.Atoi(mid)

	if err != nil {
		midInt = 0
	}

	if midInt > 0 {

		mid := midMap[0]
		// 验证当前小程序是否存在
		result := cmf.NewDb().Where("mid = ?", mid).First(&saasModel.MpTheme{})

		if result.RowsAffected == 0 {
			controller.RestController{}.ErrorCode(c, 20001, "小程序编号不正确！", nil)
			c.Abort()
			return
		}
		midInt, _ = strconv.Atoi(mid)

	}

	c.Set("mid", midInt)

	c.Next()

}
