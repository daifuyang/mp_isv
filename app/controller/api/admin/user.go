/**
** @创建时间: 2020/8/18 8:48 上午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"errors"
	"fmt"
	"gincmf/app/model"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/util"
	"gorm.io/gorm"
	"regexp"
	"strconv"
	"time"
)

type User struct {
	rc controller.Rest
}

func (rest *User) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	query := []string{"user_type = ?", "mid = ?"}
	queryArgs := []interface{}{"1", mid}

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

	user := resModel.User{}
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

	mid, _ := c.Get("mid")

	query := "id = ? AND user_type = ? AND mid = ?"
	queryArgs := []interface{}{rewrite.Id, "1", mid}

	user := resModel.User{}
	tx := cmf.NewDb().Where(query, queryArgs...).First(&user)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该管理员不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	type resultStruct struct {
		resModel.User
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

	email := c.PostForm("user_email")

	mobile := c.PostForm("mobile")

	realName := c.PostForm("user_realname")

	roleIds := c.PostFormArray("role_ids")
	if len(roleIds) <= 0 {
		rest.rc.Error(c, "角色至少选择一项！", nil)
		return
	}

	user := resModel.User{}

	result := cmf.NewDb().Where("user_login = ?", userLogin).First(&user)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "用户不存在！", nil)
		return
	}

	user.Mid = mid.(int)
	user.UserType = 1
	user.Mobile = mobile
	user.UserRealName = realName
	user.UserLogin = userLogin
	user.UserEmail = email
	user.UpdateAt = time.Now().Unix()
	user.UserStatus = 1

	if password != "" {
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

	user := resModel.User{
		Mid: mid.(int),
		User: model.User{
			UserType:     1,
			CreateAt:     time.Now().Unix(),
			Mobile:       mobile,
			UserRealName: realName,
			UserLogin:    userLogin,
			UserPass:     util.GetMd5(password),
			UserEmail:    email,
			UserStatus:   1,
		},
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

	aliasName, _ := c.Get("aliasName")

	var result struct {
		model.User
		AliasName string `json:"alias_name"`
	}

	result.User = currentUser
	result.AliasName = aliasName.(string)

	controller.Rest{}.Success(c, "获取成功", result)
}
