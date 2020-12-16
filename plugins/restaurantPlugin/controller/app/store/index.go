/**
** @创建时间: 2020/11/22 8:51 上午
** @作者　　: return
** @描述　　:
 */
package store

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type Index struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 选择门店，展现门店列表
 * @Date 2020/11/22 08:54:04
 * @Param
 * @return
 **/

func (rest *Index) List(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	name := c.Query("name")

	if name != "" {
		query = append(query, "store_name like ?")
		queryArgs = append(queryArgs, "%"+name+"%")
	}

	longitude := c.Query("longitude")
	if longitude == "" {
		rest.rc.Error(c, "经度不能为空！", nil)
		return
	}

	lon, err := strconv.ParseFloat(longitude, 64)
	if err != nil {
		rest.rc.Error(c, "经度参数不合法！", nil)
		return
	}

	latitude := c.Query("latitude")
	if latitude == "" {
		rest.rc.Error(c, "纬度不能为空！", nil)
		return
	}

	lat, err := strconv.ParseFloat(latitude, 64)
	if err != nil {
		rest.rc.Error(c, "纬度参数不合法！", nil)
		return
	}

	store := model.Store{
		Longitude: lon,
		Latitude:  lat,
	}

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)

	result, err := store.ListByDistance(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, "获取失败！", err.Error())
		return
	}
	rest.rc.Success(c, "获取成功！", result)
}

func (rest *Index) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	longitude := c.Query("longitude")
	if longitude == "" {
		rest.rc.Error(c, "经度不能为空！", nil)
		return
	}

	lon, err := strconv.ParseFloat(longitude, 64)
	if err != nil {
		rest.rc.Error(c, "经度参数不合法！", nil)
		return
	}

	latitude := c.Query("latitude")
	if latitude == "" {
		rest.rc.Error(c, "纬度不能为空！", nil)
		return
	}

	lat, err := strconv.ParseFloat(latitude, 64)
	if err != nil {
		rest.rc.Error(c, "纬度参数不合法！", nil)
		return
	}

	store := model.Store{
		Longitude: lon,
		Latitude:  lat,
	}

	query := []string{"store_number = ? AND delete_at = ?"}
	queryArgs := []interface{}{rewrite.Id, 0}

	storeData, err := store.AppShow(query, queryArgs)

	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", storeData)

}
