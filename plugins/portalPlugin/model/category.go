/**
** @创建时间: 2020/10/29 4:47 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type PortalCategory struct {
	Id             int               `json:"id"`
	Mid            int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	ParentId       int               `gorm:"type:bigint(20);comment:父级id;not null" json:"parent_id"`
	PostCount      int               `gorm:"type:bigint(20);comment:分类文章数;not null" json:"post_count"`
	Status         int               `gorm:"type:tinyint(3);comment:状态,1:发布,0:不发布;default:1;not null" json:"status"`
	DeleteAt       int64             `gorm:"type:int(11);comment:删除时间;not null" json:"delete_at"`
	ListOrder      float64           `gorm:"type:float(0);comment:排序;default:10000;not null" json:"list_order"`
	Name           string            `gorm:"type:varchar(200);comment:唯一名称;not null" json:"name"`
	Alias          string            `gorm:"type:varchar(200);comment:唯一名称;not null" json:"alias"`
	Description    string            `gorm:"type:varchar(255);comment:分类描述;not null" json:"description"`
	Thumbnail      string            `gorm:"type:varchar(255);comment:缩略图;not null" json:"thumbnail"`
	Path           string            `gorm:"type:varchar(255);comment:分类层级关系;not null" json:"path"`
	SeoTitle       string            `gorm:"type:varchar(100);comment:三要素标题;not null" json:"seo_title"`
	SeoKeywords    string            `gorm:"type:varchar(255);comment:三要素关键字;not null" json:"seo_keywords"`
	SeoDescription string            `gorm:"type:varchar(255);comment:三要素描述;not null" json:"seo_description"`
	ListTpl        string            `gorm:"type:varchar(50);comment:分类列表模板;not null" json:"list_tpl"`
	OneTpl         string            `gorm:"type:varchar(50);comment:分类文章页模板;not null" json:"one_tpl"`
	More           string            `gorm:"type:text(0);comment:扩展属性" json:"more"`
	paginate       cmfModel.Paginate `gorm:"-"`
}

type portalTree struct {
	PortalCategory
	Value    string       `json:"value"`
	Title    string       `json:"title"`
	Children []portalTree `json:"children"`
}

type categoryOptions struct {
	Id       int    `json:"id"`
	ParentId int    `gorm:"type:int(11);comment:所属父类id;default:0" json:"parent_id"`
	Name     string `gorm:"type:varchar(50);comment:路由名称" json:"name"`
	Level    int    `json:"level"`
}

func (model *PortalCategory) Init(mid int) {

	pc := PortalCategory{
		Id: 1,
		Mid: mid,
		Name: "新鲜事",
	}
	cmf.NewDb().FirstOrCreate(&pc)

}

func (model *PortalCategory) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var total int64 = 0

	var category []PortalCategory
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&category).Count(&total)

	result := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Find(&category)

	if result.Error != nil {

		if !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return cmfModel.Paginate{}, result.Error
		}

	}

	// 生成树形结构
	data := model.recursionMenu(category, 0)

	paginate := cmfModel.Paginate{Data: data, Current: current, PageSize: pageSize, Total: total}
	if len(category) == 0 {
		paginate.Data = make([]string, 0)
	}
	return paginate, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询列表
 * @Date 2020/11/11 18:24:43
 * @Param
 * @return
 **/

func (model *PortalCategory) List() ([]PortalCategory, error) {

	query := []string{"mid = ? AND delete_at = ?"}
	queryArgs := []interface{}{model.Mid, "0"}
	queryStr := strings.Join(query, " AND ")

	var category []PortalCategory
	result := cmf.NewDb().Where(queryStr, queryArgs...).Find(&category)

	if result.Error != nil {
		if !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return category, result.Error
		}
	}

	return category, nil
}

func (model *PortalCategory) ListWithTree() ([]portalTree, error) {

	tree, err := model.List()
	if err != nil {
		return []portalTree{}, nil
	}

	// 生成树形结构
	data := model.recursionMenu(tree, model.ParentId)

	if len(data) == 0 {
		data = make([]portalTree, 0)
	}

	return data, nil
}

// 获取子集的分类id
func (model *PortalCategory) ChildIds() ([]string, error) {

	tree, err := model.List()
	if err != nil {
		return []string{}, nil
	}

	ids := model.recursionChild(tree, model.Id)
	ids = append(ids, strconv.Itoa(model.Id))
	return ids, nil

}

func (model PortalCategory) recursionChild(category []PortalCategory, parentId int) []string {
	var ids []string

	for _, v := range category {
		if parentId == v.ParentId {
			ids = append(ids, strconv.Itoa(v.Id))
			model.recursionMenu(category, v.Id)
		}
	}

	return ids

}

func (model PortalCategory) recursionMenu(category []PortalCategory, parentId int) []portalTree {

	var tree []portalTree

	for _, v := range category {
		// 当前子项
		if parentId == v.ParentId {
			item := portalTree{
				PortalCategory: v,
				Value:          strconv.Itoa(v.Id),
				Title:          v.Name,
			}
			children := model.recursionMenu(category, v.Id)
			item.Children = children
			tree = append(tree, item)
		}
	}
	return tree

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询文章所在的分类
 * @Date 2020/11/27 13:24:46
 * @Param
 * @return
 **/

func (model *PortalCategory) ListWithPost(query []string, queryArgs []interface{}) ([]PortalCategory, error) {

	queryStr := strings.Join(query, " AND ")
	var category []PortalCategory

	prefix := cmf.Conf().Database.Prefix

	result := cmf.NewDb().Table(prefix+"portal_post p").Select("pc.*").
		Joins("INNER JOIN "+prefix+"portal_category_post pcp ON pcp.post_id = p.id").
		Joins("INNER JOIN "+prefix+"portal_category pc ON pc.id = pcp.category_id").
		Where(queryStr, queryArgs...).Scan(&category)

	if result.Error != nil {
		if !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return category, result.Error
		}
	}

	if len(category) == 0 {
		category = make([]PortalCategory, 0)
	}

	return category, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 查询单个
 * @Date 2020/11/8 13:32:16
 * @Param
 * @return
 **/
type tempPortalCategory struct {
	PortalCategory
	PrevPath string `json:"prev_path"`
}

func (model *PortalCategory) Show() (tempPortalCategory, error) {
	id := model.Id
	if id == 0 {
		panic("分类id不能为0或空！")
	}
	category := PortalCategory{}
	result := cmf.NewDb().Where("id = ? and delete_at = ?", id, 0).First(&category)

	tpc := tempPortalCategory{}

	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return tpc, errors.New("该分类不存在！")
		}
		return tpc, result.Error
	}

	tpc.PortalCategory = category
	tpc.PrevPath = util.GetFileUrl(tpc.Thumbnail,"clipper")

	return tpc, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 提交单个
 * @Date 2020/11/8 18:06:51
 * @Param
 * @return
 **/
func (model *PortalCategory) Edit() (PortalCategory, error) {

	id := model.Id
	if id == 0 {
		panic("分类id不能为0或空！")
	}

	category := PortalCategory{
		Id: id,
	}
	data, err := category.Show()
	if err != nil {
		return data.PortalCategory, err
	}

	result := cmf.NewDb().Save(&model)
	if result.Error != nil {
		return PortalCategory{}, result.Error
	}

	return *model, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 保存内容
 * @Date 2020/11/8 13:21:58
 * @Param
 * @return
 **/

func (model *PortalCategory) Save() (PortalCategory, error) {
	category := PortalCategory{}
	result := cmf.NewDb().Create(&model)
	if result.Error != nil {
		return category, result.Error
	}
	return *model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一项或多项
 * @Date 2020/11/8 19:27:07
 * @Param
 * @return
 **/

func (model *PortalCategory) Delete() (PortalCategory, error) {

	id := model.Id
	if id == 0 {
		panic("分类id不能为0或空！")
	}

	category := PortalCategory{
		Id: id,
	}

	data, err := category.Show()
	if err != nil {
		return data.PortalCategory, err
	}

	// 查看当前分类下是否存在子分类

	var count int64
	cmf.NewDb().Model(model).Where("parent_id = ? AND delete_at = ?", id, 0).Count(&count)

	if count > 0 {
		return PortalCategory{}, errors.New("请先删除分类下的子分类！")
	}

	deleteAt := time.Now().Unix()
	result := cmf.NewDb().Model(model).Where("id = ?", id).Update("delete_at", deleteAt)

	if result.Error != nil {
		return PortalCategory{}, result.Error
	}

	return data.PortalCategory, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 批量删除
 * @Date 2020/11/8 19:41:45
 * @Param
 * @return
 **/
func (model *PortalCategory) BatchDelete(ids []string) (PortalCategory, error) {
	deleteAt := time.Now().Unix()
	if err := cmf.NewDb().Model(&model).Where("id IN (?)", ids).Updates(map[string]interface{}{"delete_at": deleteAt}).Error; err != nil {
		return PortalCategory{}, err
	}
	return PortalCategory{}, nil
}

func (model *PortalCategory) GetTopId(id int) (int, error) {

	tx := cmf.NewDb().Where("id = ? AND delete_at = ?", id, 0).First(&model)

	if tx.Error != nil {
		return 0, tx.Error
	}

	var category []PortalCategory

	tx = cmf.NewDb().Where("delete_at = ?", 0).Find(&category)
	if tx.Error != nil {
		return 0, tx.Error
	}

	topId := model.recursionParent(category, id)

	return topId, nil

}

func (model *PortalCategory) recursionParent(category []PortalCategory, id int) (topId int) {

	topId = id

	for _, v := range category {
		if v.Id == id && v.ParentId > 0 {
			topId = model.recursionParent(category, v.ParentId)
		}
	}

	return topId

}

func (model *PortalCategory) indent(level int) string {

	indent := ""
	for i := 0; i < level; i++ {
		indent += "    |--"
	}

	return indent

}

var cOptions []categoryOptions

func (model *PortalCategory) ListWithOptions(query []string, queryArgs []interface{}) ([]categoryOptions, error) {

	var pc []PortalCategory

	queryStr := strings.Join(query, " AND ")

	cOptions = make([]categoryOptions, 0)

	tx := cmf.NewDb().Where(queryStr, queryArgs...).Find(&pc)
	if tx.Error != nil {
		return cOptions, nil
	}

	data := model.recursionOptions(pc, 0, 0)

	for k, v := range data {
		data[k].Name = model.indent(v.Level) + v.Name
	}

	return data, nil
}
func (model *PortalCategory) recursionOptions(nav []PortalCategory, parentId int, level int) []categoryOptions {

	nextLevel := level + 1

	for _, v := range nav {

		if parentId == v.ParentId {

			ops := categoryOptions{
				Id:       v.Id,
				ParentId: v.ParentId,
				Name:     v.Name,
				Level:    level,
			}

			cOptions = append(cOptions, ops)
			model.recursionOptions(nav, v.Id, nextLevel)
		}
	}

	return cOptions

}
