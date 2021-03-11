/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　:
 */
package store

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/merchant"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Index struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 门店列表
 * @Date 2020/11/2 10:15:03
 * @Param
 * @return
 **/

// @Summary 门店列表
// @Description 查看全部门店列表
// @Tags restaurant 门店管理
// @Accept mpfd
// @Param store_name formData string true "门店名称"
// @Param start_time formData string true "起始时间"
// @Param end_time formData string true "结束时间"
// @Param status formData string true "结束时间"
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.Store} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/store/index [get]
func (rest *Index) Get(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")
	query = append(query, "mid = ?")
	queryArgs = append(queryArgs, mid)

	name := c.Query("store_name")
	if name != "" {
		query = append(query, "store_name = ?")
		queryArgs = append(queryArgs, name)
	}

	startTime := c.Query("start_time")
	endTime := c.Query("end_time")

	if startTime != "" && endTime != "" {
		startTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", startTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "起始时间非法！", err.Error())
			return
		}

		endTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", endTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "结束时间非法！", err.Error())
		}

		query = append(query, "create_at BETWEEN ? AND ?")
		queryArgs = append(queryArgs, startTimeStamp, endTimeStamp)
	}

	status := c.PostForm("status")
	if status != "" {
		query = append(query, "status = ?")
		queryArgs = append(queryArgs, status)
	}

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)

	// 菜品管理模型
	store := model.Store{}
	data, err := store.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜品门店选择
 * @Date 2020/12/4 16:42:21
 * @Param
 * @return
 **/
func (rest *Index) IndexWithFoodCount(c *gin.Context) {

	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")
	query = append(query, "mid = ?")
	queryArgs = append(queryArgs, mid)

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)

	// 菜品管理模型
	store := model.Store{}
	data, err := store.IndexWithFoodCount(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Index) List(c *gin.Context) {
	var query []string
	var queryArgs []interface{}

	mid, _ := c.Get("mid")
	query = append(query, "mid = ?")
	queryArgs = append(queryArgs, mid)

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)

	store := model.Store{}
	data, err := store.List(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单个门店信息
 * @Date 2020/11/2 10:24:43
 * @Param
 * @return
 **/

// @Summary 查看单个门店信息
// @Description 查看单个门店信息
// @Tags restaurant 门店管理
// @Accept mpfd
// @Param id path string true "单个门店id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Store} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/store/index/{id} [get]
func (rest Index) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	store := model.Store{}

	query := []string{"mid = ? AND  id = ?"}
	queryArgs := []interface{}{mid, rewrite.Id}

	storeData, err := store.Show(query, queryArgs)

	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该分类不存在！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	hours := model.StoreHours{
		Mid:     mid.(int),
		StoreId: rewrite.Id,
	}

	storeHours, err := hours.Hours()
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	type temp struct {
		model.Store
		PrevPath string `json:"prev_path"`
	}

	tempData := temp{}
	tempData.Store = storeData
	tempData.PrevPath = util.GetFileUrl(tempData.StoreThumbnail)

	var returnData struct {
		Store temp               `json:"store"`
		Hours []model.StoreHours `json:"hours"`
	}

	returnData.Store = tempData
	returnData.Hours = storeHours

	rest.rc.Success(c, "获取成功！", returnData)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交修改单个门店
 * @Date 11:45 下午 2020/10/29
 * @Param
 * @return
 **/

// @Summary 提交修改单个门店
// @Description 提交修改单个门店
// @Tags restaurant 门店管理
// @Accept mpfd
// @Param id path string true "单个门店id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Store} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/store/index/{id} [post]
func (rest Index) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)

	alipayUserId, alipayExist := c.Get("alipay_user_id")

	// 门店名称
	storeName := c.PostForm("store_name")
	if storeName == "" {
		rest.rc.Error(c, "门店名称不能为空！", nil)
		return
	}

	query := []string{"mid = ?", "id = ?"}
	queryArgs := []interface{}{mid, rewrite.Id}

	storeData, err := new(model.Store).Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
	}

	if storeData.Id == 0 {
		rest.rc.Error(c, "该门店不存在！", nil)
		return
	}

	storeNumber := storeData.StoreNumber

	// 联系电话
	phone := c.PostForm("phone")
	contactPerson := c.PostForm("contact_person")

	// 所在省市区
	province := c.PostForm("province")
	if province == "" {
		rest.rc.Error(c, "省份不能为空！", nil)
		return
	}

	provinceInt, err := strconv.Atoi(province)
	if err != nil {
		rest.rc.Error(c, "省份id格式错误！", nil)
		return
	}

	region := appModel.Region{}
	modelResult := region.GetOneById(provinceInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "省份不存在！", nil)
		return
	}

	provinceName := modelResult.AreaName

	city := c.PostForm("city")
	if city == "" {
		rest.rc.Error(c, "市区不能为空！", nil)
		return
	}

	cityInt, err := strconv.Atoi(city)
	if err != nil {
		rest.rc.Error(c, "城市id格式错误！", nil)
		return
	}

	modelResult = region.GetOneById(cityInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "市区不存在！", nil)
		return
	}

	cityName := modelResult.AreaName

	district := c.PostForm("district")
	if district == "" {
		rest.rc.Error(c, "县区不能为空！", nil)
		return
	}

	districtInt, err := strconv.Atoi(district)
	if err != nil {
		rest.rc.Error(c, "城市id格式错误！", nil)
		return
	}

	modelResult = region.GetOneById(districtInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "县区不存在！", nil)
		return
	}

	districtName := modelResult.AreaName

	// 详细地址
	address := c.PostForm("address")
	if address == "" {
		rest.rc.Error(c, "详细地址不能为空！", nil)
		return
	}

	// topCategory
	topCategory := c.PostForm("top_category")
	if topCategory == "" {
		rest.rc.Error(c, "门店类目不能为空！", nil)
		return
	}

	// shop_category 门店类目
	shopCategory := c.PostForm("shop_category")
	if shopCategory == "" {
		rest.rc.Error(c, "门店类目不能为空！", nil)
		return
	}

	tx := cmf.Db().Where("category_id = ? AND category_type = ?", shopCategory, 2).First(&appModel.ShopCategory{})

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "门店类目不存在！", nil)
		return
	}

	// 门店类型
	storeType := c.PostForm("shop_type")
	if storeType == "2" {
		storeType = "02"
	} else {
		storeType = "01"
	}

	// 门头照片
	storeThumbnail := c.PostForm("store_thumbnail")

	// 经度
	longitude := c.PostForm("longitude")
	longitudeFloat, err := strconv.ParseFloat(longitude, 64)
	if err != nil {
		rest.rc.Error(c, "经度格式不正确！", nil)
		return
	}
	// 纬度
	latitude := c.PostForm("latitude")
	latitudeFloat, err := strconv.ParseFloat(latitude, 64)
	if err != nil {
		rest.rc.Error(c, "纬度格式不正确！", nil)
		return
	}

	// 是否歇业
	isClosure := c.PostForm("is_closure")
	isClosureInt, err := strconv.Atoi(isClosure)
	if err != nil {
		rest.rc.Error(c, "歇业格式不正确！", nil)
		return
	}

	// 启用沽清
	enabledSellClear := c.PostForm("enabled_sell_clear")

	enabledSellInt := 0
	if enabledSellClear == "0" {
		enabledSellInt = 0
	}

	if enabledSellClear == "1" {
		enabledSellInt = 1
	}

	sellClear := ""
	if enabledSellInt == 1 {
		sellClear = c.PostForm("sell_clear")
	}

	// 营业时间
	hours := c.PostForm("hours")
	if !json.Valid([]byte(hours)) {
		rest.rc.Error(c, "营业时间参数非法！", nil)
		return
	}

	var storeHours []model.StoreHours
	json.Unmarshal([]byte(hours), &storeHours)
	fmt.Println("storeHours", storeHours)

	if len(storeHours) == 0 && len(storeHours) > 2 {
		rest.rc.Error(c, "营业时间长度非法！", nil)
		return
	}

	// 公告通知
	notice := c.PostForm("notice")

	store := model.Store{
		Id:               rewrite.Id,
		Mid:              midInt,
		StoreNumber:      storeNumber,
		StoreName:        storeName,
		TopCategory:      topCategory,
		StoreType:        storeType,
		ShopCategory:     shopCategory,
		Phone:            phone,
		ContactPerson:    contactPerson,
		Province:         provinceInt,
		ProvinceName:     provinceName,
		City:             cityInt,
		CityName:         cityName,
		District:         districtInt,
		DistrictName:     districtName,
		Address:          address,
		StoreThumbnail:   storeThumbnail,
		Longitude:        longitudeFloat,
		Latitude:         latitudeFloat,
		IsClosure:        isClosureInt,
		EnabledSellClear: enabledSellInt,
		SellClear:        sellClear,
		Notice:           notice,
		CreateAt:         time.Now().Unix(),
		UpdateAt:         time.Now().Unix(),
	}

	var bt = make([]merchant.BusinessTime, 0)
	for _, v := range storeHours {

		openTime := v.StartTime
		endTime := v.EndTime

		if v.AllTime == 1 {
			openTime = "00:00"
			endTime = "23:59"
		}

		if v.Mon == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   1,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Sat == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   2,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Wed == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   3,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Thur == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   4,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Fri == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   5,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Sat == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   6,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
		if v.Sun == 1 {
			bt = append(bt, merchant.BusinessTime{
				WeekDay:   7,
				OpenTime:  openTime,
				CloseTime: endTime,
			})
		}
	}

	// 存在阿里授权则门店同步到蚂蚁门店
	if alipayExist {

		// 换取门头照片
		bizC := make(map[string]string, 0)
		file := util.GetAbsPath(storeThumbnail)
		resultImage, err := new(merchant.Image).Upload(bizC, file)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if resultImage.Response.Code != "10000" {
			rest.rc.Error(c, "上传失败！"+resultImage.Response.SubMsg, nil)
			return
		}

		outDoorImages := []string{resultImage.Response.ImageId}

		// 同步到支付宝蚂蚁门店
		bizContent := make(map[string]interface{}, 0)
		bizContent["business_address"] = merchant.BusinessAddress{
			ProvinceCode: province,
			CityCode:     city,
			DistrictCode: district,
			Longitude:    longitude,
			Latitude:     latitude,
			Address:      address,
		}

		bizContent["shop_category"] = shopCategory
		bizContent["store_id"] = strconv.Itoa(storeNumber)
		bizContent["shop_type"] = storeType
		bizContent["ip_role_id"] = alipayUserId
		bizContent["shop_name"] = storeName
		bizContent["out_door_images"] = outDoorImages
		bizContent["business_time"] = bt
		bizContent["contact_mobile"] = phone
		bizContent["contact_infos"] = []merchant.ContactInfo{
			{
				Name:   contactPerson,
				Mobile: phone,
				Tag:    []string{"02"},
				Type:   "LEGAL_PERSON",
			},
		}

		orderId := storeData.OrderId
		// 查询门店存不存在
		shopResult := new(merchant.Shop).Query(bizContent)
		if shopResult.Response.Code == "10000" {
			result := new(merchant.Shop).Modify(bizContent)
			if result.Response.Code != "10000" {
				rest.rc.Error(c, "同步失败！"+result.Response.SubMsg, result)
				return
			}
			orderId = result.Response.OrderId
		} else {
			result := new(merchant.Shop).Create(bizContent)
			if result.Response.Code != "10000" {
				rest.rc.Error(c, "同步失败！"+result.Response.SubMsg, result)
				return
			}
			orderId = result.Response.OrderId
		}

		// 查询审核状态
		store.AuditStatus = "wait"
		store.OrderId = orderId
		bizContent = make(map[string]interface{}, 0)
		bizContent["order_id"] = orderId
		statusResult := new(merchant.Shop).QueryStatus(bizContent)
		if statusResult.Response.Code != "10000" {
			rest.rc.Error(c, "查询状态失败！"+statusResult.Response.SubMsg, nil)
			return
		}

		switch statusResult.Response.Status {
		case "031":
			store.AuditStatus = "wait"
		case "-1":
			store.AuditStatus = "rejected"
		case "99":
			store.AuditStatus = "passed"
		}

	}
	store, err = store.Update()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	// 营业时间
	sh := model.StoreHours{StoreId: store.Id, Mid: midInt}
	storeHours, err = sh.AddHours(storeHours)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var returnData struct {
		Store model.Store        `json:"store"`
		Hours []model.StoreHours `json:"hours"`
	}

	returnData.Store = store
	returnData.Hours = storeHours

	rest.rc.Success(c, "更新成功！", returnData)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个门店
 * @Date 2020/11/2 10:27:00
 * @Param
 * @return
 **/

// @Summary 新增单个门店
// @Description 新增单个门店
// @Tags restaurant 门店管理
// @Accept mpfd
// @Param mid formData string true "商户id"
// @Param store_name formData string true "商户名称"
// @Param phone formData string true "联系电话"
// @Param contact_person formData string true "联系人"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Store} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/store/index [post]
func (rest Index) Store(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	alipayUserId, alipayExist := c.Get("alipay_user_id")

	// 门店名称
	storeName := c.PostForm("store_name")
	if storeName == "" {
		rest.rc.Error(c, "门店名称不能为空！", nil)
		return
	}

	// 门店编号
	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":store" + yearStr + monthStr + dayStr
	number := util.EncryptUuid(insertKey, date, mid.(int))
	storeNumber, _ := strconv.Atoi(number)

	// 联系电话
	phone := c.PostForm("phone")
	contactPerson := c.PostForm("contact_person")

	// 所在省市区
	province := c.PostForm("province")
	if province == "" {
		rest.rc.Error(c, "省份不能为空！", nil)
		return
	}

	provinceInt, err := strconv.Atoi(province)
	if err != nil {
		rest.rc.Error(c, "省份id格式错误！", nil)
		return
	}

	region := appModel.Region{}
	modelResult := region.GetOneById(provinceInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "省份不存在！", nil)
		return
	}

	provinceName := modelResult.AreaName

	city := c.PostForm("city")
	if city == "" {
		rest.rc.Error(c, "市区不能为空！", nil)
		return
	}

	cityInt, err := strconv.Atoi(city)
	if err != nil {
		rest.rc.Error(c, "城市id格式错误！", nil)
		return
	}

	modelResult = region.GetOneById(cityInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "市区不存在！", nil)
		return
	}

	cityName := modelResult.AreaName

	district := c.PostForm("district")
	if district == "" {
		rest.rc.Error(c, "县区不能为空！", nil)
		return
	}

	districtInt, err := strconv.Atoi(district)
	if err != nil {
		rest.rc.Error(c, "城市id格式错误！", nil)
		return
	}

	modelResult = region.GetOneById(districtInt)
	if modelResult.AreaId == 0 {
		rest.rc.Error(c, "县区不存在！", nil)
		return
	}

	districtName := modelResult.AreaName

	// 详细地址
	address := c.PostForm("address")
	if address == "" {
		rest.rc.Error(c, "详细地址不能为空！", nil)
		return
	}

	// topCategory
	topCategory := c.PostForm("top_category")
	if topCategory == "" {
		rest.rc.Error(c, "门店类目不能为空！", nil)
		return
	}

	// shop_category 门店类目
	shopCategory := c.PostForm("shop_category")
	if shopCategory == "" {
		rest.rc.Error(c, "门店类目不能为空！", nil)
		return
	}

	tx := cmf.Db().Where("category_id = ? AND category_type = ?", shopCategory, 2).First(&appModel.ShopCategory{})

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "门店类目不存在！", nil)
		return
	}

	// 门店类型
	storeType := c.PostForm("shop_type")
	if storeType == "02" {
		storeType = "02"
	} else {
		storeType = "01"
	}

	// 门头照片
	storeThumbnail := c.PostForm("store_thumbnail")

	// 经度
	longitude := c.PostForm("longitude")
	longitudeFloat, err := strconv.ParseFloat(longitude, 64)
	if err != nil {
		rest.rc.Error(c, "经度格式不正确！", nil)
		return
	}
	// 纬度
	latitude := c.PostForm("latitude")
	latitudeFloat, err := strconv.ParseFloat(latitude, 64)
	if err != nil {
		rest.rc.Error(c, "纬度格式不正确！", nil)
		return
	}

	// 是否歇业
	isClosure := c.PostForm("is_closure")
	isClosureInt, err := strconv.Atoi(isClosure)
	if err != nil {
		rest.rc.Error(c, "歇业格式不正确！", nil)
		return
	}

	// 营业时间
	hours := c.PostForm("hours")
	if !json.Valid([]byte(hours)) {
		rest.rc.Error(c, "营业时间参数非法！", nil)
		return
	}

	var storeHours []model.StoreHours
	json.Unmarshal([]byte(hours), &storeHours)

	if len(storeHours) == 0 && len(storeHours) > 2 {
		rest.rc.Error(c, "营业时间长度非法！", nil)
		return
	}

	// 启用沽清
	enabledSellClear := c.PostForm("enabled_sell_clear")

	enabledSellInt := 0
	if enabledSellClear == "0" {
		enabledSellInt = 0
	}

	if enabledSellClear == "1" {
		enabledSellInt = 1
	}

	sellClear := ""
	if enabledSellInt == 1 {
		sellClear = c.PostForm("sell_clear")
	}

	// 公告通知
	notice := c.PostForm("notice")

	query := []string{"mid = ?", "store_name = ?"}
	queryArgs := []interface{}{mid, storeName}

	storeData, err := new(model.Store).Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
	}

	if storeData.Id > 0 {
		rest.rc.Error(c, "该门店已存在，无需重复创建！", nil)
		return
	}

	store := model.Store{
		Mid:              midInt,
		StoreNumber:      storeNumber,
		StoreName:        storeName,
		StoreType:        storeType,
		TopCategory:      topCategory,
		ShopCategory:     shopCategory,
		Phone:            phone,
		ContactPerson:    contactPerson,
		Province:         provinceInt,
		ProvinceName:     provinceName,
		City:             cityInt,
		CityName:         cityName,
		District:         districtInt,
		DistrictName:     districtName,
		Address:          address,
		StoreThumbnail:   storeThumbnail,
		Longitude:        longitudeFloat,
		Latitude:         latitudeFloat,
		IsClosure:        isClosureInt,
		EnabledSellClear: enabledSellInt,
		SellClear:        sellClear,
		Notice:           notice,
		CreateAt:         time.Now().Unix(),
		UpdateAt:         time.Now().Unix(),
	}

	// 同步到支付宝蚂蚁门店
	if alipayExist {

		// 换取门头照片
		bizC := make(map[string]string, 0)
		file := util.GetAbsPath(storeThumbnail)

		resultImage, err := new(merchant.Image).Upload(bizC, file)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if resultImage.Response.Code != "10000" {
			rest.rc.Error(c, "上传失败！"+resultImage.Response.SubMsg, nil)
			return
		}

		outDoorImages := []string{resultImage.Response.ImageId}

		bizContent := make(map[string]interface{}, 0)

		var bt = make([]merchant.BusinessTime, 0)
		for _, v := range storeHours {

			openTime := v.StartTime
			endTime := v.EndTime

			if v.AllTime == 1 {
				openTime = "00:00"
				endTime = "23:59"
			}

			if v.Mon == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   1,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Sat == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   2,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Wed == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   3,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Thur == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   4,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Fri == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   5,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Sat == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   6,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
			if v.Sun == 1 {
				bt = append(bt, merchant.BusinessTime{
					WeekDay:   7,
					OpenTime:  openTime,
					CloseTime: endTime,
				})
			}
		}

		bizContent["business_address"] = merchant.BusinessAddress{
			ProvinceCode: province,
			CityCode:     city,
			DistrictCode: district,
			Longitude:    longitude,
			Latitude:     latitude,
			Address:      address,
		}

		bizContent["shop_category"] = shopCategory
		bizContent["store_id"] = storeNumber
		bizContent["shop_type"] = storeType
		bizContent["ip_role_id"] = alipayUserId
		bizContent["shop_name"] = storeName
		bizContent["out_door_images"] = outDoorImages
		bizContent["business_time"] = bt
		bizContent["contact_mobile"] = phone
		bizContent["contact_infos"] = []merchant.ContactInfo{
			{
				Name:   contactPerson,
				Mobile: phone,
				Tag:    []string{"02"},
				Type:   "LEGAL_PERSON",
			},
		}

		result := new(merchant.Shop).Create(bizContent)
		if result.Response.Code != "10000" {
			rest.rc.Error(c, "同步失败！"+result.Response.SubMsg, result)
			return
		}

		store.AuditStatus = "wait"
		store.OrderId = result.Response.OrderId

		// 查询审核状态
		bizContent = make(map[string]interface{}, 0)
		bizContent["order_id"] = result.Response.OrderId
		statusResult := new(merchant.Shop).QueryStatus(bizContent)

		if statusResult.Response.Code != "10000" {
			rest.rc.Error(c, "查询状态失败！"+statusResult.Response.SubMsg, nil)
			return
		}

		switch statusResult.Response.Status {
		case "031":
			store.AuditStatus = "wait"
		case "-1":
			store.AuditStatus = "rejected"
		case "99":
			store.AuditStatus = "passed"
		}
	}

	store, err = store.Store()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	// 营业时间
	sh := model.StoreHours{StoreId: store.Id, Mid: midInt}
	storeHours, err = sh.AddHours(storeHours)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var returnData struct {
		Store model.Store        `json:"store"`
		Hours []model.StoreHours `json:"hours"`
	}

	returnData.Store = store
	returnData.Hours = storeHours

	rest.rc.Success(c, "添加成功！", returnData)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个门店
 * @Date 2020/11/2 10:29:06
 * @Param
 * @return
 **/

// @Summary 删除单个门店
// @Description 删除单个门店
// @Tags restaurant 门店管理
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Store} "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/store/index/{id} [delete]
func (rest Index) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)
	store := model.Store{}

	result := cmf.NewDb().Model(&store).Where("mid = ? AND id = ?", midInt, rewrite.Id).Update("delete_at", time.Now().Unix())

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
	}

	rest.rc.Success(c, "删除成功！", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 查询蚂蚁门店审核状态
 * @Date 2021/2/22 19:13:37
 * @Param
 * @return
 **/

func (rest Index) QueryStatus(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	alipayUserId, _ := c.Get("alipay_user_id")

	store := model.Store{}

	store, err := store.Show([]string{"mid = ?", "id = ?"}, []interface{}{mid, rewrite.Id})

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	orderId := store.OrderId

	if orderId == "" {
		rest.rc.Error(c, "请先提交或编辑门店", nil)
		return
	}

	bizContent := make(map[string]interface{}, 0)
	bizContent["order_id"] = orderId

	result := new(merchant.Shop).QueryStatus(bizContent)

	if result.Response.Code == "10000" {

		switch result.Response.Status {
		case "031":
			store.AuditStatus = "wait"
		case "-1":
			store.AuditStatus = "rejected"
		case "99":

			bizContent := make(map[string]interface{}, 0)
			bizContent["store_id"] = strconv.Itoa(store.StoreNumber)
			bizContent["ip_role_id"] = alipayUserId
			fmt.Println("bizContent", bizContent)

			shopResult := new(merchant.Shop).Query(bizContent)
			fmt.Println("shopResult", shopResult)

			if shopResult.Response.Code == "10000" {
				shopId := shopResult.Response.ShopId
				store.ShopId = shopId
			}

			store.AuditStatus = "passed"
		}

		tx := cmf.NewDb().Save(store)

		if tx.Error != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		rest.rc.Success(c, result.Response.Msg, result.Response)
	} else {
		rest.rc.Error(c, result.Response.SubMsg, result.Response)
	}

}
