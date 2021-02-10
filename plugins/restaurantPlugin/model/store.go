/**
** @创建时间: 2020/10/30 9:08 下午
** @作者　　: return
** @描述　　: 门店数据库模型
 */
package model

import (
	"encoding/json"
	"errors"
	"fmt"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

// 门店信息表
type Store struct {
	Id               int               `json:"id,omitempty"`
	OrderId          string            `gorm:"type:varchar(64);comment:申请单id;not null" json:"order_id"`
	Mid              int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreNumber      int               `gorm:"type:int(11);comment:门店唯一编号;not null" json:"store_number"`
	StoreName        string            `gorm:"type:varchar(32);comment:门店名称;not null" json:"store_name"`
	StoreType        string            `gorm:"type:tinyint(3);comment:门店类型（1：直营，2：加盟）;not null" json:"store_type"`
	TopCategory      string            `gorm:"type:varchar(10);comment:所属门店顶级id;not null" json:"top_category"`
	ShopCategory     string            `gorm:"type:varchar(10);comment:所属门店id;not null" json:"shop_category"`
	Phone            string            `gorm:"type:varchar(20);comment:联系电话;not null" json:"phone"`
	ContactPerson    string            `gorm:"type:varchar(20);comment:联系人名称;not null" json:"contact_person"`
	Province         int               `gorm:"type:int(11);comment:省份id;not null" json:"province"`
	ProvinceName     string            `gorm:"type:varchar(20);comment:省份名称;not null" json:"province_name"`
	City             int               `gorm:"type:int(11);comment:市区id;not null" json:"city"`
	CityName         string            `gorm:"type:varchar(20);comment:市区名称;not null" json:"city_name"`
	District         int               `gorm:"type:int(11);comment:县区id;not null" json:"district"`
	DistrictName     string            `gorm:"type:varchar(20);comment:县区名称;not null" json:"district_name"`
	Address          string            `gorm:"type:varchar(255);comment:详细地址;not null" json:"address"`
	StoreThumbnail   string            `gorm:"type:varchar(255);comment:门头照片" json:"store_thumbnail"`
	Longitude        float64           `gorm:"type:decimal(10,7);comment:经度;not null" json:"longitude"`
	Latitude         float64           `gorm:"type:decimal(10,7);comment:纬度;not null" json:"latitude"`
	IsClosure        int               `gorm:"type:tinyint(3);comment:是否歇业;not null;default:0" json:"is_closure"`
	Notice           string            `gorm:"type:varchar(255);comment:公告通知" json:"notice"`
	CreateAt         int64             `gorm:"type:int(11)" json:"create_at"`
	UpdateAt         int64             `gorm:"type:int(11)" json:"update_at"`
	DeleteAt         int64             `gorm:"type:int(10);comment:删除时间;default:0" json:"delete_at"`
	AuditStatus      string            `gorm:"type:varchar(20);comment:审核状态(passed:通过,rejected:拒绝,wait:审核中);default:wait;not null" json:"audit_status"`
	Reason           string            `gorm:"type:varchar(255);comment:拒绝愿意" json:"reason"`
	CreateTime       string            `gorm:"-" json:"create_time"`
	UpdateTime       string            `gorm:"-" json:"update_time"`
	DeliveryDistance float64           `gorm:"-" json:"delivery_distance"`
	Distance         float64           `gorm:"->" json:"distance"`
	OutRange         bool              `gorm:"-" json:"out_range"`
	StoreHours       []sHours          `gorm:"-" json:"store_hours"`
	EatIn            EatIn             `gorm:"-" json:"eat_in"`
	TakeOut          TakeOut           `gorm:"-" json:"take_out"`
	paginate         cmfModel.Paginate `gorm:"-"`
}

type sHours struct {
	StartTime string `json:"start_time"`
	EndTime   string `json:"end_time"`
}

// 门店营业表
type StoreHours struct {
	Mid       int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId   int    `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	Mon       int    `gorm:"type:tinyint(3);comment:周一启用状态" json:"mon"`
	Tues      int    `gorm:"type:tinyint(3);comment:周二启用状态" json:"tues"`
	Wed       int    `gorm:"type:tinyint(3);comment:周三启用状态" json:"wed"`
	Thur      int    `gorm:"type:tinyint(3);comment:周四启用状态" json:"thur"`
	Fri       int    `gorm:"type:tinyint(3);comment:周五启用状态" json:"fri"`
	Sat       int    `gorm:"type:tinyint(3);comment:周六启用状态" json:"sat"`
	Sun       int    `gorm:"type:tinyint(3);comment:周日启用状态" json:"sun"`
	StartTime string `gorm:"type:varchar(10);comment:开始时间" json:"start_time"`
	EndTime   string `gorm:"type:varchar(10);comment:结束时间" json:"end_time"`
	AllTime   int    `gorm:"type:tinyint(3);comment:24小时营业" json:"all_time"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/11/2 11:28:13
 * @Param
 * @return
 **/
func (model *Store) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&StoreHours{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据条件查看全部的门店分页
 * @Date 2020/11/2 10:21:30
 * @Param
 * @return
 **/
func (model *Store) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var store []Store
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&store).Count(&total)
	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&store)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	if len(store) > 0 {

		// 获取当前堂食配置
		takeJson := saasModel.Options("take_out", store[0].Mid)
		var takeOut TakeOut

		_ = json.Unmarshal([]byte(takeJson), &takeOut)

		for k, v := range store {
			store[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
			store[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
			store[k].DeliveryDistance = takeOut.DeliveryDistance
			// 超出距离
			if v.Distance > takeOut.DeliveryDistance {
				store[k].OutRange = true
			}

		}

	}

	paginate := cmfModel.Paginate{Data: store, Current: current, PageSize: pageSize, Total: total}
	if len(store) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取门店数
 * @Date 2020/12/4 16:22:19
 * @Param
 * @return
 **/

func (model *Store) IndexWithFoodCount(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	var store []Store
	cmf.NewDb().Table(prefix+"store s").Select("s.*").Where(queryStr, queryArgs...).Find(&store).Count(&total)
	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&store)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	type tempResult struct {
		Store
		Count      int64 `json:"count"`
		SalesCount int64 `json:"sales_count"`
	}

	var tempStruct []tempResult

	var (
		count      int64 = 0
		salesCount int64 = 0
	)
	for _, v := range store {
		v.CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		v.UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")

		cmf.NewDb().Model(&Food{}).Where("store_id = ?", v.Id).Count(&count)
		cmf.NewDb().Model(&Food{}).Where("store_id = ? AND status = 1", v.Id).Count(&salesCount)
		tempStruct = append(tempStruct, tempResult{
			Store:      v,
			Count:      count,
			SalesCount: salesCount,
		})
	}

	paginate := cmfModel.Paginate{Data: tempStruct, Current: current, PageSize: pageSize, Total: total}
	if len(store) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部门店列表
 * @Date 2020/11/10 13:34:25
 * @Param
 * @return
 **/

func (model *Store) List(query []string, queryArgs []interface{}) ([]Store, error) {

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var store []Store
	result := cmf.NewDb().Where(queryStr, queryArgs...).Find(&store)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return store, result.Error
	}

	for k, v := range store {
		createTime := time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		store[k].CreateTime = createTime

		updateTime := time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
		store[k].UpdateTime = updateTime

	}

	return store, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据经纬度排序
 * @Date 2020/11/24 15:45:30
 * @Param
 * @return
 **/

func (model *Store) ListByDistance(query []string, queryArgs []interface{}) ([]Store, error) {

	longitude := model.Longitude
	latitude := model.Latitude

	lon := strconv.FormatFloat(longitude, 'f', -1, 64)
	lat := strconv.FormatFloat(latitude, 'f', -1, 64)

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var store = make([]Store, 0)
	result := cmf.NewDb().Model(&Store{}).Select("*", "(st_distance (point (longitude,latitude),point ("+lon+","+lat+"))*111195/1000 ) as distance").
		Where(queryStr, queryArgs...).Order("distance ASC").Scan(&store)

	if result.Error != nil {
		return store, result.Error
	}

	if len(store) > 0 {
		// 获取当前堂食配置

		sHours := StoreHours{}
		storeHours, err := sHours.AllHours()

		if err != nil {
			return store, err
		}

		for k, v := range store {

			store[k].Id = 0

			createTime := time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
			store[k].CreateTime = createTime

			updateTime := time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
			store[k].UpdateTime = updateTime

			// 获取营业时间
			hours := model.hoursInStore(v.Mid, v.Id, storeHours)
			store[k].StoreHours = hours

			// 歇业状态
			if v.IsClosure == 0 {
				// 获取当前时间戳

				now := time.Now()
				var todayEnd time.Time

				year, month, day := now.Date()

				for _, v := range hours {

					t := strings.Split(v.EndTime, ":")
					hour := 00
					min := 00
					if len(t) == 2 {
						hour, _ = strconv.Atoi(t[0])
						min, _ = strconv.Atoi(t[1])
					}

					end := time.Date(year, month, day, hour, min, 00, 00, time.Local)

					// 更新最晚时间
					if end.Sub(todayEnd) > 0 {
						todayEnd = end
					}
				}

				// 改为歇业状态
				if todayEnd.Sub(now) < 0 {
					store[k].IsClosure = 1
				}

			}

			eatIn, _ := new(EatIn).Show(v.Id, v.Mid)
			takeOut, _ := new(TakeOut).Show(v.Id, v.Mid)

			store[k].EatIn = eatIn
			store[k].TakeOut = takeOut

			// 超出距离
			if v.Distance > takeOut.DeliveryDistance {
				store[k].OutRange = true
			}

			store[k].DeliveryDistance = takeOut.DeliveryDistance

		}
	}

	return store, nil
}

func (model *Store) hoursInStore(mid int, storeId int, storeHours []StoreHours) []sHours {

	var sh []sHours

	for _, v := range storeHours {
		if mid == v.Mid && storeId == v.StoreId {

			t := time.Now()
			hourItem := sHours{}

			switch int(t.Weekday()) {
			case 0:
				if v.Sun == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 1:
				if v.Mon == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 2:
				if v.Sun == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 3:
				if v.Wed == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 4:
				if v.Thur == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 5:
				if v.Fri == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			case 6:
				if v.Sat == 1 {
					hourItem = sHours{
						StartTime: v.StartTime,
						EndTime:   v.EndTime,
					}
				}
			}

			if v.AllTime == 1 {
				hourItem = sHours{
					StartTime: "00:00",
					EndTime:   "23:59",
				}
			}

			sh = append(sh, hourItem)

		}
	}

	return sh

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单个门店
 * @Date 2020/11/10 12:06:53
 * @Param
 * @return
 **/

func (model Store) Show(query []string, queryArgs []interface{}) (Store, error) {

	longitude := model.Longitude
	latitude := model.Latitude

	lon := strconv.FormatFloat(longitude, 'f', -1, 64)
	lat := strconv.FormatFloat(latitude, 'f', -1, 64)

	store := Store{}
	queryStr := strings.Join(query, " AND ")
	result := cmf.NewDb().Select("*", "(st_distance (point (longitude,latitude),point ("+lon+","+lat+"))*111195/1000 ) as distance").Where(queryStr, queryArgs...).First(&store)

	if result.Error != nil {
		return store, result.Error
	}

	// 获取当前堂食配置
	eatIn, _ := new(EatIn).Show(store.Id, store.Mid)
	takeOut, _ := new(TakeOut).Show(store.Id, store.Mid)

	store.EatIn = eatIn
	store.TakeOut = takeOut

	store.DeliveryDistance = takeOut.DeliveryDistance
	store.CreateTime = time.Unix(store.CreateAt, 0).Format(data.TimeLayout)
	store.UpdateTime = time.Unix(store.UpdateAt, 0).Format(data.TimeLayout)

	return store, nil
}

// 小程序显示歇业状态
func (model Store) AppShow(query []string, queryArgs []interface{}) (Store, error) {

	store, err := model.Show(query, queryArgs)
	if err != nil {
		return store, err
	}

	sHours := StoreHours{}
	storeHours, err := sHours.AllHours()

	createTime := time.Unix(store.CreateAt, 0).Format("2006-01-02 15:04:05")
	store.CreateTime = createTime

	updateTime := time.Unix(store.UpdateAt, 0).Format("2006-01-02 15:04:05")
	store.UpdateTime = updateTime

	// 获取营业时间
	hours := model.hoursInStore(store.Mid, store.Id, storeHours)
	store.StoreHours = hours

	// 歇业状态
	if store.IsClosure == 0 {
		// 获取当前时间戳

		now := time.Now()
		var todayEnd time.Time

		year, month, day := now.Date()

		for _, v := range hours {

			t := strings.Split(v.EndTime, ":")
			hour := 00
			min := 00
			if len(t) == 2 {
				hour, _ = strconv.Atoi(t[0])
				min, _ = strconv.Atoi(t[1])
			}

			end := time.Date(year, month, day, hour, min, 00, 00, time.Local)

			// 更新最晚时间
			if end.Sub(todayEnd) > 0 {
				todayEnd = end
			}
		}

		// 改为歇业状态

		if todayEnd.Sub(now) < 0 {
			store.IsClosure = 1
		}
		if err != nil {
			return store, err
		}
	}

	// 获取当前堂食配置
	takeJson := saasModel.Options("take_out", store.Mid)

	var takeOut TakeOut

	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	store.DeliveryDistance = takeOut.DeliveryDistance

	if store.Distance > store.DeliveryDistance {
		store.OutRange = true
	}

	store.CreateTime = time.Unix(store.CreateAt, 0).Format(data.TimeLayout)
	store.UpdateTime = time.Unix(store.UpdateAt, 0).Format(data.TimeLayout)

	store.Id = 0

	return store, nil
}

// 是否超距离
func (model Store) OutRangeStatus() (bool, error) {

	var query = []string{"id = ? AND mid = ? AND delete_at = ?"}
	var queryArgs = []interface{}{model.Id, model.Mid, 0}

	store, err := model.Show(query, queryArgs)
	if err != nil {
		return false, err
	}

	// 获取当前堂食配置
	takeJson := saasModel.Options("take_out", store.Mid)

	var takeOut TakeOut

	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	store.DeliveryDistance = takeOut.DeliveryDistance

	if store.Distance > store.DeliveryDistance {
		return true, nil
	}
	return false, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个门店
 * @Date 2020/11/2 10:22:09
 * @Param
 * @return
 **/

func (model Store) Store() (Store, error) {

	query := []string{"mid = ?", "store_name = ?"}
	queryArgs := []interface{}{model.Mid, model.StoreName}

	store, err := model.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return store, err
	}
	if store.Id == 0 {

		result := cmf.NewDb().Create(&model)
		if result.Error != nil {
			fmt.Println("err", result.Error)
			return store, result.Error
		}
	} else {
		return store, errors.New("该门店已存在，无需重复添加！")
	}
	return model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新门店
 * @Date 2020/11/10 12:48:29
 * @Param
 * @return
 **/

func (model Store) Update() (Store, error) {
	query := []string{"mid = ?", "id = ?"}
	queryArgs := []interface{}{model.Mid, model.Id}

	store, err := model.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return store, err
	}

	if store.Id == 0 {
		return store, errors.New("该门店不存在！")
	}

	result := cmf.NewDb().Save(&model)
	if result.Error != nil {
		return Store{}, result.Error
	}

	return model, nil

}

func (model *StoreHours) AllHours() ([]StoreHours, error) {

	var sh []StoreHours
	result := cmf.NewDb().Find(&sh)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return sh, result.Error
	}

	return sh, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取当前门店营业时间
 * @Date 2020/11/10 13:04:16
 * @Param
 * @return
 **/
func (model *StoreHours) Hours() ([]StoreHours, error) {
	storeId := model.StoreId
	mid := model.Mid

	var sh []StoreHours
	result := cmf.NewDb().Where("store_id = ? AND mid = ?", storeId, mid).Find(&sh)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return sh, result.Error
	}

	return sh, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 添加时间段
 * @Date 2020/11/10 12:06:43
 * @Param
 * @return
 **/
func (model *StoreHours) AddHours(hours []StoreHours) ([]StoreHours, error) {

	storeId := model.StoreId
	mid := model.Mid
	for k := range hours {
		hours[k].Mid = mid
		hours[k].StoreId = storeId
	}

	var sh []StoreHours
	result := cmf.NewDb().Where("store_id = ? AND mid = ?", storeId, mid).Find(&sh)

	// 删除历史营业时间
	if result.RowsAffected > 0 {
		cmf.NewDb().Where("store_id = ? AND mid = ?", storeId, mid).Delete(&StoreHours{})
	}

	// 新增营业时间
	result = cmf.NewDb().Create(&hours)
	if result.Error != nil {
		return []StoreHours{}, nil
	}
	return hours, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一个门店
 * @Date 2020/11/10 13:22:29
 * @Param
 * @return
 **/
