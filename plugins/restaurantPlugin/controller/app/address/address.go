/**
** @创建时间: 2020/12/6 8:06 下午
** @作者　　: return
** @描述　　:
 */
package address

import (
	"errors"
	model2 "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"regexp"
	"strconv"
)

type Address struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取全部地址
 * @Date 2020/12/6 20:13:22
 * @Param
 * @return
 **/
func (rest *Address) Get(c *gin.Context) {

	var address []model2.Address
	result := cmf.NewDb().Find(&address)

	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", address)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取单个地址详情
 * @Date 2020/12/6 20:13:42
 * @Param
 * @return
 **/

func (rest *Address) Show(c *gin.Context) {

	var rewrite struct {
		Id string `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	address := model2.Address{}
	var result *gorm.DB
	if rewrite.Id == "default" {
		result = cmf.NewDb().Where("`default` = ?", 1).First(&address)
	}else {
		result = cmf.NewDb().Where("id = ?", rewrite.Id).First(&address)
	}

	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c,"该地址不存在！", nil)
			return
		}

		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", address)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增单个收货地址
 * @Date 2020/12/6 20:15:49
 * @Param
 * @return
 **/

func (rest *Address) Store(c *gin.Context) {

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	gender := c.PostForm("gender")
	if gender == "" {
		rest.rc.Error(c, "性别不能为空！", nil)
		return
	}

	genderInt, err := strconv.Atoi(gender)
	if err != nil {
		rest.rc.Error(c, "性别参数非法！", nil)
		return
	}

	if genderInt == 1 {
		genderInt = 1
	} else {
		genderInt = 0
	}

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	reg := `0?(13|14|15|17|18|19)[0-9]{9}`
	rgx := regexp.MustCompile(reg)
	if !rgx.MatchString(mobile) {
		rest.rc.Error(c, "手机号格式不正确！", nil)
		return
	}

	mobileInt, _ := strconv.Atoi(mobile)

	addr := c.PostForm("address")
	if addr == "" {
		rest.rc.Error(c, "地址不能为空哦！", nil)
		return
	}

	room := c.PostForm("room")
	if room == "" {
		rest.rc.Error(c, "门牌号不能为空哦！", nil)
		return
	}

	d := c.PostForm("default")

	dInt := 0
	if d == "1" {
		dInt = 1
	}

	address := model2.Address{
		Name:    name,
		Gender:  genderInt,
		Mobile:  mobileInt,
		Address: addr,
		Room:    room,
		Default: dInt,
	}


	if dInt == 1 {
		// 取消默认
		cmf.NewDb().Debug().Model(&model2.Address{}).Where("`default`= ?", 1).Update("default", 0)
	}

	result := cmf.NewDb().Create(&address)

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "新增成功！", address)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新单个收货地址
 * @Date 2020/12/6 20:29:41
 * @Param
 * @return
 **/

func (rest *Address) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}


	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	gender := c.PostForm("gender")
	if gender == "" {
		rest.rc.Error(c, "性别不能为空！", nil)
		return
	}

	genderInt, err := strconv.Atoi(gender)
	if err != nil {
		rest.rc.Error(c, "性别参数非法！", nil)
		return
	}

	if genderInt == 1 {
		genderInt = 1
	} else {
		genderInt = 0
	}

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	reg := `0?(13|14|15|17|18|19)[0-9]{9}`
	rgx := regexp.MustCompile(reg)
	if !rgx.MatchString(mobile) {
		rest.rc.Error(c, "手机号格式不正确！", nil)
		return
	}

	mobileInt, _ := strconv.Atoi(mobile)

	addr := c.PostForm("address")
	if addr == "" {
		rest.rc.Error(c, "地址不能为空哦！", nil)
		return
	}

	room := c.PostForm("room")
	if room == "" {
		rest.rc.Error(c, "门牌号不能为空哦！", nil)
		return
	}

	d := c.PostForm("default")

	dInt := 0
	if d == "1" {
		dInt = 1
	}
	oAddr := model2.Address{}
	res := cmf.NewDb().Where("id = ?",rewrite.Id).First(&oAddr)
	if res.Error != nil {
		if errors.Is(res.Error,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,"该地址不存在！",nil)
			return
		}
		rest.rc.Error(c,res.Error.Error(),nil)
		return
	}

	address := model2.Address{
		Id: oAddr.Id,
		Name:    name,
		Gender:  genderInt,
		Mobile:  mobileInt,
		Address: addr,
		Room:    room,
		Default: dInt,
	}

	if dInt == 1 {
		// 取消默认
		cmf.NewDb().Model(&model2.Address{}).Where("`default` = ?", 1).Update("default", 0)
	}

	result := cmf.NewDb().Save(&address)

	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", address)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 删除单个地址
 * @Date 2020/12/6 20:42:16
 * @Param
 * @return
 **/

func (rest *Address) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	address := model2.Address{}

	result := cmf.NewDb().Where("id = ?",rewrite.Id).Delete(&address)

	if result.Error != nil {
		rest.rc.Error(c,result.Error.Error(),nil)
		return
	}

	rest.rc.Success(c,"删除成功！",nil)

}