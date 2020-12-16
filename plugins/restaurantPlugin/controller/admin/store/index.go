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
	ginModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type IndexController struct {
	rc controller.RestController
}

// 文档所需
type storeIndexPaginate struct {
	Data     []model.Store `json:"data"`
	Current  string        `json:"current" example:"1"`
	PageSize string        `json:"page_size" example:"10"`
	Total    int64         `json:"total" example:"10"`
}

type storeIndexGet struct {
	Code int                `json:"code" example:"1"`
	Msg  string             `json:"msg" example:"获取成功！"`
	Data storeIndexPaginate `json:"data"`
}

type storeIndexStore struct {
	Code int         `json:"code" example:"1"`
	Msg  string      `json:"msg" example:"添加成功！"`
	Data model.Store `json:"data"`
}

type storeIndexShow struct {
	Code int         `json:"code" example:"1"`
	Msg  string      `json:"msg" example:"获取成功！"`
	Data model.Store `json:"data"`
}

type storeIndexEdit struct {
	Code int         `json:"code" example:"1"`
	Msg  string      `json:"msg" example:"修改成功！"`
	Data model.Store `json:"data"`
}

type storeIndexDel struct {
	Code int         `json:"code" example:"1"`
	Msg  string      `json:"msg" example:"删除成功！"`
	Data model.Store `json:"data"`
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
// @Produce json
// @Success 200 {object} storeIndexGet "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/store/index [get]
func (rest *IndexController) Get(c *gin.Context) {

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
func (rest *IndexController) IndexWithFoodCount(c *gin.Context) {

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

func (rest *IndexController) List(c *gin.Context) {
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
// @Produce json
// @Success 200 {object} storeIndexShow "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/store/index/{id} [get]
func (rest IndexController) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
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
// @Produce json
// @Success 200 {object} storeIndexEdit "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/store/index/{id} [post]
func (rest IndexController) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 门店名称
	storeName := c.PostForm("store_name")
	if storeName == "" {
		rest.rc.Error(c, "门店名称不能为空！", nil)
		return
	}

	// 门店编号
	yearStr, monthStr, dayStr := util.CurrentDate()
	insertKey := "mp_isv:store:" + yearStr + monthStr + dayStr

	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)

	cmf.NewRedisDb().ExpireAt(insertKey, today)

	val := util.SetIncr(insertKey)
	numIdStr := strconv.FormatInt(val, 10)
	nStr := "10" + yearStr + monthStr + dayStr + numIdStr

	n, err := strconv.Atoi(nStr)
	if err != nil {
		rest.rc.Error(c, "门店编号生成出错，请联系管理员！", err.Error())
		return
	}

	storeNumber := util.EncodeId(uint64(n))

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

	region := ginModel.Region{}
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

	// 支持场景
	scene := c.PostForm("scene")
	sceneInt, err := strconv.Atoi(scene)
	if err != nil {
		rest.rc.Error(c, "场景参数非法！", nil)
		return
	}

	// 是否歇业
	isClosure := c.PostForm("is_closure")
	isClosureInt, err := strconv.Atoi(isClosure)
	if err != nil {
		rest.rc.Error(c, "歇业格式不正确！", nil)
		return
	}

	// 启用桌号
	useDesk := c.PostForm("use_desk")
	useDeskInt, err := strconv.Atoi(useDesk)
	if err != nil {
		rest.rc.Error(c, "启用桌号点餐格式不正确！", err.Error())
		return
	}

	// 启用堂食预约
	useAppointment := c.PostForm("use_appointment")
	useAppointmentInt, err := strconv.Atoi(useAppointment)
	if err != nil {
		rest.rc.Error(c, "启用堂食预约格式不正确！", nil)
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
	fmt.Println("storeHours", storeHours)

	if len(storeHours) == 0 && len(storeHours) > 2 {
		rest.rc.Error(c, "营业时间长度非法！", nil)
		return
	}

	// 公告通知
	notice := c.PostForm("notice")

	store := model.Store{
		Id:             rewrite.Id,
		Mid:            midInt,
		StoreNumber:    storeNumber,
		StoreName:      storeName,
		Phone:          phone,
		ContactPerson:  contactPerson,
		Province:       provinceInt,
		ProvinceName:   provinceName,
		City:           cityInt,
		CityName:       cityName,
		District:       districtInt,
		DistrictName:   districtName,
		Address:        address,
		StoreThumbnail: storeThumbnail,
		Longitude:      longitudeFloat,
		Latitude:       latitudeFloat,
		Scene:          sceneInt,
		IsClosure:      isClosureInt,
		UseDesk:        useDeskInt,
		UseAppointment: useAppointmentInt,
		Notice:         notice,
		CreateAt:       time.Now().Unix(),
		UpdateAt:       time.Now().Unix(),
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
// @Produce json
// @Success 200 {object} storeIndexStore "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/store/index [post]
func (rest IndexController) Store(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 门店名称
	storeName := c.PostForm("store_name")
	if storeName == "" {
		rest.rc.Error(c, "门店名称不能为空！", nil)
		return
	}

	// 门店编号
	yearStr, monthStr, dayStr := util.CurrentDate()
	insertKey := "mp_isv:store:" + yearStr + monthStr + dayStr

	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)

	cmf.NewRedisDb().ExpireAt(insertKey, today)
	val := util.SetIncr(insertKey)
	numIdStr := strconv.FormatInt(val, 10)
	nStr := "10" + yearStr + monthStr + dayStr + numIdStr

	n, err := strconv.Atoi(nStr)
	if err != nil {
		rest.rc.Error(c, "门店编号生成出错，请联系管理员！", err.Error())
		return
	}

	storeNumber := util.EncodeId(uint64(n))

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

	region := ginModel.Region{}
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

	// 支持场景
	scene := c.PostForm("scene")
	sceneInt, err := strconv.Atoi(scene)
	if err != nil {
		rest.rc.Error(c, "场景参数非法！", nil)
		return
	}

	// 是否歇业
	isClosure := c.PostForm("is_closure")
	isClosureInt, err := strconv.Atoi(isClosure)
	if err != nil {
		rest.rc.Error(c, "歇业格式不正确！", nil)
		return
	}

	// 启用桌号
	useDesk := c.PostForm("use_desk")
	useDeskInt, err := strconv.Atoi(useDesk)
	if err != nil {
		rest.rc.Error(c, "启用桌号点餐格式不正确！", nil)
		return
	}

	// 启用堂食预约
	useAppointment := c.PostForm("use_appointment")
	useAppointmentInt, err := strconv.Atoi(useAppointment)
	if err != nil {
		rest.rc.Error(c, "启用堂食预约格式不正确！", nil)
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
	fmt.Println("storeHours", storeHours)

	if len(storeHours) == 0 && len(storeHours) > 2 {
		rest.rc.Error(c, "营业时间长度非法！", nil)
		return
	}

	// 公告通知
	notice := c.PostForm("notice")

	store := model.Store{
		Mid:            midInt,
		StoreNumber:    storeNumber,
		StoreName:      storeName,
		Phone:          phone,
		ContactPerson:  contactPerson,
		Province:       provinceInt,
		ProvinceName:   provinceName,
		City:           cityInt,
		CityName:       cityName,
		District:       districtInt,
		DistrictName:   districtName,
		Address:        address,
		Scene:          sceneInt,
		StoreThumbnail: storeThumbnail,
		Longitude:      longitudeFloat,
		Latitude:       latitudeFloat,
		IsClosure:      isClosureInt,
		UseDesk:        useDeskInt,
		UseAppointment: useAppointmentInt,
		Notice:         notice,
		CreateAt:       time.Now().Unix(),
		UpdateAt:       time.Now().Unix(),
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
// @Produce json
// @Success 200 {object} storeIndexDel "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/store/index/{id} [delete]
func (rest IndexController) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
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
