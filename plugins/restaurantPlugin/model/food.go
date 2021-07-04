/**
** @创建时间: 2020/10/30 3:06 下午
** @作者　　: return
** @描述　　: 菜品表
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfLog "github.com/gincmf/cmf/log"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type spec struct {
	AttrId  int    `json:"attr_id"`
	AttrKey string `json:"attr_key"`
}

type foodSkuTemp struct {
	FoodSku
	AttrValueId int    `json:"attr_value_id"`
	AttrValue   string `json:"attr_value"`
}

type sSkuTemp struct {
	Spec    spec          `json:"spec"`
	FoodSku []foodSkuTemp `json:"food_sku"`
}

// 商品spu

type Food struct {
	FoodStoreHouse
	StoreId int `gorm:"type:int(11);comment:门店id;not null" json:"store_id"`
}

// 商品仓库
type FoodStoreHouse struct {
	Id               int                      `json:"id"`
	Mid              int                      `gorm:"type:varchar(20);comment:对应小程序id;not null" json:"mid"`
	FoodCode         string                   `gorm:"type:varchar(32);comment:菜品唯一编号;not null" json:"food_code"`
	Name             string                   `gorm:"type:varchar(255);comment:菜品名称;not null" json:"name"`
	Excerpt          string                   `gorm:"type:varchar(255);comment:菜品摘要;not null" json:"excerpt"`
	UseSku           int                      `gorm:"type:tinyint(3);comment:启用规格;default:0;not null" json:"use_sku"`
	SkuJson          map[string][]SpecPost    `gorm:"-" json:"sku_json"`
	FoodSku          sSkuTemp                 `gorm:"-" json:"food_sku"`
	UseTasty         int                      `gorm:"type:tinyint(3);comment:启用口味;default:0;not null" json:"use_tasty"`
	Tasty            string                   `gorm:"type:text;comment:口味;" json:"tasty"`
	TastyJson        []map[string]interface{} `gorm:"-" json:"tasty_json"`
	UseMember        int                      `gorm:"type:tinyint(3);comment:是否启用菜品会员价;not null" json:"use_member"`
	MemberPrice      float64                  `gorm:"type:decimal(9,2);comment:菜品会员价;not null" json:"member_price"`
	UseMaterial      int                      `gorm:"type:tinyint(3);comment:启用加料;default:0;not null" json:"use_material"`
	MaterialJson     []FoodMaterialPost       `gorm:"-" json:"material_json"`
	OriginalPrice    float64                  `gorm:"type:decimal(9,2);comment:菜品原价;not null" json:"original_price"`
	Price            float64                  `gorm:"type:decimal(9,2);comment:菜品售价;not null" json:"price"`
	BoxFee           float64                  `gorm:"type:decimal(9,2);comment:餐盒费;not null" json:"box_fee"`
	Inventory        int                      `gorm:"type:int(11);comment:库存" json:"inventory"`
	DefaultInventory int                      `gorm:"type:int(11);comment:默认库存" json:"default_inventory"`
	Volume           int                      `gorm:"type:int(11);comment:销量" json:"volume"`                           // 销量
	StartSale        int                      `gorm:"type:tinyint(3);comment:起售;default:1;not null" json:"start_sale"` // 最少起售
	Thumbnail        string                   `gorm:"type:varchar(255);comment:菜品缩略图;not null" json:"thumbnail"`
	AlipayMaterialId string                   `gorm:"type:varchar(256);comment:阿里素材标识;not null" json:"alipay_material_id"`
	PrevPath         string                   `gorm:"-" json:"prev_path"`
	Scene            int                      `gorm:"type:tinyint(3);comment:支持场景（0 =>全部；1=>堂食；2=>外卖）;default:0;not null" json:"scene"`
	IsRecommend      int                      `gorm:"type:tinyint(3);comment:是否推荐菜;not null;default:0" json:"is_recommend"`
	Content          string                   `gorm:"type:text" json:"content"`
	CreateAt         int64                    `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt         int64                    `gorm:"type:bigint(20)" json:"update_at"`
	DeleteAt         int64                    `gorm:"type:bigint(20);comment:删除时间;default:0" json:"delete_at"`
	CreateTime       string                   `gorm:"-" json:"create_time"`
	UpdateTime       string                   `gorm:"-" json:"update_time"`
	Category         []FoodCategory           `gorm:"-" json:"category"`
	Weight           float64                  `gorm:"type:float(5);comment:重量（kg）;" json:"weight"`
	Unit             string                   `gorm:"type:varchar(20);comment:商品单位;" json:"unit"`
	DishType         string                   `gorm:"type:varchar(40);comment:菜品类型;" json:"dish_type"`
	Flavor           string                   `gorm:"type:varchar(40);comment:菜品口味;" json:"flavor"`
	CookingMethod    string                   `gorm:"type:varchar(40);comment:菜品做法;" json:"cooking_method"`
	Status           int                      `gorm:"type:tinyint(3);comment:菜品状态;菜品状态（0 => 下架；1 => 上架）;not null" json:"status"`
	ListOrder        float64                  `gorm:"type:float(10);comment:排序;default:10000;not null" json:"list_order"`
	paginate         cmfModel.Paginate        `gorm:"-"`
	Db               *gorm.DB                 `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 商品分类关联信息
 * @Date 2020/11/16 16:12:22
 * @Param
 * @return
 **/
type FoodCategoryPost struct {
	Id             int      `json:"id"`
	FoodId         int      `gorm:"type:int(11)" json:"food_id"`
	FoodCategoryId int      `gorm:"type:int(11)" json:"food_category_id"`
	CreateAt       int64    `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt       int64    `gorm:"type:bigint(20)" json:"update_at"`
	Db             *gorm.DB `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜品门店关联
 * @Date 2020/11/17 08:30:44
 * @Param
 * @return
 **/

/**
 * @Author return <1140444693@qq.com>
 * @Description 商品加料表
 * @Date 2020/11/16 16:12:34
 * @Param
 * @return
 **/
type FoodMaterialPost struct {
	Id            int      `json:"id"`
	Mid           int      `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	FoodId        int      `gorm:"type:int(11)" json:"food_id"`
	MaterialName  string   `gorm:"type:varchar(255);comment:加料名称;not null" json:"material_name"`
	MaterialPrice float64  `gorm:"type:decimal(9,2);comment:加料加价;not null" json:"material_price"`
	Db            *gorm.DB `gorm:"-" json:"-"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 规格临时结构体
 * @Date 2020/11/18 13:11:14
 * @Param
 * @return
 **/

type SpecPost struct {
	AttrPostId  int    `json:"attr_post_id"`
	AttrValueId int    `json:"attr_value_id"`
	FoodId      int    `json:"food_id"`
	Name        string `json:"name"`
	AttrId      int    `json:"attr_id"`
	AttrValue   string `json:"attr_value"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜品模型自动数据库迁移
 * @Date 2020/10/30 21:56:02
 * @Param
 * @return
 **/
func (model Food) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model)
	cmf.NewDb().AutoMigrate(&FoodCategoryPost{})
	cmf.NewDb().AutoMigrate(&FoodMaterialPost{})
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部菜品列表
 * @Date 2020/10/30 22:55:02
 * @Param
 * @return
 **/
func (model Food) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	var prefix = cmf.Conf().Database.Prefix

	var food []Food
	cmf.NewDb().Table(prefix+"food f").
		Joins("left join "+prefix+"food_category_post cp ON cp.food_id = f.id").
		Group("f.id").
		Where(queryStr, queryArgs...).Count(&total)

	result := cmf.NewDb().Table(prefix+"food f").Select("f.*").
		Joins("left join "+prefix+"food_category_post cp ON cp.food_id = f.id").
		Group("f.id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("list_order desc, id desc").Scan(&food)

	for k, v := range food {
		food[k].PrevPath = util.GetFileUrl(v.Thumbnail, "thumbnail500x500")
		food[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		food[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	if result.Error != nil {
		return cmfModel.Paginate{}, result.Error
	}

	/*	获取当前商品下的规格
			for k, v := range food {
				if v.UseSku == 1 {
					sku := FoodSku{
						FoodId: v.Id,
					}
					skuData, err := sku.ListByFoodId(nil, nil)
					if err == nil {
						food[k].FoodSku = skuData
					}
				}
			}

		for k, v := range food {
				if v.UseTasty == 1 {
					var tastyJson []map[string]interface{}
					tempJson := v.Tasty
					json.Unmarshal([]byte(tempJson), &tastyJson)
					food[k].TastyJson = tastyJson
				}
				if v.UseSku == 1 {
					fap := FoodAttrPost{
						FoodId: v.Id,
					}

					var skuJson []map[string]interface{}

					attrData, err := fap.attrPost()
					if err == nil {
						for _, v := range attrData {
							skuJson = append(skuJson, map[string]interface{}{
								v.Name: map[string]interface{}{
									"attr_value_id": v.AttrValueId,
									"food_id":       v.FoodId,
									"attr_name":     v.Name,
									"attr_value":    v.AttrValue,
								},
							})
						}
					}
					food[k].SkuJson = skuJson
				}
			}*/

	paginate := cmfModel.Paginate{Data: food, Current: current, PageSize: pageSize, Total: total}
	if len(food) == 0 {
		paginate.Data = make([]Food, 0)
	}

	return paginate, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 关联获取分类的菜品信息
 * @Date 2020/11/24 01:16:46
 * @Param
 * @return
 **/

type FoodCate struct {
	Food
	CategoryId   int    `json:"category_id"`
	CategoryName string `json:"category_name"`
}

func (model Food) ListByCategory(query []string, queryArgs []interface{}) ([]FoodCate, error) {

	var foodCate []FoodCate

	queryStr := strings.Join(query, " AND ")
	prefix := cmf.Conf().Database.Prefix
	result := cmf.NewDb().Table(prefix+"food f").Select("f.*,fc.id as category_id,fc.name as category_name").
		Joins("INNER JOIN "+prefix+"food_category_post fcp ON fcp.food_id = f.id").
		Joins("INNER JOIN "+prefix+"food_category fc ON fcp.food_category_id = fc.id").
		Where(queryStr, queryArgs...).Order("f.list_order desc,f.id desc").Scan(&foodCate)

	if result.Error != nil {
		return foodCate, result.Error
	}

	for k, v := range foodCate {

		if v.Price == v.OriginalPrice {
			foodCate[k].OriginalPrice = 0
		}

		foodCate[k].PrevPath = util.GetFileUrl(v.Thumbnail, "thumbnail500x500")
		foodCate[k].CreateTime = time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		foodCate[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
	}

	return foodCate, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取菜品的全部详情
 * @Date 2020/11/18 12:36:12
 * @Param
 * @return
 **/
func (model Food) Detail(query []string, queryArgs []interface{}) (Food, error) {

	food, err := model.Show(query, queryArgs)
	if err != nil {
		cmfLog.Error(err.Error())
		return Food{}, err
	}

	if food.Price == food.OriginalPrice {
		food.OriginalPrice = 0
	}

	if food.UseSku == 1 {

		fap := FoodAttrPost{
			FoodId: food.Id,
		}

		var skuJson = make(map[string][]SpecPost, 0)
		attrData, err := fap.attrPost()

		if len(attrData) == 0 {
			return Food{}, errors.New("规格错误，最少启用一项规格")
		}

		if err == nil {
			for _, v := range attrData {
				item := SpecPost{
					AttrPostId:  v.AttrPostId,
					AttrValueId: v.AttrValueId,
					FoodId:      v.FoodId,
					Name:        v.Name,
					AttrId:      v.AttrId,
					AttrValue:   v.AttrValue,
				}

				if skuJson[item.Name] == nil {
					itemArr := []SpecPost{item}
					skuJson[item.Name] = itemArr
				} else {
					skuJson[item.Name] = append(skuJson[item.Name], item)
				}

			}
		}

		food.SkuJson = skuJson

		sku := FoodSku{
			FoodId: food.Id,
		}

		skuData, err := sku.ListByFoodId(nil, nil)
		if err != nil {
			cmfLog.Error(err.Error())
			return food, err
		}

		var fst = make([]foodSkuTemp, 0)

		for _, v := range skuData {

			attrPost, _ := strconv.Atoi(v.AttrPost)
			attr := model.inSpec(attrPost, attrData)

			fst = append(fst, foodSkuTemp{
				AttrValueId: attr.AttrValueId,
				AttrValue:   attr.AttrValue,
				FoodSku:     v,
			})
		}

		skuTemp := sSkuTemp{
			Spec: spec{
				AttrId:  attrData[0].AttrId,
				AttrKey: attrData[0].Name,
			},
			FoodSku: fst,
		}

		food.FoodSku = skuTemp

	}

	food.PrevPath = util.GetFileUrl(food.Thumbnail, "thumbnail500x500")

	// 启用口味
	if food.UseTasty == 1 {
		var tastyJson []map[string]interface{}
		tempJson := food.Tasty
		json.Unmarshal([]byte(tempJson), &tastyJson)
		food.TastyJson = tastyJson
	}

	// 启用加料
	if food.UseMaterial == 1 {
		var material []FoodMaterialPost
		cmf.NewDb().Where("food_id", food.Id).Find(&material)
		food.MaterialJson = material
	}

	fQuery := []string{"f.id = ? AND f.delete_at = ? AND fc.delete_at = ?"}
	fQueryArgs := []interface{}{food.Id, 0, 0}
	category, err := FoodCategory{}.ListByFood(fQuery, fQueryArgs)

	if err != nil {
		cmfLog.Error(err.Error())
		return Food{}, err
	}

	// 分类
	food.Category = category

	fQuery = []string{"f.id = ? AND f.delete_at = ? AND s.delete_at = ?"}
	fQueryArgs = []interface{}{food.Id, 0, 0}

	return food, nil
}

func (model Food) inSpec(attrPost int, attrData []tempAttrPost) tempAttrPost {

	for _, v := range attrData {
		if v.AttrPostId == attrPost {
			return v
		}
	}
	return tempAttrPost{}
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取一条菜品详情
 * @Date 2020/11/16 16:35:40
 * @Param
 * @return
 **/

func (model Food) Show(query []string, queryArgs []interface{}) (Food, error) {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	queryStr := strings.Join(query, " AND ")
	food := Food{}
	result := db.Where(queryStr, queryArgs...).First(&food)
	food.PrevPath = util.GetFileUrl(food.Thumbnail, "thumbnail500x500")
	if result.Error != nil {
		return food, result.Error
	}
	return food, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增一条菜品
 * @Date 2020/11/16 16:35:40
 * @Param
 * @return
 **/

func (model Food) Save() (Food, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	food := Food{}

	query := []string{"mid = ?", "store_id = ?", "name = ?"}
	queryArgs := []interface{}{model.Mid, model.StoreId, model.Name}

	food, err := food.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return food, err
	}

	if food.Id == 0 {
		result := model.Db.Create(&model)
		if result.Error != nil {
			return food, result.Error
		}
	} else {
		model.DeleteAt = 0
		model.CreateAt = 0
		model.UpdateAt = 0
		model.Id = food.Id
		tx := model.Db.Save(&model)
		return food, tx.Error
	}

	return model, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新一条
 * @Date 2020/11/18 15:48:24
 * @Param
 * @return
 **/
func (model Food) Update() (Food, error) {

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	food := Food{
		FoodStoreHouse: FoodStoreHouse{
			Db: model.Db,
		},
	}
	query := []string{"mid = ?", "store_id = ?", "id = ?"}
	queryArgs := []interface{}{model.Mid, model.StoreId, model.Id}

	food, err := food.Show(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return food, errors.New("该菜品不存在！")
		}
		return Food{}, err
	}

	result := model.Db.Save(&model)
	if result.Error != nil {
		return food, result.Error
	}

	return model, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一条菜品
 * @Date 2020/12/4 15:30:3
 * @Param
 * @return
 **/
func (model Food) Delete() (Food, error) {
	food := Food{}
	query := []string{"mid = ?", "store_id = ?", "id = ?"}
	queryArgs := []interface{}{model.Mid, model.StoreId, model.Id}

	food, err := food.Show(query, queryArgs)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return food, err
	}

	if food.Id > 0 {
		queryStr := strings.Join(query, " AND ")
		result := cmf.NewDb().Model(&food).Where(queryStr, queryArgs...).Update("delete_at", time.Now().Unix())

		if result.Error != nil {
			return food, result.Error
		}
	} else {
		return Food{}, errors.New("该菜品不存在！")
	}

	return food, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 维护当前菜品所在分类
 * @Date 2020/11/17 09:35:23
 * @Param
 * @return
 **/
func (model FoodCategoryPost) Save(mid int, categoryIds []int) ([]FoodCategoryPost, error) {

	// 查询当前存在的门店
	var nAddCategory []FoodCategoryPost
	for _, v := range categoryIds {
		nAddCategory = append(nAddCategory, FoodCategoryPost{
			FoodId:         model.FoodId,
			FoodCategoryId: v,
		})
	}

	var query []string
	var queryArgs []interface{}
	query = append(query, "mid = ?")
	queryArgs = append(queryArgs, mid)
	category := FoodCategory{}
	categoryResult, err := category.List(query, queryArgs)
	if err != nil {
		return nil, err
	}

	var existCategory []string
	for _, v := range categoryResult {
		existCategory = append(existCategory, strconv.Itoa(v.FoodCategory.Id))
	}

	if model.Db == nil {
		model.Db = cmf.NewDb()
	}

	var foodCategoryPostArr []FoodCategoryPost
	// 查询当前菜品所在的门店
	model.Db.Where("food_id =?", model.FoodId).Find(&foodCategoryPostArr)

	// 找出待添加的
	var readyAddArr []FoodCategoryPost
	for _, v := range nAddCategory {
		categoryId := v.FoodCategoryId
		// 是否存在分类
		if !util.ToLowerInArray(strconv.Itoa(categoryId), existCategory) {
			return foodCategoryPostArr, errors.New("分类不正确！")
		}

		if !model.InCategoryPost(v, foodCategoryPostArr) || len(foodCategoryPostArr) == 0 {
			readyAddArr = append(readyAddArr, FoodCategoryPost{FoodId: model.FoodId, FoodCategoryId: categoryId})
		}
	}

	// 找出被删除的
	var readyDelQuery []string
	var readyDelArgs []interface{}
	for _, v := range foodCategoryPostArr {

		categoryId := v.FoodCategoryId

		if !model.InCategoryPost(v, nAddCategory) || len(nAddCategory) == 0 {
			readyDelQuery = append(readyDelQuery, "(food_id = ? AND food_category_id = ?)")
			readyDelArgs = append(readyDelArgs, model.FoodId, categoryId)
		}

		if len(nAddCategory) == 0 {
			readyAddArr = append(readyAddArr, FoodCategoryPost{FoodId: model.FoodId, FoodCategoryId: categoryId})
		}
	}

	// 删除待删除的
	var readyDelQueryStr string
	if len(readyDelArgs) > 0 {
		readyDelQueryStr = strings.Join(readyDelQuery, " OR ")
		result := model.Db.Where(readyDelQueryStr, readyDelArgs...).Delete(&model)
		if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return foodCategoryPostArr, result.Error
		}
	}

	// 添加待添加的
	if len(readyAddArr) > 0 {
		result := model.Db.Create(&readyAddArr)
		if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return foodCategoryPostArr, result.Error
		}
	}

	return foodCategoryPostArr, nil
}

func (model FoodCategoryPost) InCategoryPost(inFoodCategoryPost FoodCategoryPost, outFoodCategoryPost []FoodCategoryPost) bool {

	for _, v := range outFoodCategoryPost {
		if inFoodCategoryPost.FoodId == v.FoodId && inFoodCategoryPost.FoodCategoryId == v.FoodCategoryId {
			return true
		}

	}

	return false
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新加料
 * @Date 2020/12/7 11:46:19
 * @Param
 * @return
 **/

func (model *FoodMaterialPost) Update(materials []FoodMaterialPost) error {

	db := cmf.NewDb()
	if model.Db != nil {
		db = model.Db
	}

	// 查出数据库中的
	var fmp []FoodMaterialPost
	db.Where("food_id = ?", model.FoodId).Find(&fmp)

	var readyDel []string
	var readyDelArgs []interface{}

	// [1,2,3]  [3,4,5] 删除4，5
	// 增加待删除的
	for _, v := range fmp {
		if !model.inFoodMaterialPost(v.FoodId, v.MaterialName, materials) || len(materials) == 0 {
			readyDel = append(readyDel, "id = ?")
			readyDelArgs = append(readyDelArgs, v.Id)
		}
	}

	var readyAdd []FoodMaterialPost
	// [1,2,3]  [3,4,5] 增加1，2
	// 增加待增加
	for _, v := range materials {
		if !model.inFoodMaterialPost(v.FoodId, v.MaterialName, fmp) {
			readyAdd = append(readyAdd, FoodMaterialPost{
				FoodId:        model.FoodId,
				MaterialName:  v.MaterialName,
				MaterialPrice: v.MaterialPrice,
			})
		}
	}

	// 删除待删除的
	if len(readyDel) > 0 {
		delStr := strings.Join(readyDel, " OR ")
		db.Where(delStr, readyDelArgs...).Delete(&FoodMaterialPost{})
	}

	// 增加需要增加的
	if len(readyAdd) > 0 {
		db.Create(&readyAdd)
	}

	return nil

}

func (model *FoodMaterialPost) inFoodMaterialPost(foodId int, materialName string, FoodMaterialPost []FoodMaterialPost) bool {
	for _, v := range FoodMaterialPost {
		if v.FoodId == foodId && v.MaterialName == materialName {
			return true
		}
	}

	return false
}
