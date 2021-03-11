/**
** @创建时间: 2020/8/18 8:48 上午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"fmt"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/util"
	"strconv"
	"time"
)

type User struct {
	rc controller.RestController
}

func (rest *User) Get(c *gin.Context) {

	query := []string{"user_type = ?"}
	queryArgs := []interface{}{"1"}

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

	user := model.User{}
	data, err := user.Get(c, query, queryArgs)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *User) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	query := "id = ? AND user_type = ?"
	queryArgs := []interface{}{rewrite.Id, "1"}

	user := model.User{}
	cmf.NewDb().Where(query, queryArgs...).First(&user)

	type resultStruct struct {
		model.User
		RoleIds []int `json:"role_ids"`
	}

	var roleUser []model.RoleUser
	cmf.NewDb().Where("user_id = ?", user.Id).Find(&roleUser)

	var role []int
	for _, v := range roleUser {
		role = append(role, v.RoleId)
	}

	result := resultStruct{
		User:    user,
		RoleIds: role,
	}

	rest.rc.Success(c, "获取成功！", result)
}

func (rest *User) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
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

	roleIds := c.PostFormArray("role_ids")
	if len(roleIds) <= 0 {
		rest.rc.Error(c, "角色至少选择一项！", nil)
		return
	}

	departmentId := c.PostForm("department_id")
	if departmentId == "" {
		rest.rc.Error(c, "所在部门不能为空！", nil)
		return
	}

	user := model.User{}

	result := cmf.NewDb().Where("user_login = ?", userLogin).First(&user)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "用户不存在！", nil)
		return
	}

	user.UserType = 1
	user.Mobile = mobile
	user.UserRealName = realName
	user.UserLogin = userLogin
	user.UserEmail = email
	user.UpdateAt = time.Now().Unix()
	user.UserStatus = 1

	if user.UserPass != "" {
		user.UserPass = util.GetMd5(password)
	}

	err := cmf.NewDb().Save(&user).Error
	if err != nil {
		rest.rc.Error(c, "更新用户出错，请联系管理员！！", nil)
		return
	}

	// 删除原来角色
	cmf.NewDb().Where("user_id = ?", rewrite.Id).Delete(&model.RoleUser{})

	// 存入用户角色
	for _, v := range roleIds {
		roleId, _ := strconv.Atoi(v)
		roleUser := model.RoleUser{
			RoleId: roleId,
			UserId: rewrite.Id,
		}
		cmf.NewDb().Create(&roleUser)
	}

	rest.rc.Success(c, "更新成功！", nil)
}

func (rest *User) Store(c *gin.Context) {

	userLogin := c.PostForm("user_login")
	if userLogin == "" {
		rest.rc.Error(c, "用户名不能为空！", nil)
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

	user := model.User{
		UserType:     1,
		CreateAt:     time.Now().Unix(),
		Mobile:       mobile,
		UserRealName: realName,
		UserLogin:    userLogin,
		UserPass:     util.GetMd5(password),
		UserEmail:    email,
		UserStatus:   1,
	}

	result := cmf.NewDb().Where("user_login = ?", userLogin).First(&model.User{})

	if result.RowsAffected > 0 {
		rest.rc.Error(c, "用户已存在！", nil)
		return
	}

	err := cmf.NewDb().Create(&user).Error
	if err != nil {
		rest.rc.Error(c, "创建用户出错，请联系管理员！！", nil)
		return
	}

	// 存入用户角色

	userId := user.Id
	fmt.Println("userId", userId)

	for _, v := range roleIds {
		roleId, _ := strconv.Atoi(v)
		roleUser := model.RoleUser{
			RoleId: roleId,
			UserId: userId,
		}
		cmf.NewDb().Create(&roleUser)
	}

	rest.rc.Success(c, "操作成功！", user)
}

func (rest *User) Delete(c *gin.Context) {
	rest.rc.Success(c, "操作成功Delete", nil)
}

func (rest *User) CurrentUser(c *gin.Context) {
	// 获取当前用户
	var currentUser = new(model.User).CurrentUser(c)

	type temp struct {
		model.User
	}

	result := temp{
		User: currentUser,
	}

	controller.RestController{}.Success(c, "获取成功", result)
}
