/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type Food struct {
	rc controller.RestController
}

// 文档所需
type dishesGoodsPaginate struct {
	Data     []model.Food `json:"data"`
	Current  string       `json:"current" example:"1"`
	PageSize string       `json:"page_size" example:"10"`
	Total    int64        `json:"total" example:"10"`
}

type dishesGoodsGet struct {
	Code int                 `json:"code" example:"1"`
	Msg  string              `json:"msg" example:"获取成功！"`
	Data dishesGoodsPaginate `json:"data"`
}

type dishesGoodsStore struct {
	Code int        `json:"code" example:"1"`
	Msg  string     `json:"msg" example:"添加成功！"`
	Data model.Food `json:"data"`
}

type dishesGoodsShow struct {
	Code int        `json:"code" example:"1"`
	Msg  string     `json:"msg" example:"获取成功！"`
	Data model.Food `json:"data"`
}

type dishesGoodsEdit struct {
	Code int        `json:"code" example:"1"`
	Msg  string     `json:"msg" example:"修改成功！"`
	Data model.Food `json:"data"`
}

type dishesGoodsDel struct {
	Code int        `json:"code" example:"1"`
	Msg  string     `json:"msg" example:"删除成功！"`
	Data model.Food `json:"data"`
}

type materialJson struct {
	MaterialName  string  `json:"material_name"`
	MaterialPrice float64 `json:"material_price"`
}

type skuJson struct {
	AttrKeyId     int     `json:"attr_key_id"`
	AttrValue     string  `json:"attr_value"`
	FoodId        int     `json:"food_id"`
	Code          string  `json:"code"`
	Inventory     int     `json:"inventory"`
	MemberPrice   float64 `json:"member_price"`
	UseMember     int     `json:"use_member"`
	OriginalPrice float64 `json:"original_price"`
	Price         float64 `json:"price"`
	Volume        int     `json:"volume"` // 销量
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 菜单列表管理
 * @Date 11:43 下午 2020/10/29
 * @Param
 * @return
 **/

// @Summary 菜品管理
// @Description 查看全部菜品列表
// @Tags restaurant 菜品管理
// @Accept mpfd
// @Param name formData string true "菜单名称"
// @Produce json
// @Success 200 {object} dishesGoodsGet "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/dishes/goods [get]
func (rest *Food) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	query := []string{"mid =? AND delete_at = ?"}
	queryArgs := []interface{}{mid, "0"}

	// 所属门店
	storeId := c.Query("store_id")

	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	query = append(query, "f.store_id = ?")
	queryArgs = append(queryArgs, storeId)

	// 菜品名称
	name := c.Query("name")
	if name != "" {
		query = append(query, "f.name like ?")
		queryArgs = append(queryArgs, "%"+name+"%")
	}

	// 菜品分类
	categoryId := c.Query("category_id")
	if categoryId != "" {
		query = append(query, "category_id = ?")
		queryArgs = append(queryArgs, categoryId)
	}

	// 菜品管理模型
	food := model.Food{}
	data, err := food.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 预览单个菜品
 * @Date 11:44 下午 2020/10/29
 * @Param
 * @return
 **/

// @Summary 单个菜品管理
// @Description 查看单个菜品
// @Tags restaurant 菜品管理
// @Accept mpfd
// @Param id path string true "单个菜单分类id"
// @Produce json
// @Success 200 {object} dishesGoodsShow "code:1 => 获取成功，code:0 => 获取异常"
// @Router /admin/dishes/goods/{id} [get]
func (rest Food) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	mid, _ := c.Get("mid")

	query := []string{"mid = ? AND id = ? AND delete_at = ?"}
	queryArgs := []interface{}{mid, rewrite.Id, "0"}

	// 所属门店
	storeId := c.Query("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}
	query = append(query, "store_id = ?")
	queryArgs = append(queryArgs, storeId)

	query = append(query, "delete_at = ?")
	queryArgs = append(queryArgs, "0")

	food := model.Food{}
	data, err := food.Detail(query, queryArgs)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "菜品不存在或已删除！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 编辑单个菜品
 * @Date 11:45 下午 2020/10/29
 * @Param
 * @return
 **/

// @Summary 提交修改单个菜品
// @Description 提交修改单个菜品
// @Tags restaurant 菜品管理
// @Accept mpfd
// @Param id path string true "单个菜品id"
// @Produce json
// @Success 200 {object} dishesGoodsEdit "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/dishes/goods/{id} [post]
func (rest Food) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 获取菜品名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品名称不能为空！", nil)
		return
	}

	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店参数非法！", err.Error())
		return
	}

	// 所在分类
	category := c.PostForm("category")
	if category == "" {
		rest.rc.Error(c, "至少选择一项分类！", nil)
		return
	}

	// 获取菜品的图片
	thumbnail := c.PostForm("thumbnail")

	// 菜品编码
	foodCode := c.PostForm("food_code")

	// 启用会员价
	useMember := c.PostForm("use_member")
	useMemberInt, err := strconv.Atoi(useMember)
	if err != nil {
		rest.rc.Error(c, "启用售参数非法！", nil)
		return
	}
	if useMemberInt == 1 {
		useMemberInt = 1
	} else {
		useMemberInt = 0
	}

	memberPrice := c.PostForm("member_price")
	mp, err := strconv.ParseFloat(memberPrice, 64)
	if err != nil {
		rest.rc.Error(c, "会员价参数非法！", nil)
		return
	}

	// 菜品原价
	originalPrice := c.PostForm("original_price")
	op, err := strconv.ParseFloat(originalPrice, 64)
	if err != nil {
		rest.rc.Error(c, "原价参数非法！", nil)
		return
	}

	// 菜品售价
	price := c.PostForm("price")
	if price == "" {
		rest.rc.Error(c, "菜品价格不能为空！", nil)
		return
	}

	p, err := strconv.ParseFloat(price, 64)
	if err != nil {
		rest.rc.Error(c, "售价参数非法！", nil)
		return
	}

	// 餐费费
	boxFee := c.PostForm("box_fee")
	bFloat, err := strconv.ParseFloat(boxFee, 64)
	if err != nil {
		rest.rc.Error(c, "餐盒费参数非法！", nil)
		return
	}

	// 菜品库存
	inventory := c.PostForm("inventory")
	if inventory == "" {
		rest.rc.Error(c, "菜品库存不能为空！", nil)
		return
	}

	inventoryInt, err := strconv.Atoi(inventory)
	if err != nil {
		rest.rc.Error(c, "库存参数非法！", nil)
		return
	}

	// 菜品销量
	volume := c.PostForm("volume")
	volumeInt, err := strconv.Atoi(volume)
	if err != nil {
		rest.rc.Error(c, "销量参数非法！", nil)
		return
	}

	// 支持场景
	scene := c.PostForm("scene")
	sceneInt, err := strconv.Atoi(scene)
	if err != nil {
		rest.rc.Error(c, "场景参数非法！", nil)
		return
	}

	// 是否招牌菜
	isRecommend := c.PostForm("is_recommend")
	isRecommendInt, err := strconv.Atoi(isRecommend)
	if err != nil {
		rest.rc.Error(c, "招牌菜参数非法！", err.Error())
		return
	}

	// 最低起售
	startSale := c.PostForm("start_sale")
	startSaleInt, err := strconv.Atoi(startSale)
	if err != nil {
		rest.rc.Error(c, "最低起售参数非法！", nil)
		return
	}

	// 启用规格
	useSku := c.PostForm("use_sku")
	useSkuInt, err := strconv.Atoi(useSku)
	if err != nil {
		rest.rc.Error(c, "启用售参数非法！", nil)
		return
	}

	if useSkuInt == 1 {
		useSkuInt = 1
	} else {
		useSkuInt = 0
	}

	// 启用口味
	useTasty := c.PostForm("use_tasty")
	useTastyInt, err := strconv.Atoi(useTasty)
	if err != nil {
		rest.rc.Error(c, "启用口味参数非法！", nil)
		return
	}

	if useTastyInt == 1 {
		useTastyInt = 1
	} else {
		useTastyInt = 0
	}

	// 口味
	tasty := c.PostForm("tasty")
	if !json.Valid([]byte(tasty)) {
		rest.rc.Error(c, "口味参数非法！", nil)
		return
	}

	if startSaleInt < 1 {
		rest.rc.Error(c, "最低起售份数不能小于1份！", nil)
		return
	}

	// 额外加料
	useMaterial := c.PostForm("use_material")
	useMaterialInt, err := strconv.Atoi(useMaterial)
	if err != nil {
		rest.rc.Error(c, "额外加料参数非法！", nil)
		return
	}

	if useTastyInt == 1 {
		useTastyInt = 1
	} else {
		useTastyInt = 0
	}

	material := c.PostForm("material")
	materialBytes := []byte(material)
	if !json.Valid(materialBytes) {
		rest.rc.Error(c, "材质参数非法！", nil)
		return
	}

	// 菜品状态
	status := c.DefaultPostForm("status", "1")
	statusInt, err := strconv.Atoi(status)
	if err != nil {
		rest.rc.Error(c, "状态参数非法！", nil)
		return
	}

	foodSku := c.PostForm("food_sku") // 获取规格键id

	// 添加到键值关联表
	skuBytes := []byte(foodSku)

	if !json.Valid(skuBytes) {
		rest.rc.Error(c, "添加规格出错！", nil)
		return
	}

	// 菜品详情
	content := c.PostForm("content")

	// 添加菜品
	nowAt := time.Now().Unix()
	food := model.Food{
		StoreId: storeIdInt,
		FoodStoreHouse: model.FoodStoreHouse{
			Id:               rewrite.Id,
			Mid:              midInt,
			Name:             name,
			FoodCode:         foodCode,
			UseSku:           useSkuInt,
			Thumbnail:        thumbnail,
			MemberPrice:      mp,
			OriginalPrice:    op,
			Price:            p,
			BoxFee:           bFloat,
			UseTasty:         useTastyInt,
			Tasty:            tasty,
			UseMaterial:      useMaterialInt,
			Inventory:        inventoryInt,
			DefaultInventory: inventoryInt,
			Volume:           volumeInt,
			StartSale:        startSaleInt,
			Scene:            sceneInt,
			IsRecommend:      isRecommendInt,
			Content:          content,
			CreateAt:         nowAt,
			UpdateAt:         nowAt,
			Status:           statusInt,
		},
	}

	tx := cmf.NewDb().Begin()

	tx.SavePoint("sp1")

	food.Db = tx
	food, err = food.Update()
	if err != nil {
		tx.Rollback()
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 更新所在分类
	categoryArr := strings.Split(category, ",")
	var categoryIntArr []int
	for _, v := range categoryArr {
		categoryId, err := strconv.Atoi(v)
		if err != nil {
			rest.rc.Error(c, "门店参数非法！", err.Error())
			return
		}
		categoryIntArr = append(categoryIntArr, categoryId)
	}

	fcp := model.FoodCategoryPost{
		FoodId: food.Id,
	}
	_, err = fcp.Save(midInt, categoryIntArr)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if useMaterialInt == 1 {
		// 加料逻辑
		var materialMap []materialJson
		json.Unmarshal(materialBytes, &materialMap)
		var materialArr []model.FoodMaterialPost
		for _, v := range materialMap {
			materialPost := model.FoodMaterialPost{
				FoodId:        food.Id,
				MaterialName:  v.MaterialName,
				MaterialPrice: v.MaterialPrice,
			}
			materialArr = append(materialArr, materialPost)
		}
		fmp := model.FoodMaterialPost{
			FoodId: food.Id,
			Db:     tx,
		}

		err := fmp.Update(materialArr)
		if err != nil {
			tx.RollbackTo("sp1")
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	if useSkuInt == 1 {
		// 解析多规格
		var skuMap []skuJson
		json.Unmarshal(skuBytes, &skuMap)

		for _, v := range skuMap {
			// 增加规格值
			attrValue := model.FoodAttrValue{
				AttrId:    v.AttrKeyId,
				AttrValue: v.AttrValue,
				Db:        tx,
			}

			// 获取规格值id
			attrValue, err = attrValue.AddAttrValue()
			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			// 获取键值和商品的关联信息
			attrPost := model.FoodAttrPost{
				FoodId:      food.Id,
				AttrValueId: attrValue.AttrValueId,
				Db:          tx,
			}

			attrPost, err = attrPost.AddAttrPost()
			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			// 获取规格唯一对应的键值id,多个用|分隔
			attrPostId := strconv.Itoa(attrPost.AttrPostId)

			// [1,2,3] [3,4,5] 删除4，5
			var fSku []model.FoodSku
			tx.Where("food_id = ?", food.Id).Find(&fSku)

			// 删除多余的规格
			bool := 0
			for _, fv := range fSku {
				// 如果被删除了
				if !(fv.AttrPost == attrPostId) {
					bool = fv.SkuId
				}
				bool = 0
			}

			if bool > 0 {
				tx.Where("sku_id = ?", bool).Delete(&model.FoodSku{})
			}

			sku := model.FoodSku{
				AttrPost:         attrPostId,
				FoodId:           food.Id,
				Code:             v.Code,
				Inventory:        v.Inventory,
				DefaultInventory: v.Inventory,
				MemberPrice:      v.MemberPrice,
				UseMember:        v.UseMember,
				OriginalPrice:    v.OriginalPrice,
				Price:            v.Price,
				Volume:           v.Volume,
				Db:               tx,
			}

			_, err := sku.FirstOrSave()

			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

		}
	}

	tx.Commit()
	rest.rc.Success(c, "更新成功！", food)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增一项菜品
 * @Date 2020/10/29 23:58:18
 * @Param
 * @return
 **/

// @Summary 提交添加单个菜品
// @Description 提交添加单个菜品
// @Tags restaurant 菜品管理
// @Accept mpfd
// @Produce json
// @Success 200 {object} dishesGoodsStore "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/dishes/goods [post]
func (rest Food) Store(c *gin.Context) {

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 获取菜品名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品名称不能为空！", nil)
		return
	}

	// 所在门店
	storeId := c.PostForm("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店参数非法！", err.Error())
		return
	}

	// 所在分类
	category := c.PostForm("category")
	if category == "" {
		rest.rc.Error(c, "至少选择一项分类！", nil)
		return
	}

	// 获取菜品的图片
	thumbnail := c.PostForm("thumbnail")

	// 菜品编码
	foodCode := c.PostForm("food_code")

	// 启用会员价

	useMember := c.PostForm("use_member")

	fmt.Println("useMember", useMember)

	useMemberInt, err := strconv.Atoi(useMember)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, "启用会员参数非法！", nil)
		return
	}
	if useMemberInt == 1 {
		useMemberInt = 1
	} else {
		useMemberInt = 0
	}

	memberPrice := c.PostForm("member_price")
	mp, err := strconv.ParseFloat(memberPrice, 64)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, "会员价参数非法！", nil)
		return
	}

	// 菜品原价
	originalPrice := c.PostForm("original_price")

	op, err := strconv.ParseFloat(originalPrice, 64)
	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, "原价参数非法！", nil)
		return
	}
	// 菜品售价
	price := c.PostForm("price")
	if price == "" {
		rest.rc.Error(c, "菜品价格不能为空！", nil)
		return
	}
	p, err := strconv.ParseFloat(price, 64)
	if err != nil {
		rest.rc.Error(c, "售价参数非法！", nil)
		return
	}

	// 餐费费
	boxFee := c.PostForm("box_fee")
	bFloat, err := strconv.ParseFloat(boxFee, 64)
	if err != nil {
		rest.rc.Error(c, "餐盒费参数非法！", nil)
		return
	}

	// 菜品库存
	inventory := c.PostForm("inventory")
	if inventory == "" {
		rest.rc.Error(c, "菜品库存不能为空！", nil)
		return
	}

	inventoryInt, err := strconv.Atoi(inventory)
	if err != nil {
		rest.rc.Error(c, "库存参数非法！", nil)
		return
	}

	// 菜品销量
	volume := c.PostForm("volume")
	volumeInt, err := strconv.Atoi(volume)
	if err != nil {
		rest.rc.Error(c, "销量参数非法！", nil)
		return
	}

	// 支持场景
	scene := c.PostForm("scene")
	sceneInt, err := strconv.Atoi(scene)
	if err != nil {
		rest.rc.Error(c, "场景参数非法！", nil)
		return
	}

	// 是否招牌菜
	isRecommend := c.PostForm("is_recommend")
	isRecommendInt, err := strconv.Atoi(isRecommend)
	if err != nil {
		rest.rc.Error(c, "招牌菜参数非法！", err.Error())
		return
	}

	// 最低起售
	startSale := c.PostForm("start_sale")
	startSaleInt, err := strconv.Atoi(startSale)
	if err != nil {
		rest.rc.Error(c, "最低起售参数非法！", nil)
		return
	}

	// 启用规格
	useSku := c.PostForm("use_sku")
	useSkuInt, err := strconv.Atoi(useSku)
	if err != nil {
		rest.rc.Error(c, "启用售参数非法！", nil)
		return
	}

	if useSkuInt == 1 {
		useSkuInt = 1
	} else {
		useSkuInt = 0
	}

	// 启用口味
	useTasty := c.PostForm("use_tasty")
	useTastyInt, err := strconv.Atoi(useTasty)
	if err != nil {
		rest.rc.Error(c, "启用口味参数非法！", nil)
		return
	}

	if useTastyInt == 1 {
		useTastyInt = 1
	} else {
		useTastyInt = 0
	}

	// 口味
	tasty := c.PostForm("tasty")
	if !json.Valid([]byte(tasty)) {
		rest.rc.Error(c, "口味参数非法！", nil)
		return
	}

	if startSaleInt < 1 {
		rest.rc.Error(c, "最低起售份数不能小于1份！", nil)
		return
	}

	// 额外加料
	useMaterial := c.PostForm("use_material")
	useMaterialInt, err := strconv.Atoi(useMaterial)
	if err != nil {
		rest.rc.Error(c, "额外加料参数非法！", nil)
		return
	}

	if useTastyInt == 1 {
		useTastyInt = 1
	} else {
		useTastyInt = 0
	}

	material := c.PostForm("material")

	fmt.Println("material", material)

	materialBytes := []byte(material)
	if !json.Valid(materialBytes) {
		rest.rc.Error(c, "材质参数非法！", nil)
		return
	}

	// 菜品状态
	status := c.DefaultPostForm("status", "1")
	statusInt, err := strconv.Atoi(status)
	if err != nil {
		rest.rc.Error(c, "状态参数非法！", nil)
		return
	}

	// 添加菜品规格
	foodSku := c.PostForm("food_sku") // 获取规格键id

	// 添加到键值关联表
	skuBytes := []byte(foodSku)

	if !json.Valid(skuBytes) {
		rest.rc.Error(c, "添加规格出错！", nil)
		return
	}

	// 菜品详情
	content := c.PostForm("content")

	// 添加菜品
	nowAt := time.Now().Unix()
	food := model.Food{
		StoreId: storeIdInt,
		FoodStoreHouse: model.FoodStoreHouse{
			Mid:              midInt,
			Name:             name,
			FoodCode:         foodCode,
			UseSku:           useSkuInt,
			Thumbnail:        thumbnail,
			MemberPrice:      mp,
			OriginalPrice:    op,
			Price:            p,
			BoxFee:           bFloat,
			UseTasty:         useTastyInt,
			Tasty:            tasty,
			UseMaterial:      useMaterialInt,
			Inventory:        inventoryInt,
			DefaultInventory: inventoryInt,
			Volume:           volumeInt,
			StartSale:        startSaleInt,
			Scene:            sceneInt,
			IsRecommend:      isRecommendInt,
			Content:          content,
			CreateAt:         nowAt,
			UpdateAt:         nowAt,
			Status:           statusInt,
		},
	}

	tx := cmf.NewDb().Begin()

	tx.SavePoint("sp1")

	food.Db = tx
	food, err = food.Save()
	if err != nil {
		tx.Rollback()
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 更新所在分类
	categoryArr := strings.Split(category, ",")
	var categoryIntArr []int
	for _, v := range categoryArr {
		categoryId, err := strconv.Atoi(v)
		if err != nil {
			rest.rc.Error(c, "门店参数非法！", err.Error())
			return
		}
		categoryIntArr = append(categoryIntArr, categoryId)
	}

	fcp := model.FoodCategoryPost{
		FoodId: food.Id,
	}
	_, err = fcp.Save(midInt, categoryIntArr)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if useMaterialInt == 1 {
		// 加料逻辑
		var materialMap []materialJson
		json.Unmarshal(materialBytes, &materialMap)
		var materialArr []model.FoodMaterialPost
		for _, v := range materialMap {
			materialPost := model.FoodMaterialPost{
				FoodId:        food.Id,
				MaterialName:  v.MaterialName,
				MaterialPrice: v.MaterialPrice,
			}
			materialArr = append(materialArr, materialPost)
		}

		fmp := model.FoodMaterialPost{
			FoodId: food.Id,
			Db:     tx,
		}

		err := fmp.Update(materialArr)
		if err != nil {
			tx.RollbackTo("sp1")
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	if useSkuInt == 1 {
		// 解析多规格
		var skuMap []skuJson
		json.Unmarshal(skuBytes, &skuMap)

		for _, v := range skuMap {
			// 增加规格值
			attrValue := model.FoodAttrValue{
				AttrId:    v.AttrKeyId,
				AttrValue: v.AttrValue,
				Db:        tx,
			}

			// 获取规格值id
			attrValue, err = attrValue.AddAttrValue()
			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			// 获取键值和商品的关联信息
			attrPost := model.FoodAttrPost{
				FoodId:      food.Id,
				AttrValueId: attrValue.AttrValueId,
				Db:          tx,
			}

			attrPost, err = attrPost.AddAttrPost()
			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

			fmt.Println("attrPost", attrPost)

			// 获取规格唯一对应的键值id,多个用|分隔
			attrPostId := strconv.Itoa(attrPost.AttrPostId)

			// [1,2,3] [3,4,5] 删除4，5

			var fSku []model.FoodSku
			tx.Where("food_id = ?", food.Id).Find(&fSku)

			fmt.Println("fsku", fSku)

			for _, fv := range fSku {
				// 如果被删除了
				if !(fv.FoodId == v.FoodId && fv.AttrPost == attrPostId) {
					tx.Where("sku_id = ?", fv.SkuId).Delete(&model.FoodSku{})
				}

			}

			sku := model.FoodSku{
				AttrPost:         attrPostId,
				FoodId:           food.Id,
				Code:             v.Code,
				Inventory:        v.Inventory,
				DefaultInventory: v.Inventory,
				MemberPrice:      v.MemberPrice,
				UseMember:        v.UseMember,
				OriginalPrice:    v.OriginalPrice,
				Price:            v.Price,
				Volume:           v.Volume,
				Db:               tx,
			}

			_, err := sku.FirstOrSave()

			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

		}
	}

	tx.Commit()
	rest.rc.Success(c, "添加成功！", food)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除一个菜品
 * @Date 2020/10/29 23:59:03
 * @Param
 * @return
 **/

// @Summary 提交删除菜品
// @Description 提交删除菜品
// @Tags restaurant 菜品管理
// @Accept mpfd
// @Produce json
// @Success 200 {object} dishesGoodsDel "code:1 => 获取成功，code:0 => 获取异常" "
// @Router /admin/dishes/goods/{id} [delete]
func (rest Food) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	mid, _ := c.Get("mid")

	// 所在门店
	storeId := c.Query("store_id")
	if storeId == "" {
		rest.rc.Error(c, "门店不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)
	if err != nil {
		rest.rc.Error(c, "门店参数非法！", err.Error())
		return
	}

	food := model.Food{
		StoreId: storeIdInt,
		FoodStoreHouse: model.FoodStoreHouse{
			Id:  rewrite.Id,
			Mid: mid.(int),
		},
	}

	food, err = food.Delete()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "删除成功！", food)
}
