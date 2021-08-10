/**
** @创建时间: 2020/8/17 9:00 上午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"time"
)

type AuthAccess struct {
	rc controller.Rest
}

func (rest *AuthAccess) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if rewrite.Id == 1 {
		rest.rc.Error(c, "超级管理员无法被编辑！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	role := model.Role{}

	err = db.Where("id = ?", rewrite.Id).First(&role).Error

	if err != nil {
		rest.rc.Error(c, "查询角色失败！请联系管理员处理", nil)
		return
	}

	var access []model.AuthAccess

	db.Where("role_id = ?", role.Id).Find(&access)

	var rule []string
	for _, v := range access {
		rule = append(rule, v.RuleName)
	}

	fmt.Println("rule", rule)

	result := make(map[string]interface{})

	result["name"] = role.Name
	result["remark"] = role.Remark
	result["access"] = rule

	rest.rc.Success(c, "获取成功！", result)

}

func (rest *AuthAccess) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	if rewrite.Id == 1 {
		rest.rc.Error(c, "超级管理员无法被编辑！", nil)
		return
	}

	// 角色名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	// 角色描述
	remark := c.PostForm("remark")
	if remark == "" {
		rest.rc.Error(c, "描述不能为空！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		new(controller.Rest).Error(c, err.Error(), nil)
		c.Abort()
		return
	}

	// 角色授权列表
	roleAccess := c.PostFormArray("role_access")

	role := model.Role{
		Name:     name,
		Remark:   remark,
		CreateAt: time.Now().Unix(),
	}

	db.Model(&role).Where("id = ?", rewrite.Id).Updates(role)

	// 查询当前存在的auth_access
	var access []model.AuthAccess
	db.Where("role_id = ?", rewrite.Id).Find(&access)

	var arrTemp []interface{}
	for _, v := range roleAccess {
		arrTemp = append(arrTemp, v)
	}
	// 筛查出待删除的内容

	// 数据库中不包含的值
	for _, v := range access {
		ruleName := v.RuleName
		if !inArray(ruleName, arrTemp) {
			db.Where("rule_name = ?", ruleName).Delete(&model.AuthAccess{})
		}
	}

	// 筛查出待添加的内容
	arrTemp = make([]interface{}, 0)
	for _, v := range access {
		ruleName := v.RuleName
		arrTemp = append(arrTemp, ruleName)
	}

	for _, v := range roleAccess {
		if !inArray(v, arrTemp) {
			ruleName := v
			db.Create(&model.AuthAccess{RoleId: rewrite.Id, RuleName: ruleName})
		}
	}

	rest.rc.Success(c, "操作成功！", nil)
}

func inArray(search interface{}, arr []interface{}) bool {

	for _, item := range arr {
		if search == item {
			return true
		}
	}
	return false
}

func (rest *AuthAccess) Store(c *gin.Context) {

	// 角色名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	// 角色描述
	remark := c.PostForm("remark")
	if remark == "" {
		rest.rc.Error(c, "描述不能为空！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 角色授权列表
	roleAccess := c.PostFormArray("role_access")

	role := model.Role{
		Name:     name,
		Remark:   remark,
		CreateAt: time.Now().Unix(),
	}

	db.Where("name = ?", name).FirstOrCreate(&role)

	if role.Id == 0 {
		rest.rc.Error(c, "创建角色失败！请联系管理员", nil)
		return
	}

	for _, v := range roleAccess {
		ruleName := v
		roleAccess := model.AuthAccess{
			RoleId:   role.Id,
			RuleName: ruleName,
		}
		db.Where("role_id = ? AND rule_name = ?", role.Id, ruleName).FirstOrCreate(&roleAccess)
	}

	rest.rc.Success(c, "操作成功！", role.Id)
}
