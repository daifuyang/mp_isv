/**
** @创建时间: 2020/8/18 8:48 上午
** @作者　　: return
** @描述　　:
 */
package tenant

import (
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/saasPlugin/model"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfUtil "github.com/gincmf/cmf/util"
	"gorm.io/gorm"
	"regexp"
	"strconv"
	"time"
)

type AdminUser struct {
	rc controller.Rest
}

func (rest *AdminUser) Get(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	mid, _ := c.Get("mid")

	query := []string{"mid = ?"}
	queryArgs := []interface{}{mid}

	userLogin := c.Query("user_login")
	if userLogin != "" {
		query = append(query, "user_login LIKE ?")
		queryArgs = append(queryArgs, "%"+userLogin+"%")
	}

	userNickname := c.Query("user_nickname")
	if userNickname != "" {
		query = append(query, "user_nickname like ?")
		queryArgs = append(queryArgs, "%"+userNickname+"%")
	}

	userEmail := c.Query("user_email")
	if userEmail != "" {
		query = append(query, "user_email like ?")
		queryArgs = append(queryArgs, "%"+userEmail+"%")
	}

	adminUser := model.AdminUser{
		Db: db,
	}
	data, err := adminUser.Get(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *AdminUser) Show(c *gin.Context) {

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

	query := "au.id = ? AND mid = ?"
	queryArgs := []interface{}{rewrite.Id, mid}

	prefix := cmf.Conf().Database.Prefix

	adminUser := model.AdminUser{}

	tx := db.Table(prefix+"admin_user as au").
		Joins("INNER JOIN "+prefix+"mp_theme_admin_user_post p ON au.id = p.admin_user_id").
		Where(query, queryArgs...).First(&adminUser)

	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该管理员不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	type resultStruct struct {
		model.AdminUser
		RoleIds []int `json:"role_ids"`
	}

	var roleUser []appModel.RoleUser
	db.Where("user_id = ?", adminUser.Id).Find(&roleUser)

	var role []int
	for _, v := range roleUser {
		role = append(role, v.RoleId)
	}

	result := resultStruct{
		AdminUser: adminUser,
		RoleIds:   role,
	}

	rest.rc.Success(c, "获取成功！", result)
}

func (rest *AdminUser) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	userId, _ := c.Get("user_id")

	userLogin := c.PostForm("user_login")
	if userLogin == "" {
		rest.rc.Error(c, "用户名不能为空！", nil)
		return
	}

	r, err := regexp.Compile("^[\u4e00-\u9fa5_a-zA-Z0-9]+$")
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	b := r.MatchString(userLogin)
	if !b {
		rest.rc.Error(c, "用户名只能包含中文英文数字和下划线！", nil)
		return
	}

	password := c.PostForm("user_pass")

	email := c.PostForm("user_email")

	mobile := c.PostForm("mobile")

	realName := c.PostForm("user_realname")

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	adminUser := model.AdminUser{}

	result := db.Where("id = ?", rewrite.Id).First(&adminUser)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "用户不存在！", nil)
		return
	}

	adminUser.Mobile = mobile
	adminUser.UserRealName = realName
	adminUser.UserLogin = userLogin
	adminUser.UserEmail = email
	adminUser.UpdateAt = time.Now().Unix()
	adminUser.UserStatus = 1

	if password != "" {
		adminUser.UserPass = cmfUtil.GetMd5(password)
	}

	err = db.Save(&adminUser).Error
	if err != nil {
		rest.rc.Error(c, "更新用户出错，请联系管理员！！", nil)
		return
	}

	if model.SuperRole(c) {

		tenant := model.Tenant{}
		tenantId, _ := c.Get("tenant_id")
		tx := cmf.Db().Where("tenant_id = ?", tenantId).First(&tenant)
		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, "该租户不存在！", nil)
				return
			}
		}

		// 如果是创建人
		if userId.(int) == 1 {
			tenant.UserLogin = userLogin
			tenant.Mobile = mobile
			tenant.UserRealName = realName
			tenant.UserEmail = email
			tenant.UpdateAt = time.Now().Unix()
			if password != "" {
				tenant.UserPass = cmfUtil.GetMd5(password)
			}
		}

		aliasName := c.PostForm("alias_name")

		if aliasName != "" {
			tenant.AliasName = aliasName
		}

		tx = cmf.Db().Updates(&tenant)
		if tx.Error != nil {
			rest.rc.Error(c, "更新用户出错，请联系管理员！！", nil)
			return
		}

	}

	roleIds := c.PostFormArray("role_ids")

	if len(roleIds) > 0 {

		// 删除原来角色
		db.Where("user_id = ?", rewrite.Id).Delete(&appModel.RoleUser{})

		// 存入用户角色
		for _, v := range roleIds {
			roleId, _ := strconv.Atoi(v)
			roleUser := appModel.RoleUser{
				RoleId: roleId,
				UserId: rewrite.Id,
			}
			db.Create(&roleUser)
		}

	}

	session := sessions.Default(c)
	session.Delete("user")
	session.Delete("tenant")
	session.Save()

	rest.rc.Success(c, "更新成功！", nil)
}

func (rest *AdminUser) Store(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	userLogin := c.PostForm("user_login")
	if userLogin == "" {
		rest.rc.Error(c, "用户名不能为空！", nil)
		return
	}

	r, _ := regexp.Compile("^[\u4e00-\u9fa5_a-zA-Z0-9]+$")
	b := r.MatchString(userLogin)
	if !b {
		rest.rc.Error(c, "用户名只能包含中文英文数字和下划线！", nil)
		return
	}

	password := c.PostForm("user_pass")
	if password == "" {
		rest.rc.Error(c, "密码不能为空！", nil)
		return
	}

	email := c.PostForm("user_email")

	mobile := c.PostForm("mobile")
	realName := c.PostForm("user_realname")

	roleIds := c.PostFormArray("role_ids")
	if len(roleIds) <= 0 {
		rest.rc.Error(c, "角色至少选择一项！", nil)
		return
	}

	adminUser := model.AdminUser{
		CreateAt:     time.Now().Unix(),
		Mobile:       mobile,
		UserRealName: realName,
		UserLogin:    userLogin,
		UserPass:     cmfUtil.GetMd5(password),
		UserEmail:    email,
		UserStatus:   1,
	}

	result := db.Where("user_login = ?", userLogin).First(&model.AdminUser{})

	if result.RowsAffected > 0 {
		rest.rc.Error(c, "用户已存在！", nil)
		return
	}

	err = db.Create(&adminUser).Error
	if err != nil {
		rest.rc.Error(c, "创建用户出错，请联系管理员！！", nil)
		return
	}

	userId := adminUser.Id
	// 创建用户和门店的关联关系
	themePost := model.MpThemeAdminUserPost{
		Mid:         mid.(int),
		AdminUserId: userId,
		Status:      1,
	}

	tx := db.Debug().Where("mid = ? and admin_user_id = ?", mid, userId).FirstOrCreate(&themePost)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 存入用户角色
	for _, v := range roleIds {
		roleId, _ := strconv.Atoi(v)

		// 查看当前角色是否存在小程序中心
		role := model.Role{}
		tx := db.Where("id = ? AND mid = ?", roleId, mid).First(&role)
		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, "非法传参！改门店不存在该角色！", nil)
			}
		}

		roleUser := appModel.RoleUser{
			RoleId: roleId,
			UserId: userId,
		}
		db.Create(&roleUser)

	}

	rest.rc.Success(c, "操作成功！", adminUser)
}

func (rest *AdminUser) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}

func (rest *AdminUser) CurrentUser(c *gin.Context) {
	// 获取当前用户
	var currentUser, err = new(model.AdminUser).CurrentUser(c)

	if err != nil {
		new(controller.Rest).Error(c, "获取成功", nil)
		return
	}

	aliasName, _ := c.Get("aliasName")

	var result struct {
		model.AdminUser
		AliasName string `json:"alias_name"`
	}

	result.AdminUser = currentUser
	result.AliasName = aliasName.(string)

	new(controller.Rest).Success(c, "获取成功", result)
}
