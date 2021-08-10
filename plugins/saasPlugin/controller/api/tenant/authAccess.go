/**
** @创建时间: 2020/8/17 9:00 上午
** @作者　　: return
** @描述　　:
 */
package tenant

import (
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	if rewrite.Id == 1 {
		rest.rc.Error(c, "超级管理员无法被编辑！", nil)
		return
	}

	role := saasModel.Role{}
	err = db.Where("id = ? AND mid = ?", rewrite.Id, mid).First(&role).Error

	if err != nil {
		rest.rc.Error(c, "查询角色失败！请联系管理员处理", nil)
		return
	}

	type accessTemp struct {
		saasModel.AuthAccess
		RuleId int `json:"rule_id"`
	}
	var access []accessTemp

	prefix := cmf.Conf().Database.Prefix

	tx := db.Table(prefix+"auth_access as a").Select("a.*,r.id as rule_id").
		Joins("INNER JOIN "+prefix+"auth_rule r on a.rule_name = r.name").
		Where("role_id = ? AND a.mid = ?", role.Id, mid).
		Scan(&access)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	var rule []int
	for _, v := range access {
		rule = append(rule, v.RuleId)
	}

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

	mid, _ := c.Get("mid")

	// 角色名称
	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 角色描述
	remark := c.PostForm("remark")
	if remark == "" {
		rest.rc.Error(c, "描述不能为空！", nil)
		return
	}

	// 角色授权列表
	roleAccess := c.PostFormArray("role_access")

	role := saasModel.Role{
		Mid: mid.(int),
		Role: appModel.Role{
			Name:     name,
			Remark:   remark,
			CreateAt: time.Now().Unix(),
		},
	}

	db.Model(&role).Updates(role)

	// 查询当前存在的auth_access
	var access []saasModel.AuthAccess
	db.Where("role_id = ? AND mid = ?", rewrite.Id, mid).Find(&access)

	var arrTemp []interface{}
	for _, v := range roleAccess {

		rule := appModel.AuthRule{}
		tx := db.Where("id = ?", v, mid).First(&rule)
		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, v+"：该规则不存在！", nil)
				return
			}
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		ruleName := rule.Name
		arrTemp = append(arrTemp, ruleName)
	}

	// 数据库中不包含的值
	for _, v := range access {
		ruleName := v.RuleName
		if !inArray(ruleName, arrTemp) {
			db.Where("rule_name = ? AND mid = ?", ruleName, mid).Delete(&saasModel.AuthAccess{})
		}
	}

	for k, v := range roleAccess {
		if !inArray(v, arrTemp) {
			ruleName := arrTemp[k]
			db.Create(&saasModel.AuthAccess{
				Mid: mid.(int),
				AuthAccess: appModel.AuthAccess{
					RoleId: rewrite.Id, RuleName: ruleName.(string),
				},
			})
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

	mid, _ := c.Get("mid")

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

	// 角色授权列表
	roleAccess := c.PostFormArray("role_access")

	role := saasModel.Role{}

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	tx := db.Where("name = ? AND mid = ?", name, mid).First(&role)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if tx.RowsAffected > 0 {
		rest.rc.Error(c, "该角色已存在！", nil)
		return
	}

	role.Mid = mid.(int)
	role.Name = name
	role.Remark = remark
	role.CreateAt = time.Now().Unix()

	tx = db.Where("name = ? AND mid = ?", name, mid).Create(&role)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if role.Id == 0 {
		rest.rc.Error(c, "创建角色失败！请联系管理员", nil)
		return
	}

	for _, v := range roleAccess {

		rule := appModel.AuthRule{}
		tx := db.Where("id = ?", v, mid).First(&rule)
		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, v+"：该规则不存在！", nil)
				return
			}
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		ruleName := rule.Name

		roleAccess := saasModel.AuthAccess{
			Mid: mid.(int),
			AuthAccess: appModel.AuthAccess{
				RoleId:   role.Id,
				RuleName: ruleName,
			},
		}
		db.Where("role_id = ? AND rule_name = ? AND mid = ?", role.Id, ruleName, mid).FirstOrCreate(&roleAccess)
	}

	rest.rc.Success(c, "操作成功！", role.Id)
}
