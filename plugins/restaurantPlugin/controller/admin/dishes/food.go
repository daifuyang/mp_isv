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

type extVale struct {
	Value string `json:"value"`
	Label string `json:"label"`
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

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

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
			Excerpt:          excerpt,
			FoodCode:         foodCode,
			DishType:         dishType,
			Flavor:           flavor,
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

	if useSkuInt == 1 {

		//
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

			skus = append(skus, sku)
		}

		skuDelQuery = append(skuDelQuery, "food_id = ?")
		skuDelQueryStr := strings.Join(skuDelQuery, " AND ")
		skuDelQueryArgs = append(skuDelQueryArgs, food.Id)

		tx.Where(skuDelQueryStr, skuDelQueryArgs...).Delete(&model.FoodSku{})

		attrQuery = append(attrQuery, "food_id = ?")
		attrQueryStr := strings.Join(attrQuery, " AND ")
		attrQueryArgs = append(attrQueryArgs, food.Id)
		tx.Where(attrQueryStr, attrQueryArgs...).Delete(&model.FoodAttrPost{})

		for _, sku := range skus {
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

	// 获取小程序mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

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
			Excerpt:          excerpt,
			FoodCode:         foodCode,
			DishType:         dishType,
			Flavor:           flavor,
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

	if useSkuInt == 1 {
		// 解析多规格
		var skuMap []skuJson
		json.Unmarshal(skuBytes, &skuMap)

		fmt.Println("skuMap", skuMap)

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
				Remark:           attrValue.AttrValue,
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
