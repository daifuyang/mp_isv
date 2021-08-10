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
	Id               int               `json:"id"`
	OrderId          string            `gorm:"type:varchar(64);comment:申请单id;not null" json:"order_id"`
	Mid              int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreNumber      int               `gorm:"type:int(11);comment:门店唯一编号;not null" json:"store_number"`
	ShopId           string            `gorm:"type:varchar(32);comment:蚂蚁店铺id" json:"shop_id"`
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
	EnabledSellClear int               `gorm:"type:tinyint(3);comment:启用沽清;not null;default:0" json:"enabled_sell_clear"`
	SellClear        string            `gorm:"type:varchar(10);comment:自定义沽清时间" json:"sell_clear"`
	Notice           string            `gorm:"type:varchar(255);comment:公告通知" json:"notice"`
	CreateAt         int64             `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt         int64             `gorm:"type:bigint(20)" json:"update_at"`
	DeleteAt         int64             `gorm:"type:bigint(20);comment:删除时间;default:0" json:"delete_at"`
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
	Db               *gorm.DB          `gorm:"-" json:"-"`
}

type sHours struct {
	StartTime string `json:"start_time"`
	EndTime   string `json:"end_time"`
}

// 门店营业表
type StoreHours struct {
	Mid       int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId   int      `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	Mon       int      `gorm:"type:tinyint(3);comment:周一启用状态" json:"mon"`
	Tues      int      `gorm:"type:tinyint(3);comment:周二启用状态" json:"tues"`
	Wed       int      `gorm:"type:tinyint(3);comment:周三启用状态" json:"wed"`
	Thur      int      `gorm:"type:tinyint(3);comment:周四启用状态" json:"thur"`
	Fri       int      `gorm:"type:tinyint(3);comment:周五启用状态" json:"fri"`
	Sat       int      `gorm:"type:tinyint(3);comment:周六启用状态" json:"sat"`
	Sun       int      `gorm:"type:tinyint(3);comment:周日启用状态" json:"sun"`
	StartTime string   `gorm:"type:varchar(10);comment:开始时间" json:"start_time"`
	EndTime   string   `gorm:"type:varchar(10);comment:结束时间" json:"end_time"`
	AllTime   int      `gorm:"type:tinyint(3);comment:24小时营业" json:"all_time"`
	Db        *gorm.DB `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/11/2 11:28:13
 * @Param
 * @return
 **/
func (model *Store) AutoMigrate() {
	model.Db.AutoMigrate(&model)
	model.Db.AutoMigrate(&StoreHours{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据条件查看全部的门店分页
 * @Date 2020/11/2 10:21:30
 * @Param
 * @return
 **/
func (model *Store) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	db := model.Db
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
	db.Where(queryStr, queryArgs...).Find(&store).Count(&total)
	result := db.Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&store)

	fmt.Println("store", store)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	if len(store) > 0 {

		// 获取当前堂食配置
		takeJson, err := saasModel.Options(model.Db, "take_out", store[0].Mid)

		if err != nil {
			return cmfModel.Paginate{}, err
		}

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

	db := model.Db
	
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
	db.Table(prefix+"store s").Select("s.*").Where(queryStr, queryArgs...).Find(&store).Count(&total)
	result := db.Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&store)

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

		db.Model(&Food{}).Where("store_id = ? AND  delete_at = 0", v.Id).Count(&count)
		db.Model(&Food{}).Where("store_id = ? AND status = 1 AND  delete_at = 0", v.Id).Count(&salesCount)
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

	db := model.Db
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var store []Store
	result := db.Where(queryStr, queryArgs...).Find(&store)

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

	db := model.Db

	longitude := model.Longitude
	latitude := model.Latitude

	lon := strconv.FormatFloat(longitude, 'f', -1, 64)
	lat := strconv.FormatFloat(latitude, 'f', -1, 64)

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, 0)
	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var store = make([]Store, 0)
	result := db.Model(&Store{}).Select("*", "(round(st_distance_sphere(point (longitude,latitude),point ("+lon+","+lat+"))/1000,2)) AS distance").
		Where(queryStr, queryArgs...).Order("is_closure ASC,distance ASC").Scan(&store)

	if result.Error != nil {
		return store, result.Error
	}

	if len(store) > 0 {
		// 获取当前堂食配置

		sHours := StoreHours{
			Db: db,
		}
		storeHours, err := sHours.AllHours()

		if err != nil {
			return store, err
		}

		for k, v := range store {

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

					startDur := strings.Split(v.StartTime, ":")
					sh := 00
					sm := 00
					if len(startDur) == 2 {
						sh, _ = strconv.Atoi(startDur[0])
						sm, _ = strconv.Atoi(startDur[1])
					} else {
						store[k].IsClosure = 1
					}

					start := time.Date(year, month, day, sh, sm, 00, 00, time.Local)

					// 更新最早时间
					fmt.Println(start, now)
					if start.Sub(now) > 0 {
						store[k].IsClosure = 1
					}

					t := strings.Split(v.EndTime, ":")
					hour := 00
					min := 00
					if len(t) == 2 {
						hour, _ = strconv.Atoi(t[0])
						min, _ = strconv.Atoi(t[1])
					} else {
						store[k].IsClosure = 1
					}

					end := time.Date(year, month, day, hour, min, 00, 00, time.Local)

					// 更新最晚时间

					if end.Sub(todayEnd) > 0 {
						todayEnd = end
					}
				}

				// 改为歇业状态

				fmt.Println(todayEnd, now)
				if todayEnd.Sub(now) < 0 {
					store[k].IsClosure = 1
				}

			}

			eatIn := EatIn{
				Db: db,
			}
			eatIn, _ = eatIn.Show(v.Id, v.Mid)

			takeOut := TakeOut{
				Db: db,
			}
			takeOut, _ = takeOut.Show(v.Id, v.Mid)

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
			var hourItem = sHours{}

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

			if hourItem.StartTime != "" && hourItem.EndTime != "" {
				sh = append(sh, hourItem)
			}

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

	db := model.Db

	longitude := model.Longitude
	latitude := model.Latitude

	lon := strconv.FormatFloat(longitude, 'f', -1, 64)
	lat := strconv.FormatFloat(latitude, 'f', -1, 64)

	store := Store{}
	queryStr := strings.Join(query, " AND ")
	result := db.Select("*", "(round(st_distance_sphere(point (longitude,latitude),point ("+lon+","+lat+"))/1000,2)) AS distance").Where(queryStr, queryArgs...).First(&store)

	if result.Error != nil {
		return store, result.Error
	}

	// 获取当前堂食配置

	eatInModel := EatIn{
		Db: db,
	}

	eatIn, _ := eatInModel.Show(store.Id, store.Mid)


	TakeOutModel := TakeOut{
		Db: db,
	}

	takeOut, _ := TakeOutModel.Show(store.Id, store.Mid)

	store.EatIn = eatIn
	store.TakeOut = takeOut

	store.DeliveryDistance = takeOut.DeliveryDistance
	store.CreateTime = time.Unix(store.CreateAt, 0).Format(data.TimeLayout)
	store.UpdateTime = time.Unix(store.UpdateAt, 0).Format(data.TimeLayout)

	return store, nil
}

// 小程序显示歇业状态
func (model Store) AppShow(query []string, queryArgs []interface{}) (Store, error) {

	db := model.Db

	store, err := model.Show(query, queryArgs)
	if err != nil {
		return store, err
	}

	sHours := StoreHours{
		Db: db,
	}
	storeHours, err := sHours.AllHours()

	createTime := time.Unix(store.CreateAt, 0).Format("2006-01-02 15:04:05")
	store.CreateTime = createTime

	updateTime := time.Unix(store.UpdateAt, 0).Format("2006-01-02 15:04:05")
	store.UpdateTime = updateTime

	// 获取营业时间
	hours := model.hoursInStore(store.Mid, store.Id, storeHours)
	store.StoreHours = hours

	distance, _ := strconv.ParseFloat(fmt.Sprintf("%.2f", store.Distance), 64)

	store.Distance = distance

	// 歇业状态
	if store.IsClosure == 0 {
		// 获取当前时间戳

		now := time.Now()
		var todayEnd time.Time

		year, month, day := now.Date()

		for _, v := range hours {

			startDur := strings.Split(v.StartTime, ":")
			sh := 00
			sm := 00
			if len(startDur) == 2 {
				sh, _ = strconv.Atoi(startDur[0])
				sm, _ = strconv.Atoi(startDur[1])
			} else {
				store.IsClosure = 1
			}

			start := time.Date(year, month, day, sh, sm, 00, 00, time.Local)

			// 更新最早时间
			if start.Sub(now) > 0 {
				store.IsClosure = 1
			}

			t := strings.Split(v.EndTime, ":")
			hour := 00
			min := 00
			if len(t) == 2 {
				hour, _ = strconv.Atoi(t[0])
				min, _ = strconv.Atoi(t[1])
			} else {
				store.IsClosure = 1
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
	takeJson, err := saasModel.Options(db, "take_out", store.Mid)

	if err != nil {
		return Store{}, err
	}

	var takeOut TakeOut

	_ = json.Unmarshal([]byte(takeJson), &takeOut)

	store.DeliveryDistance = takeOut.DeliveryDistance

	if store.Distance > store.DeliveryDistance {
		store.OutRange = true
	}

	store.CreateTime = time.Unix(store.CreateAt, 0).Format(data.TimeLayout)
	store.UpdateTime = time.Unix(store.UpdateAt, 0).Format(data.TimeLayout)

	return store, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个门店
 * @Date 2020/11/2 10:22:09
 * @Param
 * @return
 **/

func (model Store) Store() (Store, error) {

	db := model.Db

	query := []string{"mid = ?", "store_name = ?"}
	queryArgs := []interface{}{model.Mid, model.StoreName}

	store, err := model.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return store, err
	}
	if store.Id == 0 {

		result := db.Create(&model)
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

	db := model.Db

	query := []string{"mid = ?", "id = ?"}
	queryArgs := []interface{}{model.Mid, model.Id}

	store, err := model.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return store, err
	}

	if store.Id == 0 {
		return store, errors.New("该门店不存在！")
	}

	result := db.Save(&model)
	if result.Error != nil {
		return Store{}, result.Error
	}

	return model, nil

}

func (model *StoreHours) AllHours() ([]StoreHours, error) {

	db := model.Db

	var sh []StoreHours
	result := db.Find(&sh)

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

	db := model.Db

	storeId := model.StoreId
	mid := model.Mid

	var sh []StoreHours
	result := db.Where("store_id = ? AND mid = ?", storeId, mid).Find(&sh)

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

	db := model.Db

	storeId := model.StoreId
	mid := model.Mid

	var addHours = make([]StoreHours, 0)

	for _, v := range hours {

		if !(v.StartTime == "00:00" && v.EndTime == "00:00" && v.AllTime == 0) {
			v.Mid = mid
			v.StoreId = storeId
			addHours = append(addHours, v)
		}

	}

	var sh []StoreHours
	result := db.Where("store_id = ? AND mid = ?", storeId, mid).Find(&sh)

	// 删除历史营业时间
	if result.RowsAffected > 0 {
		db.Where("store_id = ? AND mid = ?", storeId, mid).Delete(&StoreHours{})
	}

	// 新增营业时间
	result = db.Create(&addHours)
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
