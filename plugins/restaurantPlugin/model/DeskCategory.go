/**
** @创建时间: 2020/11/1 1:26 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
)

type DeskCategory struct {
	Id           int               `json:"id"`
	Mid          int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId      int               `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	CategoryName string            `gorm:"type:varchar(20);comment:座位名称;;not null" json:"category_name"`
	LeastSeats   int               `gorm:"type:int(2);comment:最少人数;not null" json:"least_seats"`
	MaximumSeats int               `gorm:"type:int(2);comment:最多人数;not null" json:"maximum_seats"`
	paginate     cmfModel.Paginate `gorm:"-"`
}

type DeskCategoryStorePost struct{}

func (model DeskCategory) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&DeskCategoryStorePost{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询全部类别（分页）
 * @Date 2020/11/10 15:33:07
 * @Param
 * @return
 **/

func (model DeskCategory) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var deskCategory []DeskCategory

	var total int64 = 0
	cmf.NewDb().Model(deskCategory).Select("id").Where(queryStr, queryArgs...).Count(&total)

	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&deskCategory)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	paginate := cmfModel.Paginate{Data: deskCategory, Current: current, PageSize: pageSize, Total: total}
	if len(deskCategory) == 0 {
		paginate.Data = make([]string, 0)
	}
	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询单个
 * @Date 2020/11/10 14:18:35
 * @Param
 * @return
 **/
func (model DeskCategory) Show(query []string, queryArgs []interface{}) (DeskCategory, error) {

	category := DeskCategory{}
	queryStr := strings.Join(query, " AND ")
	result := cmf.NewDb().Debug().Where(queryStr, queryArgs...).First(&category)
	if result.Error != nil {
		return category, result.Error
	}
	return category, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增桌位类型
 * @Date 2020/11/10 14:17:33
 * @Param
 * @return
 **/

func (model DeskCategory) Store() (DeskCategory, error) {

	category := DeskCategory{}

	var err error
	query := []string{"mid = ? AND category_name = ?"}
	queryArgs := []interface{}{model.Mid, model.CategoryName}

	category, err = category.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return category, err
	}

	if category.Id == 0 {
		result := cmf.NewDb().Create(&model)
		if result.Error != nil {
			fmt.Println("err", result.Error)
			return category, result.Error
		}
	} else {
		return category, errors.New("该分类已存在，无需重复添加！")
	}

	return model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新单个
 * @Date 2020/11/10 16:34:13
 * @Param
 * @return
 **/

func (model DeskCategory) Update() (DeskCategory, error) {
	query := []string{"mid = ?", "id = ?"}
	queryArgs := []interface{}{model.Mid, model.Id}

	category, err := model.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return category, err
	}

	if category.Id == 0 {
		return category, errors.New("该分类不存在！")
	}

	result := cmf.NewDb().Save(&model)
	if result.Error != nil {
		return category, result.Error
	}

	return model, nil
}
