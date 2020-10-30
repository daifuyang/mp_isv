/**
** @创建时间: 2020/10/30 3:06 下午
** @作者　　: return
** @描述　　: 菜品表
 */
package model

import (
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
)

type Food struct {
	Id            int               `json:"id"`
	FoodNumber    string            `gorm:"type:varchar(32);comment:菜品唯一编号;not null" json:"food_number"`
	Name          string            `gorm:"type:varchar(255);comment:菜品名称;not null" json:"name"`
	OriginalPrice float64           `gorm:"type:decimal(9,2);comment:菜品原价;not null" json:"original_price"`
	Price         float64           `gorm:"type:decimal(9,2);comment:菜品售价;not null" json:"price"`
	Thumbnail     string            `gorm:"type:varchar(255);comment:菜品缩略图;not null" json:"thumbnail"`
	IsTakeOut     int               `gorm:"type:tinyint(3);comment:是否支持外卖" json:"is_take_out"`
	IsRecommend   int               `gorm:"type:tinyint(3);comment:是否推荐菜;not null;default:0" json:"is_recommend"`
	CreateAt      int64             `gorm:"type:int(11)" json:"create_at"`
	UpdateAt      int64             `gorm:"type:int(11)" json:"update_at"`
	DeleteAt      int64             `gorm:"type:int(10);comment:'删除时间';default:0" json:"delete_at"`
	Status        int               `gorm:"type:tinyint(3);comment:菜品状态;" json:"status"`
	paginate      cmfModel.Paginate `gorm:"-"`
}

type FoodCategoryPost struct {
	Id             int   `json:"id"`
	FoodId         int   `gorm:"type:bigint(20)" json:"food_id"`
	FoodCategoryId int   `gorm:"type:bigint(20)" json:"food_category_id"`
	StoreId        int   `gorm:"type:bigint(20)" json:"store_id"`
	CreateAt       int64 `gorm:"type:int(11)" json:"create_at"`
	UpdateAt       int64 `gorm:"type:int(11)" json:"update_at"`
	Status         int   `gorm:"type:tinyint(3);comment:菜品状态;" json:"status"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜品模型自动数据库迁移
 * @Date 2020/10/30 21:56:02
 * @Param
 * @return
 **/
func (model *Food) AutoMigrate() {
	cmf.Db.AutoMigrate(&model)
	cmf.Db.AutoMigrate(&FoodCategoryPost{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜品模型指定数据库迁移
 * @Date 2020/10/30 21:56:20
 * @Param
 * @return
 **/
func (model *Food) ManualMigrate(db *gorm.DB) {
	db.AutoMigrate(&model)
	db.AutoMigrate(&FoodCategoryPost{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部菜品列表
 * @Date 2020/10/30 22:55:02
 * @Param
 * @return
 **/
func (model *Food) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	intCurrent, intPageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	current := strconv.Itoa(intCurrent)
	pageSize := strconv.Itoa(intPageSize)

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var food []Food
	cmf.Db.Where(queryStr, queryArgs...).Find(&food).Count(&total)
	result := cmf.Db.Where(queryStr, queryArgs...).Limit(intPageSize).Offset((intCurrent - 1) * intPageSize).Find(&food)

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	paginate := cmfModel.Paginate{Data: food, Current: current, PageSize: pageSize, Total: total}
	if len(food) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil
}
