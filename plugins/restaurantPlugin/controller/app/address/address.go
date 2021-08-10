/**
** @创建时间: 2020/12/6 8:06 下午
** @作者　　: return
** @描述　　:
 */
package address

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"regexp"
	"strconv"
	"strings"
)

type Address struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部地址
 * @Date 2020/12/6 20:13:22
 * @Param
 * @return
 **/
func (rest *Address) Get(c *gin.Context) {

	mid, _ := c.Get("mid")
	userId, _ := c.Get("mp_user_id")

	storeNumber := c.Query("store_number")

	var (
		store model.Store
		err   error
	)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if storeNumber != "" {
		store := model.Store{
			Db: db,
		}
		store, err = store.Show([]string{"store_number = ? AND  mid = ? AND delete_at = ?"}, []interface{}{storeNumber, mid, 0})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
	}

	var address []model.Address
	result := db.Where("mid = ? AND user_id = ?", mid, userId).Order("`default` desc").Find(&address)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	// 获取当前外卖配置
	takeJson, err := saasModel.Options(db, "takeout", store.Mid)
	var takeOut model.TakeOut
	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	type addressTemp struct {
		model.Address
		Distance float64 `json:"distance,omitempty"`
		OutRange bool    `json:"out_range"`
	}

	var addressResult = make([]addressTemp, 0)

	for _, v := range address {

		distance := util.EarthDistance(v.Latitude, v.Longitude, store.Latitude, store.Longitude)

		at := addressTemp{
			Address:  v,
			Distance: distance,
		}

		// 超出距离
		if distance > takeOut.DeliveryDistance {
			at.OutRange = true
		}

		addressResult = append(addressResult, at)

	}

	rest.rc.Success(c, "获取成功！", addressResult)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取单个地址详情
 * @Date 2020/12/6 20:13:42
 * @Param
 * @return
 **/

func (rest *Address) Show(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	storeNumber := c.Query("store_number")

	var (
		store model.Store
		err   error
	)

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var takeOut model.TakeOut

	if storeNumber != "" {
		store := model.Store{
			Db: db,
		}
		store, err = store.Show([]string{"store_number = ? AND  mid = ? AND delete_at = ?"}, []interface{}{storeNumber, mid, 0})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if store.Id == 0 {
			rest.rc.Error(c, "门店不存在！", nil)
			return
		}

		// 获取当前堂食配置
		takeJson, err := saasModel.Options(db, "takeout", store.Mid)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		_ = json.Unmarshal([]byte(takeJson), &takeOut)
	}

	userId, _ := c.Get("mp_user_id")

	address := model.Address{}
	var tx *gorm.DB
	if rewrite.Id == "default" {
		tx = db.Where("`default` = ? AND mid = ? AND user_id = ?", 1, mid, userId).First(&address)
	} else {
		tx = db.Where("id = ? AND mid = ? AND user_id = ?", rewrite.Id, mid, userId).First(&address)
	}

	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该地址不存在！", nil)
			return
		}

		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	var addressResult struct {
		model.Address
		Distance float64 `json:"distance,omitempty"`
		OutRange bool    `json:"out_range"`
	}

	addressResult.Address = address

	fmt.Println(address.Latitude, address.Longitude)

	distanceFloat := util.EarthDistance(address.Latitude, address.Longitude, store.Latitude, store.Longitude)

	distance, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", distanceFloat), 64)

	// 超出距离
	if distance > takeOut.DeliveryDistance {
		addressResult.OutRange = true
	}

	addressResult.Distance = distance

	rest.rc.Success(c, "获取成功！", addressResult)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个收货地址
 * @Date 2020/12/6 20:15:49
 * @Param
 * @return
 **/

func (rest *Address) Store(c *gin.Context) {



	mid, _ := c.Get("mid")
	userId, _ := c.Get("mp_user_id")

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	gender := c.PostForm("gender")
	if gender == "" {
		rest.rc.Error(c, "性别不能为空！", nil)
		return
	}

	genderInt, err := strconv.Atoi(gender)
	if err != nil {
		rest.rc.Error(c, "性别参数非法！", nil)
		return
	}

	if genderInt == 1 {
		genderInt = 1
	} else {
		genderInt = 0
	}

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	reg := `0?(13|14|15|17|18|19)[0-9]{9}`
	rgx := regexp.MustCompile(reg)
	if !rgx.MatchString(mobile) {
		rest.rc.Error(c, "手机号格式不正确！", nil)
		return
	}

	mobileInt, _ := strconv.Atoi(mobile)

	addr := c.PostForm("address")
	if addr == "" {
		rest.rc.Error(c, "地址不能为空哦！", nil)
		return
	}

	geo := model.GeoAddress(addr)

	if len(geo.MapGeoCodes) == 0 {
		rest.rc.Error(c, "该地址不存在", nil)
		return
	}

	if len(geo.MapGeoCodes) > 1 {
		rest.rc.Error(c, "该地址不够详细，请补全详细地址", nil)
		return
	}

	location := geo.MapGeoCodes[0].Location
	lMap := strings.Split(location, ",")

	longitude, _ := strconv.ParseFloat(lMap[0], 64)
	latitude, _ := strconv.ParseFloat(lMap[1], 64)

	room := c.PostForm("room")
	if room == "" {
		rest.rc.Error(c, "门牌号不能为空哦！", nil)
		return
	}

	d := c.PostForm("default")

	dInt := 0
	if d == "1" {
		dInt = 1
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	address := model.Address{
		Mid:       mid.(int),
		UserId:    userId.(int),
		Name:      name,
		Gender:    genderInt,
		Mobile:    mobileInt,
		Address:   addr,
		Longitude: longitude,
		Latitude:  latitude,
		Room:      room,
		Default:   dInt,
	}

	if dInt == 1 {
		// 取消默认
		db.Model(&model.Address{}).Where("`default`= ? AND  user_id = ?", 1, userId).Update("default", 0)
	}

	result := db.Create(&address)

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "新增成功！", address)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新单个收货地址
 * @Date 2020/12/6 20:29:41
 * @Param
 * @return
 **/

func (rest *Address) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	userId, _ := c.Get("mp_user_id")

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	gender := c.PostForm("gender")
	if gender == "" {
		rest.rc.Error(c, "性别不能为空！", nil)
		return
	}

	genderInt, err := strconv.Atoi(gender)
	if err != nil {
		rest.rc.Error(c, "性别参数非法！", nil)
		return
	}

	if genderInt == 1 {
		genderInt = 1
	} else {
		genderInt = 0
	}

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	reg := `0?(13|14|15|17|18|19)[0-9]{9}`
	rgx := regexp.MustCompile(reg)
	if !rgx.MatchString(mobile) {
		rest.rc.Error(c, "手机号格式不正确！", nil)
		return
	}

	mobileInt, _ := strconv.Atoi(mobile)

	addr := c.PostForm("address")
	if addr == "" {
		rest.rc.Error(c, "地址不能为空哦！", nil)
		return
	}

	geo := model.GeoAddress(addr)

	if len(geo.MapGeoCodes) == 0 {
		rest.rc.Error(c, "该地址不存在", nil)
		return
	}

	if len(geo.MapGeoCodes) > 1 {
		rest.rc.Error(c, "该地址不够详细，请补全详细地址", nil)
		return
	}

	location := geo.MapGeoCodes[0].Location

	lMap := strings.Split(location, ",")

	longitude, _ := strconv.ParseFloat(lMap[0], 64)
	latitude, _ := strconv.ParseFloat(lMap[1], 64)

	room := c.PostForm("room")
	if room == "" {
		rest.rc.Error(c, "门牌号不能为空哦！", nil)
		return
	}

	d := c.PostForm("default")

	dInt := 0
	if d == "1" {
		dInt = 1
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	oAddr := model.Address{}
	res := db.Where("id = ? AND user_id = ?", rewrite.Id, userId).First(&oAddr)
	if res.Error != nil {
		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该地址不存在！", nil)
			return
		}
		rest.rc.Error(c, res.Error.Error(), nil)
		return
	}

	address := model.Address{
		Mid:       mid.(int),
		Id:        oAddr.Id,
		UserId:    userId.(int),
		Name:      name,
		Gender:    genderInt,
		Mobile:    mobileInt,
		Address:   addr,
		Longitude: longitude,
		Latitude:  latitude,
		Room:      room,
		Default:   dInt,
	}

	if dInt == 1 {
		// 取消默认
		db.Model(&model.Address{}).Where("`default` = ?", 1).Update("default", 0)
	}

	result := db.Save(&address)

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", address)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个地址
 * @Date 2020/12/6 20:42:16
 * @Param
 * @return
 **/

func (rest *Address) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")
	userId, _ := c.Get("mp_user_id")

	address := model.Address{}
	tx := db.Where("id = ? AND mid = ? AND user_id = ?", rewrite.Id, mid, userId).First(&address)
	if tx.Error != nil {

		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "地址不存在！", nil)
			return
		}

		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	tx = db.Where("id = ? AND mid = ? AND user_id = ?", rewrite.Id, mid, userId).Delete(&address)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "删除成功！", nil)

}
