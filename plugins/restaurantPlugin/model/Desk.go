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

type Desk struct {
	Id           int               `json:"id"`
	Mid          int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	StoreId      int               `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
	DeskNumber   int               `gorm:"type:bigint(20);comment:桌位编号;not null" json:"desk_number"`
	Name         string            `gorm:"type:varchar(20);comment:座位名称;not null" json:"name"`
	CategoryId   int               `gorm:"type:int(11);comment:对应小程序id;not null" json:"category_id"`
	CategoryName string            `gorm:"type:varchar(20);comment:对应小程序id;not null" json:"category_name"`
	Status       int               `gorm:"type:tinyint(3);comment:桌位状态;default:1;not null" json:"status"`
	ListOrder    float64           `gorm:"type:float;comment:排序;default:10000;not null" json:"list_order"`
	Qrcode       string            `gorm:"-" json:"qrcode"`
	paginate     cmfModel.Paginate `gorm:"-"`
	Db           *gorm.DB          `gorm:"-" json:"-"`
}

type resultDesk struct {
	Desk
	StoreName    string   `json:"store_name"`
	LeastSeats   int      `json:"least_seats"`
	MaximumSeats int      `json:"maximum_seats"`
	Db           *gorm.DB `gorm:"-" json:"-"`
}

func (model Desk) AutoMigrate() {
	model.Db.AutoMigrate(&model)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看列表（分页）
 * @Date 2020/11/10 17:58:58
 * @Param
 * @return
 **/
func (model *Desk) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	db := model.Db
	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	var desk []resultDesk
	db.Table(prefix+"desk d").Select("d.id").
		Joins("INNER JOIN "+prefix+"desk_category dc ON d.category_id = dc.id").
		Joins("INNER JOIN "+prefix+"store s ON s.id = d.store_id").
		Where(queryStr, queryArgs...).Scan(&desk).Count(&total)

	result := db.Table(prefix+"desk d").Select("d.*,s.store_name,dc.least_seats,dc.maximum_seats").
		Joins("INNER JOIN "+prefix+"desk_category dc ON d.category_id = dc.id").
		Joins("INNER JOIN "+prefix+"store s ON s.id = d.store_id").
		Where(queryStr, queryArgs...).
		Limit(pageSize).Offset((current - 1) * pageSize).Scan(&desk)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, result.Error
	}

	paginate := cmfModel.Paginate{Data: desk, Current: current, PageSize: pageSize, Total: total}
	if len(desk) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看列表（不分页）
 * @Date 2020/11/10 17:58:58
 * @Param
 * @return
 **/
func (model *Desk) List(query []string, queryArgs []interface{}) (desk []resultDesk, err error) {

	db := model.Db

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix
	desk = make([]resultDesk, 0)

	result := db.Table(prefix+"desk d").Select("d.*,s.store_name,dc.least_seats,dc.maximum_seats").
		Joins("INNER JOIN "+prefix+"desk_category dc ON d.category_id = dc.id").
		Joins("INNER JOIN "+prefix+"store s ON s.id = d.store_id").
		Where(queryStr, queryArgs...).Scan(&desk)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return desk, result.Error
	}

	return desk, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查看单项
 * @Date 2020/11/10 17:39:02
 * @Param
 * @return
 **/
func (model Desk) Show(query []string, queryArgs []interface{}) (resultDesk, error) {

	db := model.Db

	desk := resultDesk{}
	queryStr := strings.Join(query, " AND ")

	prefix := cmf.Conf().Database.Prefix

	result := db.Table(prefix+"desk d").Select("d.*,dc.least_seats,dc.maximum_seats").
		Joins("INNER JOIN "+prefix+"desk_category dc ON d.category_id = dc.id").
		Where(queryStr, queryArgs...).
		Scan(&desk)

	if result.Error != nil {
		return desk, result.Error
	}

	if desk.Id == 0 {
		return desk, gorm.ErrRecordNotFound
	}

	return desk, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交新增
 * @Date 2020/11/10 17:37:25
 * @Param
 * @return
 **/

func (model Desk) Store() (Desk, error) {

	db := model.Db

	desk := Desk{}

	query := []string{"d.mid = ? AND d.name = ?"}
	queryArgs := []interface{}{model.Mid, model.Name}

	resultDesk, err := model.Show(query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return desk, err
	}

	category := DeskCategory{
		Db: db,
	}
	cateData, err := category.Show([]string{"id = ?"}, []interface{}{model.CategoryId})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return desk, err
	}

	if cateData.Id == 0 {
		return desk, errors.New("该分类不存在！")
	}

	model.CategoryName = cateData.CategoryName

	desk = resultDesk.Desk
	if desk.Id == 0 {
		result := db.Create(&model)
		if result.Error != nil {
			fmt.Println("err", result.Error)
			return desk, result.Error
		}
	} else {
		return desk, errors.New("该桌位已存在，无需重复添加！")
	}

	return model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新座位
 * @Date 2020/11/10 18:14:23
 * @Param
 * @return
 **/

func (model Desk) Update() (Desk, error) {

	db := model.Db

	query := []string{"d.mid = ?", "d.id = ?"}
	queryArgs := []interface{}{model.Mid, model.Id}

	resultDesk, err := model.Show(query, queryArgs)

	desk := resultDesk.Desk
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return desk, err
	}

	category := DeskCategory{
		Db: db,
	}
	cateData, err := category.Show([]string{"id = ?"}, []interface{}{model.CategoryId})
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return desk, err
	}

	if cateData.Id == 0 {
		return desk, errors.New("该分类不存在！")
	}

	model.DeskNumber = desk.DeskNumber
	model.Status = desk.Status
	model.ListOrder = desk.ListOrder
	model.CategoryName = cateData.CategoryName
	result := db.Save(&model)
	if result.Error != nil {
		return desk, result.Error
	}

	return model, nil
}
