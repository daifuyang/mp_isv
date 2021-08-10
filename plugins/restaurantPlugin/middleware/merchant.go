/**
** @创建时间: 2020/11/6 2:58 下午
** @作者　　: return
** @描述　　:
 */
package middleware

import (
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strings"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description 验证当前所在门店
 * @Date 2020/11/24 21:41:16
 * @Param
 * @return
 **/
func ValidationStore(c *gin.Context) {

	r := c.Request
	r.ParseForm()
	storeNumber := strings.Join(r.Form["store_number"], "")

	mid, exist := c.Get("mid")
	if !exist {
		new(controller.Rest).Error(c, "小程序唯一mid不能为空！", nil)
		c.Abort()
		return
	}

	if storeNumber == "" {
		new(controller.Rest).Error(c, "门店不能为空！", nil)
		c.Abort()
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	storeModel := model.Store{
		Db: db,
	}
	store, err := storeModel.Show([]string{"store_number = ? AND mid = ? AND delete_at = ?"}, []interface{}{storeNumber, mid, 0})

	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			new(controller.Rest).Error(c, "当前门店不存在！", nil)
			c.Abort()
			return
		}

		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	c.Set("store_id", store.Id)
	c.Next()
}
