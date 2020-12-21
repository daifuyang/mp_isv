/**
** @创建时间: 2020/9/30 3:18 下午
** @作者　　: return
** @描述　　: // 租户信息相关
 */
package tenant

import (
	"gincmf/app/util"
	"gincmf/plugins/saasPlugin/migrate"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfModel "github.com/gincmf/cmf/model"
	cmfUtil "github.com/gincmf/cmf/util"
	"strconv"
	"time"
)

type User struct {
	rc controller.RestController
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

	uRes := cmf.NewDb().Where("mobile", mobile).First(&saasModel.Tenant{})
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

	err = util.ValidateSms(mobileInt,smsCode)
	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
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

	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */
	insertKey := "mp_isv:user:" + yearStr + monthStr + dayStr

	// 设置当天失效时间
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
	cmf.NewRedisDb().ExpireAt(insertKey, today)
	val := util.SetIncr(insertKey)

	nStr := yearStr + monthStr + dayStr + strconv.FormatInt(val, 10)
	n, _ := strconv.Atoi(nStr)
	tenantId := util.EncodeId(uint64(n))

	// 存入当前租户
	tenant := saasModel.Tenant{
		TenantId:  tenantId,
		UserLogin: mobile,
		Mobile:    mobile,
		UserPass:  password,
		CreateAt:  time.Now().Unix(),
	}

	result := cmf.NewDb().Create(&tenant)

	if result.RowsAffected > 0 {
		go func() {
			dbName := "tenant_" + strconv.Itoa(tenantId)

			cmfModel.CreateTable(dbName, cmf.Conf())

			cmf.ManualDb(dbName)
			// 调用saas初始化
			migrate.AutoMigrate()

		}()

		rest.rc.Success(c, "注册成功！", nil)

	} else {
		rest.rc.Error(c, "注册失败！", result.Error.Error())
	}

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取当前租户个人信息
 * @Date 2020/10/30 20:44:09
 * @Param
 * @return
 **/
func (rest *User) CurrentUser(c *gin.Context) {
	// 获取当前用户
	currentTenant := saasModel.CurrentTenant(c)
	rest.rc.Success(c, "获取成功", currentTenant)
}