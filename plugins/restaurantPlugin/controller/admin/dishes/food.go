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
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/360EntSecGroup-Skylar/excelize/v2"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/merchant"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"sync"
	"time"
)

type Food struct {
	rc controller.Rest
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
	Weight        float64 `json:"weight"`
	Inventory     int     `json:"inventory"`
	MemberPrice   float64 `json:"member_price"`
	UseMember     int     `json:"use_member"`
	OriginalPrice float64 `json:"original_price"`
	Price         float64 `json:"price"`
	Volume        int     `json:"volume"` // 销量
}

type extVale struct {
	Value string `json:"value"`
	Label string `json:"label"`
}

type foodCate struct {
	CategoryId int          `json:"category_id"`
	Name       string       `json:"name"`
	IsRequired int          `json:"is_required"`
	Food       []model.Food `json:"food"`
}

type Tasty struct {
	AttrKey string   `json:"attr_key"`
	AttrVal []string `json:"attr_val"`
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
// @Param mid query string true "小程序唯一编号"
// @Param store_id query string false "门店id"
// @Param name query string false "菜品名称"
// @Param category_id query string false "菜品分类"
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.Food} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/food [get]
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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 菜品管理模型
	food := model.Food{
		Db: db,
	}
	data, err := food.Index(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据分类获取菜品列表
 * @Date 2020/11/24 11:04:49
 * @Param
 * @return
 **/
func (rest *Food) List(c *gin.Context) {

	mid, _ := c.Get("mid")
	storeId := c.Query("store_id")

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 获取门店参数
	category := model.FoodCategory{
		Db: db,
	}

	var query []string
	var queryArgs []interface{}

	query = append(query, "mid = ? AND store_id = ? AND delete_at = ? AND status = ?")
	queryArgs = append(queryArgs, mid, storeId, 0, 1)

	categoryData, err := category.List(query, queryArgs)
	if err != nil {
		rest.rc.Error(c, "获取失败！", nil)
		return
	}

	// 获取全部菜品
	var foodQuery []string
	var foodQueryArgs []interface{}

	foodQuery = append(foodQuery, "f.mid = ? AND fc.store_id = ? AND f.delete_at = ?")
	foodQueryArgs = append(foodQueryArgs, mid, storeId, 0)

	food := model.Food{
		Db: db,
	}
	foodData, err := food.ListByCategory(foodQuery, foodQueryArgs)

	if err != nil {
		rest.rc.Error(c, "获取菜品错误！", err.Error())
		return
	}

	// 最终结果项
	var foodCateMap = make([]foodCate, 0)

	for _, v := range categoryData {

		// 当前分类项
		fc := foodCate{
			CategoryId: v.FoodCategory.Id,
			Name:       v.FoodCategory.Name,
			IsRequired: v.FoodCategory.IsRequired,
		}

		// 当前菜品项
		foodArr := make([]model.Food, 0)
		for _, fv := range foodData {
			// 寻找分类,存入菜品
			if v.FoodCategory.Id == fv.CategoryId {
				foodArr = append(foodArr, fv.Food)
			}
		}

		fc.Food = foodArr
		// 存入一个分类
		foodCateMap = append(foodCateMap, fc)

	}

	rest.rc.Success(c, "获取成功！", foodCateMap)
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
// @Param mid query string true "小程序唯一编号"
// @Param id path string true "单个菜单分类id"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Food} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/food/{id} [get]
func (rest Food) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
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

	food := model.Food{
		Db: db,
	}
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
// @Param mid query string true "小程序唯一编号"
// @Param store_id formData string true "门店id"
// @Param name formData string true "菜品名称"
// @Param category formData string true "菜品分类"
// @Param thumbnail formData string false "菜品缩略图"
// @Param food_code formData string false "菜品编码"
// @Param use_member formData string false "启用会员价"
// @Param member_price formData string false "会员价"
// @Param original_price formData string false "原价"
// @Param price formData string false "售价"
// @Param box_fee formData string false "餐盒费"
// @Param inventory formData string false "库存"
// @Param volume formData string false "销量"
// @Param scene formData string false "场景"
// @Param start_sale formData string false "最低起售"
// @Param use_sku formData string false "启用规格"
// @Param use_tasty formData string false "启用口味"
// @Param tasty formData string false "口味json"
// @Param use_material formData string false "额外加料"
// @Param material formData string false "加料"
// @Param status formData string false "状态"
// @Param food_sku formData string false "菜品规格"
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Food} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/food/{id} [post]
func (rest Food) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	alipay, alipayExist := c.Get("alipay")

	// 获取菜品名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品名称不能为空！", nil)
		return
	}

	excerpt := c.PostForm("excerpt")

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

	// 菜品类型
	dishType := c.PostForm("dish_type")
	/*if dishType == "" {
		rest.rc.Error(c, "菜品类型不能为空！", nil)
		return
	}*/

	// 口味
	flavor := c.PostForm("flavor")
	/*if flavor == "" {
		rest.rc.Error(c, "菜品口味不能为空！", nil)
		return
	}*/

	// 做法
	cookingMethod := c.PostForm("cooking_method")
	/*if cookingMethod == "" {
		rest.rc.Error(c, "菜品做法不能为空！", nil)
		return
	}*/

	listOrder := c.PostForm("list_order")
	if listOrder == "" {
		rest.rc.Error(c, "排序不能为空！", nil)
		return
	}
	listOrderFloat, _ := strconv.ParseFloat(listOrder, 64)

	unit := c.PostForm("unit")
	if unit == "" {
		rest.rc.Error(c, "单位不能为空！", nil)
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

	var mp float64
	if useMemberInt == 1 {
		memberPrice := c.PostForm("member_price")
		mp, err = strconv.ParseFloat(memberPrice, 64)
		if err != nil {
			rest.rc.Error(c, "会员价参数非法！", nil)
			return
		}
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

	var weight float64 = 0
	if useSkuInt == 1 {
		useSkuInt = 1
	} else {
		useSkuInt = 0
		w := c.PostForm("weight")
		weight, err = strconv.ParseFloat(w, 64)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
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

	food := model.Food{}
	tx := db.Where("id = ?", rewrite.Id).First(&food)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该菜品不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	alipayMaterialId := ""
	if thumbnail != "" && (food.Thumbnail != thumbnail || food.AlipayMaterialId == "") {

		if alipayExist && alipay.(bool) {
			// 上传缩略图到阿里支付宝
			file := util.GetAbsPath(thumbnail)
			bizContent := make(map[string]string, 0)
			fileResult, err := new(merchant.File).Upload(bizContent, file)
			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
			alipayMaterialId = fileResult.Response.MaterialId
		}
	}

	food = model.Food{
		StoreId: storeIdInt,
		FoodStoreHouse: model.FoodStoreHouse{
			Id:               rewrite.Id,
			Mid:              midInt,
			Name:             name,
			Excerpt:          excerpt,
			FoodCode:         foodCode,
			DishType:         dishType,
			Flavor:           flavor,
			CookingMethod:    cookingMethod,
			Weight:           weight,
			Unit:             unit,
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
			AlipayMaterialId: alipayMaterialId,
		},
	}

	if listOrder != "" {
		food.ListOrder = listOrderFloat
	}

	tx = db.Begin()
	tx.SavePoint("sp1")
	defer func() {
		if r := recover(); r != nil {
			tx.RollbackTo("sp1")
		}
		tx.Commit()
	}()

	food.Db = tx

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
		Db:     tx,
	}
	_, err = fcp.Save(midInt, categoryIntArr)
	if err != nil {
		tx.RollbackTo("sp1")
		fmt.Println("fcp.Save", err)
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
				Mid:           midInt,
				MaterialName:  v.MaterialName,
				MaterialPrice: v.MaterialPrice,
			}
			materialArr = append(materialArr, materialPost)
		}

		fmt.Println("1111")

		fmp := model.FoodMaterialPost{
			FoodId: food.Id,
			Db:     tx,
		}

		fmt.Println("1111")

		err := fmp.Update(materialArr)
		if err != nil {
			tx.RollbackTo("sp1")
			rest.rc.Error(c, err.Error(), nil)
			return
		}

	}

	// 总库存
	foodInventory := inventoryInt

	if useSkuInt == 1 {

		foodInventory = 0

		var attrQuery []string
		var attrQueryArgs []interface{}

		var skuDelQuery []string
		var skuDelQueryArgs []interface{}
		// 解析多规格
		var skuMap []skuJson
		json.Unmarshal(skuBytes, &skuMap)

		if len(skuMap) == 0 {
			rest.rc.Error(c, "规格最少启用一项！", nil)
			return
		}
		var skus []model.FoodSku
		for k, v := range skuMap {

			if v.Weight == 0 {
				rest.rc.Error(c, "第"+strconv.Itoa(k)+"项重量不能为空！", nil)
				return
			}

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

			skuDelQuery = append(skuDelQuery, "attr_post != ?")
			skuDelQueryArgs = append(skuDelQueryArgs, attrPostId)

			attrQuery = append(attrQuery, "attr_post_id != ?")
			attrQueryArgs = append(attrQueryArgs, attrPostId)

			// [1,2,3] [3,4,5] 删除4，5
			var fSku []model.FoodSku
			tx.Where("food_id = ?", food.Id).Find(&fSku)

			sku := model.FoodSku{
				AttrPost:         attrPostId,
				FoodId:           food.Id,
				AttrValue:        v.AttrValue,
				Code:             v.Code,
				Weight:           v.Weight,
				Inventory:        v.Inventory,
				DefaultInventory: v.Inventory,
				MemberPrice:      v.MemberPrice,
				UseMember:        v.UseMember,
				OriginalPrice:    v.OriginalPrice,
				Price:            v.Price,
				Volume:           v.Volume,
				Remark:           attrValue.AttrValue,
				Db:               tx,
			}

			foodInventory += v.Inventory

			skus = append(skus, sku)
		}

		if foodInventory < -1 {
			foodInventory = -1
		}

		fmt.Println("foodInventory", foodInventory)

		food.Inventory = foodInventory
		food.DefaultInventory = foodInventory

		skuDelQuery = append(skuDelQuery, "food_id = ?")
		skuDelQueryStr := strings.Join(skuDelQuery, " AND ")
		skuDelQueryArgs = append(skuDelQueryArgs, food.Id)

		tx.Where(skuDelQueryStr, skuDelQueryArgs...).Delete(&model.FoodSku{})

		attrQuery = append(attrQuery, "food_id = ?")
		attrQueryStr := strings.Join(attrQuery, " AND ")
		attrQueryArgs = append(attrQueryArgs, food.Id)
		tx.Where(attrQueryStr, attrQueryArgs...).Delete(&model.FoodAttrPost{})

		for _, sku := range skus {

			sku.Db = db

			_, err := sku.FirstOrSave()
			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}
		}
	}

	food, err = food.Update()
	if err != nil {
		tx.RollbackTo("sp1")
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", food)
}

func (rest Food) inAttrKeys(attrKeys []string, key int) bool {

	for _, v := range attrKeys {
		k, _ := strconv.Atoi(v)
		if k == key {
			return true
		}
	}

	return false

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
// @Produce mpfd
// @Param mid query string true "小程序唯一编号"
// @Param store_id formData string true "门店id"
// @Param name formData string true "菜品名称"
// @Param category formData string true "菜品分类"
// @Param thumbnail formData string false "菜品缩略图"
// @Param food_code formData string false "菜品编码"
// @Param use_member formData string false "启用会员价"
// @Param member_price formData string false "会员价"
// @Param original_price formData string false "原价"
// @Param price formData string false "售价"
// @Param box_fee formData string false "餐盒费"
// @Param inventory formData string false "库存"
// @Param volume formData string false "销量"
// @Param scene formData string false "场景"
// @Param start_sale formData string false "最低起售"
// @Param use_sku formData string false "启用规格"
// @Param use_tasty formData string false "启用口味"
// @Param tasty formData string false "口味json"
// @Param use_material formData string false "额外加料"
// @Param material formData string false "加料"
// @Param status formData string false "状态"
// @Param food_sku formData string false "菜品规格"
// @Success 200 {object} model.ReturnData{data=model.Food} "code:1 => 获取成功，code:0 => 获取异常"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/food [post]
func (rest Food) Store(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	alipay, alipayExist := c.Get("alipay")

	// 获取菜品名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "菜品名称不能为空！", nil)
		return
	}

	// 摘要
	excerpt := c.PostForm("excerpt")

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

	// 菜品类型
	dishType := c.PostForm("dish_type")
	/*if dishType == "" {
		rest.rc.Error(c, "菜品类型不能为空！", nil)
		return
	}*/

	// 口味
	flavor := c.PostForm("flavor")
	/*if flavor == "" {
		rest.rc.Error(c, "菜品口味不能为空！", nil)
		return
	}*/

	// 做法
	cookingMethod := c.PostForm("cooking_method")
	/*if cookingMethod == "" {
		rest.rc.Error(c, "菜品做法不能为空！", nil)
		return
	}*/

	listOrder := c.PostForm("list_order")
	if listOrder == "" {
		rest.rc.Error(c, "排序不能为空！", nil)
		return
	}
	listOrderFloat, _ := strconv.ParseFloat(listOrder, 64)

	unit := c.PostForm("unit")
	if unit == "" {
		rest.rc.Error(c, "单位不能为空！", nil)
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

	var mp float64
	if useMemberInt == 1 {
		memberPrice := c.PostForm("member_price")
		mp, err = strconv.ParseFloat(memberPrice, 64)
		if err != nil {
			cmfLog.Error(err.Error())
			rest.rc.Error(c, "会员价参数非法！", nil)
			return
		}
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

	var weight float64 = 0
	if useSkuInt == 1 {
		useSkuInt = 1
	} else {
		useSkuInt = 0
		w := c.PostForm("weight")
		weight, err = strconv.ParseFloat(w, 64)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
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

	alipayMaterialId := ""
	if thumbnail != "" {

		if alipayExist && alipay.(bool) {
			// 上传缩略图到阿里支付宝
			file := util.GetAbsPath(thumbnail)
			bizContent := make(map[string]string, 0)
			fileResult, err := new(merchant.File).Upload(bizContent, file)

			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
			alipayMaterialId = fileResult.Response.MaterialId
		}
	}

	// 添加菜品
	nowAt := time.Now().Unix()
	food := model.Food{
		StoreId: storeIdInt,
		FoodStoreHouse: model.FoodStoreHouse{
			Mid:              midInt,
			Name:             name,
			Excerpt:          excerpt,
			FoodCode:         foodCode,
			DishType:         dishType,
			Flavor:           flavor,
			Weight:           weight,
			Unit:             unit,
			CookingMethod:    cookingMethod,
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
			AlipayMaterialId: alipayMaterialId,
		},
	}

	if listOrder != "" {
		food.ListOrder = listOrderFloat
	}

	tx := db.Begin()
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
		Db:     tx,
	}
	_, err = fcp.Save(midInt, categoryIntArr)
	if err != nil {
		tx.RollbackTo("sp1")
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
				Mid:           midInt,
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

	foodInventory := inventoryInt

	if useSkuInt == 1 {

		foodInventory = 0
		// 解析多规格
		var skuMap []skuJson
		json.Unmarshal(skuBytes, &skuMap)

		for k, v := range skuMap {

			if v.Weight == 0 {
				rest.rc.Error(c, "第"+strconv.Itoa(k)+"项重量不能为空！", nil)
				return
			}

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
				Weight:           weight,
				Inventory:        v.Inventory,
				DefaultInventory: v.Inventory,
				MemberPrice:      v.MemberPrice,
				UseMember:        v.UseMember,
				OriginalPrice:    v.OriginalPrice,
				Price:            v.Price,
				Volume:           v.Volume,
				Remark:           attrValue.AttrValue,
				Db:               tx,
			}

			foodInventory += v.Inventory

			_, err := sku.FirstOrSave()

			if err != nil {
				tx.RollbackTo("sp1")
				rest.rc.Error(c, err.Error(), nil)
				return
			}

		}
	}

	if foodInventory < -1 {
		foodInventory = -1
	}

	// 更新库存
	food.Inventory = foodInventory
	food.DefaultInventory = foodInventory

	food.Db = tx
	food, err = food.Update()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	defer func() {
		if tx.Error != nil {
			tx.RollbackTo("sp1")
			return
		}
		tx.Commit()
	}()

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
// @Produce mpfd
// @Success 200 {object} model.ReturnData{data=model.Food} "code:1 => 删除成功，code:0 => 删除失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /admin/dishes/food/{id} [delete]
func (rest Food) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
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

// 获取食物的菜品类型
func (rest *Food) DishType(c *gin.Context) {

	var ev = []extVale{
		{Label: "快餐小吃", Value: "fast_food"},
		{Label: "茶饮", Value: "drinks"},
		{Label: "烘焙甜品", Value: "dessert"},
		{Label: "火锅", Value: "hotpot"},
		{Label: "烧烤/香锅", Value: "bbq_and_spicy_pot"},
		{Label: "西餐", Value: "western_food"},
		{Label: "自助餐", Value: "buffet"},
		{Label: "中餐地方菜", Value: "chinese_local_dish"},
		{Label: "异域料理", Value: "exotic_cuisine"},
		{Label: "其他", Value: "other"},
	}

	rest.rc.Success(c, "获取成功", ev)

}

// 获取食物的菜品类型
func (rest *Food) Flavor(c *gin.Context) {

	var ev = []extVale{
		{Label: "辣", Value: "spicy"},
		{Label: "咸", Value: "salty"},
		{Label: "甜", Value: "sweet"},
		{Label: "酸", Value: "sour"},
		{Label: "苦", Value: "bitter"},
		{Label: "麻", Value: "pungent"},
		{Label: "鲜", Value: "umami"},
		{Label: "其他", Value: "other"},
	}

	rest.rc.Success(c, "获取成功", ev)

}

// 获取食物的菜品类型
func (rest *Food) CookingMethod(c *gin.Context) {

	var ev = []extVale{
		{Label: "炒", Value: "stir_fried"},
		{Label: "蒸", Value: "steamed"},
		{Label: "烧", Value: "braised"},
		{Label: "焖", Value: "gentle_braised"},
		{Label: "炖", Value: "stewed"},
		{Label: "凉拌", Value: "cold_dish"},
		{Label: "烤", Value: "grilled"},
		{Label: "炸", Value: "deep_fried"},
		{Label: "煮", Value: "boiled"},
		{Label: "煎", Value: "umami"},
		{Label: "烤", Value: "fried"},
		{Label: "火锅", Value: "hotpot"},
		{Label: "烘焙", Value: "baked"},
		{Label: "砂锅", Value: "pot_cooking"},
		{Label: "卤", Value: "pot_stewed"},
		{Label: "其他", Value: "other"},
	}

	rest.rc.Success(c, "获取成功", ev)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description ListOrder 排序
 * @Date 2021/4/20 10:3:31
 * @Param
 * @return
 **/

func (rest *Food) ListOrder(c *gin.Context) {

	type food struct {
		Id        int     `json:"id"`
		ListOrder float64 `json:"list_order"`
	}

	var form []food

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")
	storeId := c.Query("store_id")

	for _, item := range form {
		db.Model(&model.Food{}).Where("id = ? AND mid = ? AND store_id = ?", item.Id, mid, storeId).Update("list_order", item.ListOrder)
	}

	rest.rc.Success(c, "操作成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 上下架菜品
 * @Date 2021/4/20 11:56:35
 * @Param
 * @return
 **/

func (rest *Food) SetStatus(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	food := model.Food{}
	tx := db.Where("id = ?", rewrite.Id).First(&food)

	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该菜品不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	storeId := c.Query("store_id")
	status := c.PostForm("status")

	if !(status == "0" || status == "1") {
		rest.rc.Error(c, "状态错误!", nil)
	}

	tx = db.Model(&Food{}).Where("id = ? AND mid = ? AND store_id = ?", rewrite.Id, mid, storeId).Update("status", status)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "操作成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 批量导入菜品
 * @Date 2021/5/28 21:4:9
 * @Param
 * @return
 **/
func (rest *Food) ImportMenus(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	iMid, _ := c.Get("mid")
	mid := iMid.(int)

	file, _ := c.FormFile("file")

	storeId := c.PostForm("store_id")

	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	storeIdInt, err := strconv.Atoi(storeId)

	if err != nil {
		rest.rc.Error(c, "门店id参数非法！", nil)
		return
	}

	suffixArr := strings.Split(file.Filename, ".")
	suffix := suffixArr[len(suffixArr)-1]

	if !(suffix == "xls" || suffix == "xlsx") {
		rest.rc.Error(c, "不是合法的文档！", nil)
		return
	}

	fp, _ := file.Open()
	f, err := excelize.OpenReader(fp)
	if err != nil {
		fmt.Println("err", err)
		rest.rc.Error(c, "打开失败，不存的表格！", nil)
		return
	}

	alipay, alipayExist := c.Get("alipay")

	categories, err := f.GetRows("菜品分类")

	var wg sync.WaitGroup

	wg.Add(1)

	go func() {
		allLen := len(categories)
		for k, v := range categories {
			if k > 0 {

				if v[0] == "" {
					continue
				}

				category := model.FoodCategory{}
				tx := db.Where("mid = ? AND name = ?", mid, v[0]).First(&category)
				category.Name = v[0]
				category.Mid = mid
				category.StoreId = storeIdInt
				category.ListOrder = float64(allLen) - float64(k)
				if tx.RowsAffected == 0 {
					category.CreateAt = time.Now().Unix()
					category.UpdateAt = time.Now().Unix()
					db.Create(&category)
				} else {
					category.UpdateAt = time.Now().Unix()
					db.Save(&category)
				}

			}
		}
		wg.Done()
	}()

	wg.Wait()

	// Get all the rows in the Sheet1.
	rows, err := f.GetRows("菜品列表")

	if len(rows) == 0 {
		fmt.Println("err", "表内容为空！")
	}

	name := ""

	foodInventory := -1

	wg.Add(1)
	go func() {

		allLen := len(rows)

		for k, v := range rows {

			if k > 1 {

				if len(v) == 0 {
					continue
				}

				if strings.TrimSpace(v[0]) == "" {
					continue
				}

				food := model.Food{}
				tx := db.Where("name = ? AND mid = ?", v[0], mid).First(&food)
				food.StoreId = storeIdInt
				food.Name = strings.TrimSpace(v[0])
				food.Excerpt = strings.TrimSpace(v[2])
				food.Mid = mid

				food.ListOrder = float64(allLen) - float64(k)

				status := 1
				if len(v) > 4 {
					food.Unit = v[3]
					if v[4] == "下架" {
						status = 0
					}
				}

				scene := 0

				if len(v) > 5 {
					if v[5] == "堂食" {
						scene = 1
					}

					if v[5] == "外卖" {
						scene = 2
					}
					food.Status = status
					food.Scene = scene
				}

				isRecommend := 0

				if len(v) > 6 {
					if v[6] == "推荐" {
						isRecommend = 1
					}
					food.IsRecommend = isRecommend
				}

				startSale := 1

				if len(v) > 8 {
					// 起售
					if v[8] != "" {
						startSaleInt, err := strconv.Atoi(v[8])
						if err != nil {
							startSale = 1
						} else {
							startSale = startSaleInt
						}
					}
					food.StartSale = startSale
				}

				if len(v) > 9 {
					// 餐盒费
					var boxFee float64 = 0
					bf, err := strconv.ParseFloat(v[9], 64)
					if err != nil {
						boxFee = 0
					} else {
						boxFee = bf
					}
					food.BoxFee = boxFee
					food.FoodCode = v[13]
				}

				// 重量
				var weight float64 = 0

				if len(v) > 14 {
					w, err := strconv.ParseFloat(v[14], 64)
					if err != nil {
						weight = 0
					} else {
						weight = w
					}
					food.Weight = weight
				}

				var price float64 = 0
				if len(v) > 15 {
					// 售价
					priceFloat, err := strconv.ParseFloat(v[15], 64)
					if err != nil {
						price = 0
					} else {
						price = priceFloat
					}

					if price >= food.Price {
						food.Price = price
					}
				}

				var originalPrice float64 = 0
				if len(v) > 16 {
					// 原价
					originalPriceFloat, err := strconv.ParseFloat(v[16], 64)
					if err != nil {
						originalPrice = 0
					} else {
						originalPrice = originalPriceFloat
					}
					food.OriginalPrice = originalPrice
				}

				// 会员价
				// 库存
				var inventory = -1
				var memberPrice float64 = 0
				if len(v) > 17 {
					memberPriceFloat, err := strconv.ParseFloat(v[17], 64)
					if err != nil {
						memberPrice = 0
					} else {
						memberPrice = memberPriceFloat
					}
					food.MemberPrice = memberPrice

					inventoryInt, err := strconv.Atoi(v[18])
					if err != nil {
						inventory = -1
					} else {
						inventory = inventoryInt
					}
				}

				// 设置规格库存
				if name == v[1] && v[10] == "启用" {
					inventory = foodInventory
				} else {
					name = v[1]
					foodInventory = inventory
				}

				food.Inventory = inventory
				food.DefaultInventory = inventory

				// 销量
				var volume = 0

				if len(v) > 19 {
					volumeInt, err := strconv.Atoi(v[19])
					if err != nil {
						volume = 0
					} else {
						volume = volumeInt
					}
					food.Volume = volume
				}

				// 口味

				var tastyJson []Tasty

				var tasty = ""
				if len(v) > 20 {
					tasty = v[20]
				}

				strings.ReplaceAll(tasty, "；", ";")
				strings.ReplaceAll(tasty, "，", ",")

				tastyArr := strings.Split(tasty, ";")

				for _, tastyItem := range tastyArr {

					if strings.TrimSpace(tastyItem) != "" {
						tastyItemArr := strings.Split(tastyItem, ":")

						if len(tastyItemArr) > 0 {
							tastyKey := tastyItemArr[0]
							tastyValue := tastyItemArr[1]

							tastyJson = append(tastyJson, Tasty{
								AttrKey: tastyKey,
								AttrVal: strings.Split(tastyValue, ","),
							})

						}
					}
				}

				tastyStr, _ := json.Marshal(tastyJson)
				if len(tastyJson) > 0 {
					food.UseTasty = 1
					food.Tasty = string(tastyStr)
				}

				// 缩略图不存在
				if food.Thumbnail == "" {

					filePath, err := new(saasModel.Asset).SyncUpload(mid, v[1])

					if err == nil {
						food.Thumbnail = filePath
						alipayMaterialId := ""
						if food.Thumbnail != filePath || food.AlipayMaterialId == "" {

							if alipayExist && alipay.(bool) {
								// 上传缩略图到阿里支付宝
								file := util.GetAbsPath(filePath)
								bizContent := make(map[string]string, 0)
								fileResult, err := new(merchant.File).Upload(bizContent, file)
								if err != nil {
									rest.rc.Error(c, err.Error(), nil)
									return
								}
								alipayMaterialId = fileResult.Response.MaterialId
								food.AlipayMaterialId = alipayMaterialId
							}
						}
					}

				}

				if v[10] == "启用" {
					food.UseSku = 1
				}

				if tx.RowsAffected == 0 {
					food.CreateAt = time.Now().Unix()
					food.UpdateAt = time.Now().Unix()
					db.Create(&food)
				} else {
					food.UpdateAt = time.Now().Unix()
					db.Save(&food)
				}

				// 分类
				if v[7] != "" {
					categoryName := strings.TrimSpace(v[7])
					category := model.FoodCategory{}
					tx := db.Where("name = ? AND mid = ?", categoryName, mid).First(&category)

					if tx.RowsAffected > 0 {
						categoryPost := model.FoodCategoryPost{}
						tx := db.Where("food_id = ? AND  food_category_id = ?", food.Id, category.Id).First(&categoryPost)

						if tx.RowsAffected == 0 {
							db.Create(&model.FoodCategoryPost{
								FoodId:         food.Id,
								FoodCategoryId: category.Id,
								CreateAt:       time.Now().Unix(),
								UpdateAt:       time.Now().Unix(),
							})
						}

					}

				}

				// 规格更新

				if v[10] == "启用" {

					name := strings.TrimSpace(v[11])
					// 获取当前键是否存在
					attrKey := model.FoodAttrKey{
						Name: name,
					}

					result := db.Where("name = ?", name).First(&attrKey)
					if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
						fmt.Println("result.Error", result.Error.Error())
					}

					if result.RowsAffected == 0 {
						db.Create(&attrKey)
					}

					// 获取规格key
					attrVal := strings.TrimSpace(v[12])

					attrValue := model.FoodAttrValue{
						AttrId:    attrKey.AttrId,
						AttrValue: attrVal,
						Db:        db,
					}

					// 获取规格值id
					attrValue, err = attrValue.AddAttrValue()
					if err != nil {
						fmt.Println("AddAttrValue", attrValue)
					}

					// 获取键值和商品的关联信息
					attrPost := model.FoodAttrPost{
						FoodId:      food.Id,
						AttrValueId: attrValue.AttrValueId,
						Db:          db,
					}

					attrPost, err = attrPost.AddAttrPost()
					if err != nil {
						fmt.Println("AddAttrPost err:", err.Error())
					}

					// 获取规格唯一对应的键值id,多个用|分隔
					attrPostId := strconv.Itoa(attrPost.AttrPostId)

					code := strings.TrimSpace(v[13])

					sku := model.FoodSku{
						AttrPost:         attrPostId,
						FoodId:           food.Id,
						AttrValue:        attrVal,
						Code:             code,
						Weight:           weight,
						Inventory:        inventory,
						DefaultInventory: inventory,
						MemberPrice:      memberPrice,
						UseMember:        0,
						OriginalPrice:    originalPrice,
						Price:            price,
						Volume:           volume,
						Remark:           attrValue.AttrValue,
						Db:               db,
					}

					if food.Price > sku.Price {
						food.Price = sku.Price
					}

					foodInventory += inventory

					if foodInventory < -1 {
						foodInventory = -1
					}

					_, err := sku.FirstOrSave()
					if err != nil {
						fmt.Println("FirstOrSave err", err.Error())
					}

				}

			}

		}
		wg.Done()
	}()

	wg.Wait()

	rest.rc.Success(c, "执行完成！", nil)

}
