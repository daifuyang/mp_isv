/**
** @创建时间: 2020/10/30 3:30 下午
** @作者　　: return
** @描述　　: 菜品分类模型
 */
package model

import (
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type FoodCategory struct {
	StoreId int `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	FoodCategoryStoreHouse
	Db *gorm.DB `gorm:"-" json:"-"`
}

type FoodCategoryStoreHouse struct {
	Id         int               `json:"id"`
	Mid        int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	Name       string            `gorm:"type:varchar(20);comment:菜品分类名称;not null" json:"name"`
	Icon       string            `gorm:"type:varchar(20);comment:菜品分类推荐图标;default:null" json:"icon"`
	IsRequired int               `gorm:"type:tinyint(3);comment:是否必选品（0=>否，1=>是）;not null;default:0" json:"is_required"`
	Scene      int               `gorm:"type:tinyint(3);comment:支持场景（0 =>全部；1=>堂食；2=>外卖）;default:0;not null" json:"scene"`
	Count      int               `gorm:"type:int(11);comment:商品数量;not null;default:0" json:"count"`
	CreateAt   int64             `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt   int64             `gorm:"type:bigint(20)" json:"update_at"`
	CreateTime string            `gorm:"-" json:"create_time"`
	UpdateTime string            `gorm:"-" json:"update_time"`
	DeleteAt   int64             `gorm:"type:bigint(20);comment:'删除时间';default:0" json:"delete_at"`
	Status     int               `gorm:"type:tinyint(3);comment:菜品分类状态（0 => 下架,1 => 上架）;default:1;not null" json:"status"`
	ListOrder  float64           `gorm:"type:float(10);comment:排序;default:10000;not null" json:"list_order"`
	paginate   cmfModel.Paginate `gorm:"-"`
	Db         *gorm.DB          `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 自动数据库迁移
 * @Date 2020/10/30 21:08:10
 * @Param
 * @return
 **/
func (model FoodCategory) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&FoodCategoryStoreHouse{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看分类
 * @Date 2020/11/1 17:28:14
 * @Param
 * @return
 **/
func (model FoodCategory) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var foodCategory []FoodCategory
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&foodCategory).Order("list_order desc,id desc").Count(&total)
	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("list_order desc,id desc").Find(&foodCategory)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	type temp struct {
		FoodCategory
		Store interface{} `json:"store"`
	}

	var data = make([]temp, len(foodCategory))

	for k, v := range foodCategory {

		v.CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		v.UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")

		data[k] = temp{
			FoodCategory: v,
		}
	}

	paginate := cmfModel.Paginate{Data: data, Current: current, PageSize: pageSize, Total: total}
	if len(foodCategory) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看全部分类
 * @Date 2020/11/1 17:28:14
 * @Param
 * @return
 **/

type FoodCategoryTemp struct {
	FoodCategory FoodCategory `json:"food_category"`
	Store        interface{}  `json:"store"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取门店列表
 * @Date 2020/11/24 22:06:11
 * @Param
 * @return
 **/
func (model FoodCategory) List(query []string, queryArgs []interface{}) ([]FoodCategoryTemp, error) {

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var foodCategory []FoodCategory
	var foodCategoryTemp []FoodCategoryTemp

	result := cmf.NewDb().Where(queryStr, queryArgs...).Order("list_order desc,id desc").Find(&foodCategory)

	if result.Error != nil {
		return foodCategoryTemp, result.Error
	}

	var data = make([]FoodCategoryTemp, len(foodCategory))

	for k, v := range foodCategory {

		v.CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		v.UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")

		data[k] = FoodCategoryTemp{
			FoodCategory: v,
		}
	}

	return data, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据门店获取全部分类
 * @Date 2020/11/24 22:12:34
 * @Param
 * @return
 **/
func (model FoodCategory) ListByStore(query []string, queryArgs []interface{}) ([]FoodCategory, error) {

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var foodCategory []FoodCategory

	result := cmf.NewDb().Where(queryStr, queryArgs...).Order("list_order desc, id desc").Find(&foodCategory)

	if result.Error != nil {
		return foodCategory, result.Error
	}

	for k, v := range foodCategory {
		foodCategory[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		foodCategory[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	return foodCategory, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取分类列表 （分类条件）
 * @Date 2020/12/1 18:13:28
 * @Param
 * @return
 **/
func (model FoodCategory) ListByFood(query []string, queryArgs []interface{}) ([]FoodCategory, error) {

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var foodCategory []FoodCategory

	prefix := cmf.Conf().Database.Prefix

	table := cmf.NewDb().Statement.Table
	fmt.Println("table", table)

	result := cmf.NewDb().Table(prefix+"food_category fc").Select("fc.*").
		Joins("INNER JOIN "+prefix+"food_category_post cp ON fc.id = cp.food_category_id").
		Joins("INNER JOIN "+prefix+"food f ON f.id = cp.food_id").
		Where(queryStr, queryArgs...).Find(&foodCategory)

	if result.Error != nil {
		cmfLog.Error(result.Error.Error())
		return foodCategory, result.Error
	}

	for k, v := range foodCategory {
		foodCategory[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		foodCategory[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	return foodCategory, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看一条菜单分类
 * @Date 2020/11/1 18:02:22
 * @Param
 * @return
 **/
func (model FoodCategory) Show(query []string, queryArgs []interface{}) (FoodCategory, error) {

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, "0")
	queryStr := strings.Join(query, " AND ")
	foodCategory := FoodCategory{}
	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&foodCategory)
	if result.Error != nil {
		return foodCategory, result.Error
	}
	return foodCategory, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新一条菜单分类
 * @Date 2020/11/1 18:02:28
 * @Param
 * @return
 **/
func (model FoodCategory) Edit(query []string, queryArgs []interface{}) (FoodCategory, error) {

	queryStr := strings.Join(query, " AND ")
	foodCategory := FoodCategory{}
	result := cmf.NewDb().Where(queryStr, queryArgs...).First(&foodCategory)
	if result.Error != nil {
		return foodCategory, errors.New("当前菜单不存在！")
	}
	result = cmf.NewDb().Save(&model)
	if result != nil {
		return foodCategory, result.Error
	}
	return foodCategory, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增一条菜单分类
 * @Date 2020/11/1 18:03:30
 * @Param
 * @return
 **/

func (model FoodCategory) Store() (FoodCategory, error) {

	db := cmf.Db()
	if model.Db != nil {
		db = model.Db
	}

	category := FoodCategory{}

	query := []string{"mid = ?", "name = ?"}
	queryArgs := []interface{}{model.Mid, model.Name}

	category, err := category.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return category, err
	}

	if category.Id == 0 {
		result := db.Create(&model)
		if result.Error != nil {
			return category, result.Error
		}
	} else {
		return category, errors.New("该分类已存在，无需重复添加！")
	}

	return model, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新菜单分类
 * @Date 2020/11/13 14:59:14
 * @Param
 * @return
 **/
func (model FoodCategory) Update() (FoodCategory, error) {

	db := cmf.Db()
	if model.Db != nil {
		db = model.Db
	}

	result := db.Save(&model)
	if result.Error != nil {
		return FoodCategory{}, result.Error
	}

	return model, nil

}
