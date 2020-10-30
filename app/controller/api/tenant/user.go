/**
** @创建时间: 2020/9/30 3:18 下午
** @作者　　: return
** @描述　　: // 租户信息相关
 */
package tenant

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	restaurantMigrate "gincmf/plugins/restaurantPlugin/migrate"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfModel "github.com/gincmf/cmf/model"
	cmfUtil "github.com/gincmf/cmf/util"
	"runtime"
	"strconv"
	"time"
)

type UserController struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 租户注册用户
 * @Date 2020/10/30 20:43:26
 * @Param
 * @return
 **/
func (rest *UserController) Register(c *gin.Context) {

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c,"手机号不能为空！",nil)
		return
	}

	uRes := cmf.Db.Where("mobile",mobile).First(&model.Tenant{})
	if uRes.RowsAffected > 0 {
		rest.rc.Error(c,"该手机号已经被绑定注册！",nil)
		return
	}

	mobileInt,err := strconv.Atoi(mobile)

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	smsArr := util.SmsCodeArr[mobileInt]
	if smsArr == nil {
		rest.rc.Error(c,"请先获取短信验证码！",nil)
		return
	}

	if smsArr.Expire < time.Now().Unix() {
		rest.rc.Error(c,"该短信验证码已经失效！请重新获取",nil)
		return
	}

	smsCode := c.PostForm("sms_code")
	if smsCode == "" {
		rest.rc.Error(c,"短信验证码不能为空！",nil)
		return
	}

	if smsArr.Code != smsCode {
		rest.rc.Error(c,"短信验证码验证出错！请检查您的验证码是否正确",nil)
		return
	}

	password := c.PostForm("password")
	if password == "" {
		rest.rc.Error(c,"密码不能为空！",nil)
		return
	}

	repass := c.PostForm("repass")
	if repass == "" {
		rest.rc.Error(c,"确认密码不能为空",nil)
		return
	}

	if password != repass {
		rest.rc.Error(c,"两次密码验证不一致",nil)
		return
	}

	password = cmfUtil.GetMd5(password)

	config := cmf.Conf()

	year,month,day := time.Now().Date()
	fmt.Println("year",year)
	yearStr := strconv.Itoa(year)
	monthStr := strconv.Itoa(int(month))
	if month < 10 {
		monthStr = "0"+monthStr
	}
	dayStr := strconv.Itoa(day)
	if day < 10 {
		dayStr = "0"+dayStr
	}
	insertKey := yearStr + monthStr + dayStr
	val ,err := cmf.RedisDb.Incr(insertKey).Result()

	if err != nil {
		_,_,line,_ := runtime.Caller(0)
		fmt.Println("redis err"+strconv.Itoa(line),err.Error())
	}

	nStr := insertKey + strconv.FormatInt(val,10)
	n,_ := strconv.Atoi(nStr)

	tenantId :=util.EncodeId(uint64(n))
	tenantIdStr := strconv.Itoa(tenantId)
	fmt.Println("tenantIdStr",tenantIdStr)
	// 存入当前租户
	tenant := model.Tenant{
		TenantId: tenantIdStr,
		UserLogin: mobile,
		Mobile:mobile,
		UserPass:password,
		CreateAt: time.Now().Unix(),
	}

	result := cmf.Db.Create(&tenant)

	if result.RowsAffected > 0 {
		smsArr.Expire = time.Now().Unix()
		dbName := "tenant_"+tenantIdStr

		cmfModel.CreateTable(dbName,config)
		dsn := cmfModel.NewDsn(dbName,config)
		db := cmfModel.NewDb(dsn,config.Database.Prefix)

		// 租户创建user表
		db.AutoMigrate(&model.User{})
		db.AutoMigrate(&model.MpTheme{})
		db.AutoMigrate(&model.MpThemePage{})

		// 餐厅插件
		// 租户同步数据库迁移
		rMigrate := restaurantMigrate.Restaurant{Db: db}
		rMigrate.AutoMigrate()
		rest.rc.Success(c, "注册成功！", nil)

	}else{
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
func (rest *UserController) CurrentUser(c *gin.Context) {
	// 获取当前用户
	 currentTenant := util.CurrentTenant(c)

	 rest.rc.Success(c, "获取成功", currentTenant)
}