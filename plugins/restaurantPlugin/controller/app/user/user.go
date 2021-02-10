/**
** @创建时间: 2020/12/13 2:00 下午
** @作者　　: return
** @描述　　:
 */
package user

import (
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type User struct {
	rc controller.RestController
}

func (rest *User) Show(c *gin.Context) {

	userId, _ := c.Get("mp_user_id")
	Openid, _ := c.Get("open_id")
	mpType, _ := c.Get("mp_type")

	u := model.User{}
	data, err := u.Show([]string{"u.id = ?"}, []interface{}{userId})

	data.OpenId = Openid.(string)
	data.Type = mpType.(string)

	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	au := appModel.User{
		LastLoginAt: time.Now().Unix(),
		LastLoginIp: c.ClientIP(),
	}

	cmf.NewDb().Where("id", userId).Updates(&au)

	data.LastLoginAt = au.LastLoginAt
	data.LastLoginIp = au.LastLoginIp

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *User) Save(c *gin.Context) {

	Openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")

	var form struct {
		NickName string `json:"nickname"`
		Name     string `json:"name"`
		Code     string `json:"code"`
		Mobile   string `json:"mobile"`
		Gender   int    `json:"gender"`
		Birthday string `json:"birthday"`
	}

	if err := c.ShouldBindJSON(&form); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if form.Name == "" {
		rest.rc.Error(c, "姓名不能为空！", nil)
		return
	}

	gender := 0
	if form.Gender == 1 {
		gender = 1
	}

	if form.Gender == 2 {
		gender = 2
	}

	if form.Birthday == "" {
		rest.rc.Error(c, "生日不能为空！", nil)
		return
	}

	tmp, err := time.ParseInLocation("2006-01-02", form.Birthday, time.Local)

	if err != nil {
		rest.rc.Error(c, "生日时间格式错误！", nil)
		return
	}

	birthday := tmp.Unix()

	u := model.User{}

	// 查询当前手机号用户是否存在
	tx := cmf.NewDb().Where("mobile = ?", form.Mobile).First(&u)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if u.Mobile == "" && form.Mobile == "" {
		rest.rc.Error(c,"手机号不能为空！",nil)
		return
	}

	if u.Mobile != form.Mobile {

		if form.Code == "" {
			rest.rc.Error(c,"验证码不能为空！！",nil)
			return
		}

		mobileInt, err := strconv.Atoi(form.Mobile)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		err = util.ValidateSms(mobileInt,form.Code)

		if err != nil {
			rest.rc.Error(c,err.Error(),nil)
			return
		}
	}

	u.Mid = mid.(int)
	u.Mobile = form.Mobile
	u.UserNickname = form.NickName
	u.UserRealName = form.Name
	u.Gender = gender
	u.Birthday = birthday

	// 新用户
	if tx.RowsAffected == 0 {
		tx = cmf.NewDb().Create(&u)
	} else {
		// 更新
		tx = cmf.NewDb().Save(&u)
	}

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 更新三方关联
	tx = cmf.NewDb().Model(&model.ThirdPart{}).Where("open_id = ? AND mid = ?", Openid, mid).Update("user_id", u.Id)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", u)

}

// 保存手机号
func (rest *User) SaveMobile(c *gin.Context) {

	Openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")

	var form struct {
		Mobile   string `json:"mobile"`
		Code     string `json:"code"`
	}

	if err := c.ShouldBindJSON(&form); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	u := model.User{}

	// 查询当前手机号用户是否存在
	tx := cmf.NewDb().Where("mobile = ?", form.Mobile).First(&u)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if form.Code == "" {
		rest.rc.Error(c,"验证码不能为空！",nil)
		return
	}

	mobileInt, err := strconv.Atoi(form.Mobile)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	err = util.ValidateSms(mobileInt,form.Code)

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	u.Mid = mid.(int)
	u.Mobile = form.Mobile

	// 保存
	if u.Id == 0 {
		tx = cmf.NewDb().Create(&u)
	}else{
		tx = cmf.NewDb().Save(&u)
	}

	// 更新三方关联
	tx = cmf.NewDb().Model(&model.ThirdPart{}).Where("open_id = ? AND mid = ?", Openid, mid).Update("user_id", u.Id)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", u)


}