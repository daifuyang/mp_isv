/**
** @创建时间: 2020/11/22 8:55 上午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"errors"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
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

	tenantId, _ := c.Get("tenant_id")

	fmt.Println("tenantId",tenantId)

	var mpAuth []model.MpIsvAuth
	tx := cmf.Db().Where("mp_id = ?", mid).Order("id desc").Find(&mpAuth)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		new(controller.Rest).Error(c, tx.Error.Error(), nil)
		c.Abort()
		return
	}

	canAccess := false

	if tx.RowsAffected > 0 {
		for _, v := range mpAuth {

			if v.TenantId == tenantId {
				canAccess = true
			}

			if v.Type == "wechat" {
				dbName := "tenant_" + strconv.Itoa(v.TenantId)
				c.Set("DB", dbName)
				c.Set("wechat", true)
			}
			if v.Type == "alipay" {
				c.Set("alipay", true)
				dbName := "tenant_" + strconv.Itoa(v.TenantId)
				c.Set("DB", dbName)
				alipayEasySdk.SetOption("AppAuthToken", v.AppAuthToken)
			}
		}
	}

	if !canAccess {
		new(controller.Rest).ErrorCode(c, 20001, "小程序编号不正确！", nil)
		c.Abort()
		return
	}

	// 验证当前小程序是否存在
	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	tx = db.Where("mid = ?", mid).First(&saasModel.MpTheme{})

	if tx.RowsAffected == 0 {
		new(controller.Rest).ErrorCode(c, 20001, "小程序编号不正确！", nil)
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

		db, err := util.NewDb(c)
		if err != nil {
			new(controller.Rest).Error(c, err.Error(), nil)
			c.Abort()
			return
		}

		mid := midMap[0]
		// 验证当前小程序是否存在
		result := db.Where("mid = ?", mid).First(&saasModel.MpTheme{})

		if result.RowsAffected == 0 {
			new(controller.Rest).ErrorCode(c, 20001, "小程序编号不正确！", nil)
			c.Abort()
			return
		}
		midInt, _ = strconv.Atoi(mid)

	}

	c.Set("mid", midInt)

	c.Next()

}
