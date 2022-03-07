/**
** @创建时间: 2020/9/30 3:18 下午
** @作者　　: return
** @描述　　: // 租户信息相关
 */
package tenant

import (
	"errors"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"gincmf/plugins/saasPlugin/migrate"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfModel "github.com/gincmf/cmf/model"
	cmfUtil "github.com/gincmf/cmf/util"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type User struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 代用户快速注册后台
 * @Date 2021/5/8 13:24:8
 * @Param
 * @return
 **/
func (rest *User) FastRegister(c *gin.Context) {

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	uRes := cmf.Db().Where("mobile", mobile).First(&saasModel.Tenant{})
	if uRes.RowsAffected > 0 {
		rest.rc.Error(c, "该手机号已经被绑定注册！", nil)
		return
	}

	password := c.PostForm("password")
	if password == "" {
		rest.rc.Error(c, "密码不能为空！", nil)
		return
	}

	pwd := c.PostForm("pwd")

	if pwd != "codecloud2021" {
		rest.rc.Error(c, "安全秘钥验证失败！", nil)
		return
	}

	password = cmfUtil.GetMd5(password)

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv:user" + yearStr + monthStr + dayStr

	number := util.EncryptUuid(insertKey, date, 0)
	tenantId, _ := strconv.Atoi(number)

	// 存入当前租户
	tenant := saasModel.Tenant{
		TenantId:  tenantId,
		UserLogin: mobile,
		Mobile:    mobile,
		UserPass:  password,
		CreateAt:  time.Now().Unix(),
	}

	result := cmf.Db().Create(&tenant)

	if result.RowsAffected > 0 {

		dbName := "tenant_" + strconv.Itoa(tenantId)

		cmfModel.CreateTable(dbName, cmf.Conf())

		// 调用saas初始化
		migrate.AutoMigrate(dbName)

		adminUser := saasModel.AdminUser{
			UserLogin: mobile,
			Mobile:    mobile,
			UserPass:  password,
			CreateAt:  time.Now().Unix(),
			Db:        cmf.ManualDb(dbName),
		}

		adminUser.Init()

		rest.rc.Success(c, "注册成功！", nil)

	} else {
		rest.rc.Error(c, "注册失败！", result.Error.Error())
	}

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 租户注册用户
 * @Date 2020/10/30 20:43:26
 * @Param
 * @return
 **/
func (rest *User) Register(c *gin.Context) {

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	uRes := cmf.Db().Where("mobile", mobile).First(&saasModel.Tenant{})
	if uRes.RowsAffected > 0 {
		rest.rc.Error(c, "该手机号已经被绑定注册！", nil)
		return
	}

	mobileInt, err := strconv.Atoi(mobile)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	smsCode := c.PostForm("sms_code")
	if smsCode == "" {
		rest.rc.Error(c, "短信验证码不能为空！", nil)
		return
	}

	err = util.ValidateSms(mobileInt, smsCode)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	password := c.PostForm("password")
	if password == "" {
		rest.rc.Error(c, "密码不能为空！", nil)
		return
	}

	repass := c.PostForm("repass")
	if repass == "" {
		rest.rc.Error(c, "确认密码不能为空", nil)
		return
	}

	if password != repass {
		rest.rc.Error(c, "两次密码验证不一致", nil)
		return
	}

	password = cmfUtil.GetMd5(password)

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr
	insertKey := "mp_isv:user" + yearStr + monthStr + dayStr

	number := util.EncryptUuid(insertKey, date, 0)
	tenantId, _ := strconv.Atoi(number)

	// 存入当前租户
	tenant := saasModel.Tenant{
		TenantId:  tenantId,
		UserLogin: mobile,
		Mobile:    mobile,
		UserPass:  password,
		CreateAt:  time.Now().Unix(),
	}

	result := cmf.Db().Create(&tenant)

	if result.RowsAffected > 0 {

		dbName := "tenant_" + strconv.Itoa(tenantId)

		cmfModel.CreateTable(dbName, cmf.Conf())

		// 调用saas初始化
		migrate.AutoMigrate(dbName)

		adminUser := saasModel.AdminUser{
			UserLogin: mobile,
			Mobile:    mobile,
			UserPass:  password,
			CreateAt:  time.Now().Unix(),
		}

		adminUser.Init()

		rest.rc.Success(c, "注册成功！", nil)

	} else {
		rest.rc.Error(c, "注册失败！", result.Error.Error())
	}

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 忘记用户密码
 * @Date 2020/10/30 20:43:26
 * @Param
 * @return
 **/
func (rest *User) Forget(c *gin.Context) {

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	nameArr := strings.Split(mobile, "@")
	mobi := nameArr[0]

	// 如果是主账号
	if len(nameArr) == 1 {

		tenant := saasModel.Tenant{}
		uRes := cmf.Db().Where("mobile", mobi).First(&tenant)
		if uRes.RowsAffected == 0 {
			rest.rc.Error(c, "该手机号号未注册！", nil)
			return
		}

		mobileInt, err := strconv.Atoi(mobi)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		smsCode := c.PostForm("sms_code")
		if smsCode == "" {
			rest.rc.Error(c, "短信验证码不能为空！", nil)
			return
		}

		err = util.ValidateSms(mobileInt, smsCode)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		password := c.PostForm("password")
		if password == "" {
			rest.rc.Error(c, "密码不能为空！", nil)
			return
		}

		repass := c.PostForm("repass")
		if repass == "" {
			rest.rc.Error(c, "确认密码不能为空", nil)
			return
		}

		if password != repass {
			rest.rc.Error(c, "两次密码验证不一致", nil)
			return
		}

		password = cmfUtil.GetMd5(password)

		// 存入当前租户
		tenant.UserPass = password
		tenant.UpdateAt = time.Now().Unix()
		tx := cmf.Db().Updates(&tenant)

		//
		tenantId := tenant.TenantId

		u := saasModel.AdminUser{}
		tx = cmf.ManualDb("tenant_"+strconv.Itoa(tenantId)).First(&u, "mobile = ? AND user_status = 1 AND delete_at = 0", nameArr[0]) // 查询
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		u.UserPass = password
		u.UpdateAt = time.Now().Unix()
		cmf.ManualDb("tenant_" + strconv.Itoa(tenantId)).Updates(&u)

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
	}

	// 如果是子账户
	if len(nameArr) == 2 {

		// 查询用户所属租户
		t := saasModel.Tenant{}
		tx := cmf.Db().First(&t, "alias_name = ?", nameArr[1]) // 查询
		if tx.Error != nil {
			if !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, "该租户不存在！", nil)
				return
			}
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		tenantId := t.TenantId

		u := saasModel.AdminUser{}
		tx = cmf.ManualDb("tenant_"+strconv.Itoa(tenantId)).First(&u, "mobile = ? AND user_status = 1 AND delete_at = 0", nameArr[0]) // 查询
		if tx.RowsAffected == 0 {
			rest.rc.Error(c, "该用户不存在！", nil)
			return
		}

		mobileInt, err := strconv.Atoi(mobi)

		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		smsCode := c.PostForm("sms_code")
		if smsCode == "" {
			rest.rc.Error(c, "短信验证码不能为空！", nil)
			return
		}

		err = util.ValidateSms(mobileInt, smsCode)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		password := c.PostForm("password")
		if password == "" {
			rest.rc.Error(c, "密码不能为空！", nil)
			return
		}

		repass := c.PostForm("repass")
		if repass == "" {
			rest.rc.Error(c, "确认密码不能为空", nil)
			return
		}

		if password != repass {
			rest.rc.Error(c, "两次密码验证不一致", nil)
			return
		}

		password = cmfUtil.GetMd5(password)

		u.UserPass = password
		u.UpdateAt = time.Now().Unix()
		tx = cmf.ManualDb("tenant_" + strconv.Itoa(tenantId)).Updates(&u)

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

	}

	rest.rc.Success(c, "密码找回成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 修改租户信息
 * @Date 2021/3/19 16:7:18
 * @Param
 * @return
 **/
func (rest *User) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	aliasName := c.PostForm("alias_name")
	if aliasName == "" {
		rest.rc.Error(c, "公司别名不能为空！", nil)
		return
	}

	userLogin := c.PostForm("user_login")
	if userLogin == "" {
		rest.rc.Error(c, "用户名不能为空！", nil)
		return
	}

	password := c.PostForm("user_pass")

	email := c.PostForm("user_email")

	mobile := c.PostForm("mobile")

	realName := c.PostForm("user_realname")

	tenant := saasModel.Tenant{}

	result := cmf.Db().Where("user_login = ?", userLogin).First(&tenant)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "用户不存在！", nil)
		return
	}

	if aliasName != strconv.Itoa(tenant.TenantId) {
		tenant.AliasName = aliasName
	}

	tenant.Mobile = mobile
	tenant.UserRealName = realName
	tenant.UserLogin = userLogin
	tenant.UserEmail = email
	tenant.UpdateAt = time.Now().Unix()
	tenant.UserStatus = 1

	if password != "" {
		tenant.UserPass = cmfUtil.GetMd5(password)
	}

	err := cmf.Db().Save(&tenant).Error
	if err != nil {
		rest.rc.Error(c, "更新用户出错，请联系管理员！！", nil)
		return
	}

	session := sessions.Default(c)
	session.Delete("tenant")
	session.Save()

	rest.rc.Success(c, "更新成功！", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取当前租户个人信息
 * @Date 2020/10/30 20:44:09
 * @Param
 * @return
 **/
func (rest *User) CurrentTenant(c *gin.Context) {
	// 获取当前用户
	currentTenant, err := saasModel.CurrentTenant(c)
	if err != nil {
		rest.rc.Error(c, "该租户不存在！", nil)
		return
	}

	if currentTenant.AliasName == "" {
		currentTenant.AliasName = strconv.Itoa(currentTenant.TenantId)
	}

	rest.rc.Success(c, "获取成功", currentTenant)
}

func (rest *User) CurrentUser(c *gin.Context) {
	// 获取当前用户
	var currentUser = new(resModel.User).CurrentUser(c)

	aliasName, _ := c.Get("aliasName")

	var result struct {
		resModel.User
		AliasName string `json:"alias_name"`
		TenantId  string `json:"tenant_id"`
	}

	tenantId, _ := c.Get("tenant_id")
	result.User = currentUser
	result.TenantId = strconv.Itoa(tenantId.(int))
	result.AliasName = aliasName.(string)

	new(controller.Rest).Success(c, "获取成功", result)
}
