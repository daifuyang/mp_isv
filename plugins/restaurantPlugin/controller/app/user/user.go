/**
** @创建时间: 2020/12/13 2:00 下午
** @作者　　: return
** @描述　　:
 */
package user

import (
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	wechatUtil "github.com/gincmf/wechatEasySdk/util"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type User struct {
	rc controller.Rest
}

func (rest *User) Show(c *gin.Context) {

	userId, _ := c.Get("mp_user_id")
	Openid, _ := c.Get("open_id")
	mpType, _ := c.Get("mp_type")

	u := resModel.User{}
	data, err := u.Show([]string{"u.id = ? AND u.user_type = 0"}, []interface{}{userId})

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

	openid, _ := c.Get("open_id")
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

	var birthday int64 = 0
	if form.Birthday != "" {

		tmp, err := time.ParseInLocation("2006-01-02", form.Birthday, time.Local)

		if err != nil {
			rest.rc.Error(c, "生日时间格式错误！", nil)
			return
		}

		birthday = tmp.Unix()
		/*rest.rc.Error(c, "生日不能为空！", nil)
		return*/
	}

	u := resModel.User{}

	// 查询当前手机号用户是否存在
	tx := cmf.NewDb().Where("mobile = ?", form.Mobile).First(&u)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if u.Mobile == "" && form.Mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	if u.Mobile != form.Mobile {

		if form.Code == "" {
			rest.rc.Error(c, "验证码不能为空！！", nil)
			return
		}

		mobileInt, err := strconv.Atoi(form.Mobile)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		err = util.ValidateSms(mobileInt, form.Code)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
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
	tx = cmf.NewDb().Model(&resModel.ThirdPart{}).Where("open_id = ? AND mid = ?", openid, mid).Update("user_id", u.Id)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", u)

}

func (rest *User) SaveAvatar(c *gin.Context) {

	userId, _ := c.Get("mp_user_id")
	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	avatar := c.PostForm("avatar")

	if avatar == "" {
		rest.rc.Error(c, "头像不能为空！", nil)
		return
	}

	// 查询当前手机号用户是否存在

	data, err := new(resModel.User).Show([]string{"u.id = ? AND  u.mid = ? AND u.delete_at = 0 AND u.user_type = 0"}, []interface{}{userId, mid})

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if data.Id == 0 {
		rest.rc.Error(c, "用户不存在或已被删除", nil)
		return
	}

	data.Avatar = avatar

	tx := cmf.NewDb().Save(&data)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", data)

}

// 保存手机号
func (rest *User) SaveMobile(c *gin.Context) {

	Openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")

	var form struct {
		Mobile string `json:"mobile"`
		Code   string `json:"code"`
	}

	if err := c.ShouldBindJSON(&form); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	u := resModel.User{}

	// 查询当前手机号用户是否存在绑定
	tx := cmf.NewDb().Where("mobile = ?", form.Mobile).First(&u)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected > 0 {
		rest.rc.Error(c, "该手机号已经被绑定！", nil)
		return
	}

	if form.Code == "" {
		rest.rc.Error(c, "验证码不能为空！", nil)
		return
	}

	mobileInt, err := strconv.Atoi(form.Mobile)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	err = util.ValidateSms(mobileInt, form.Code)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	u.Mid = mid.(int)
	u.Mobile = form.Mobile

	mUser := resModel.User{}
	tx = cmf.NewDb().Where("mobile = ?", form.Mobile).First(&mUser)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}
	// 保存
	if mUser.Id == 0 {
		tx = cmf.NewDb().Create(&u)
	} else {
		if u.Id == 0 {
			u.Id = mUser.Id
		}
		tx = cmf.NewDb().Updates(&u)
	}

	// 更新三方关联
	tx = cmf.NewDb().Model(&resModel.ThirdPart{}).Where("open_id = ? AND mid = ?", Openid, mid).Update("user_id", u.Id)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", u)

}

// 一键绑定手机号
func (rest *User) BindMpMobile(c *gin.Context) {

	openid, _ := c.Get("open_id")
	appId, _ := c.Get("app_id")
	mid, _ := c.Get("mid")
	mpType, _ := c.Get("mp_type")

	encryptedData := c.PostForm("encrypted_data")
	if encryptedData == "" {
		rest.rc.Error(c, "绑定数据不能为空！", nil)
		return
	}

	avatar := c.PostForm("avatar")
	nickname := c.PostForm("nickname")

	iv := c.PostForm("iv")

	mobile := ""

	theme := saasModel.MpTheme{}

	tx := cmf.NewDb().Where("mid = ?", mid).First(&theme)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "非法请求，小程序不存在", nil)
		return
	}

	partType := ""
	if mpType == "alipay" {

		partType = "alipay-mp"
		// 解析手机号
		bizContent := make(map[string]string, 0)
		bizContent["merchant_app_id"] = appId.(string)

		aesGet := new(base.Oauth).AesGet(bizContent)

		key := theme.EncryptKey

		if aesGet.Code == "10000" {
			key = aesGet.AesKey
		} else {
			rest.rc.Error(c, "绑定失败！"+aesGet.SubMsg, aesGet)
			return
		}

		enResult := new(base.Oauth).AesDeCrypt(encryptedData, key)
		if enResult.Code == "10000" {
			mobile = enResult.Mobile
		} else {
			rest.rc.Error(c, "绑定失败！"+enResult.SubMsg, enResult)
			return
		}
	}

	if mpType == "wechat" {

		partType = "wechat-mp"
		query := []string{"tp.open_id = ? AND tp.mid = ?"}
		queryArgs := []interface{}{openid, mid}
		userPart, err := new(resModel.UserPart).Show(query, queryArgs)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		encryptedDataBytes, _ := base64.StdEncoding.DecodeString(encryptedData)

		// 解析手机号
		deCryptData, err := wechatUtil.AesDeCrypt(encryptedDataBytes, []byte(userPart.SessionKey), iv)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		type watermark struct {
			Appid     string
			Timestamp int64
		}

		var deCryptJson struct {
			PhoneNumber     string
			PurePhoneNumber string
			CountryCode     string
			Watermark       watermark
		}

		json.Unmarshal(deCryptData, &deCryptJson)

		fmt.Println("deCryptJson", deCryptJson)

		mobile = deCryptJson.PhoneNumber

	}

	if mobile == "" {
		rest.rc.Error(c, "非法绑定！", nil)
		return
	}

	u := resModel.User{}
	// 查询当前手机号用户是否存在绑定
	prefix := cmf.Conf().Database.Prefix

	tx = cmf.NewDb().Table(prefix+"user u").
		Joins("INNER JOIN "+prefix+"third_part part ON u.id = part.user_id AND part.type = '"+partType+"'").
		Where("u.mobile = ?", mobile).
		Scan(&u)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected > 0 {
		rest.rc.Error(c, "该手机号已经被绑定！", nil)
		return
	}

	u.Mid = mid.(int)
	u.Mobile = mobile

	if u.UserNickname == "" {
		u.UserNickname = nickname
	}

	if u.Avatar == "" {
		u.Avatar = avatar
	}

	mUser := resModel.User{}
	tx = cmf.NewDb().Where("mobile = ?", mobile).First(&mUser)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 保存
	if mUser.Id == 0 {
		tx = cmf.NewDb().Create(&u)
	} else {
		if u.Id == 0 {
			u.Id = mUser.Id
		}
		tx = cmf.NewDb().Updates(&u)
	}

	// 更新三方关联
	tx = cmf.NewDb().Model(&resModel.ThirdPart{}).Where("open_id = ? AND mid = ?", openid, mid).Update("user_id", u.Id)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "绑定成功！", u)

}
