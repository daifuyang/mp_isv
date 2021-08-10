package middleware

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"net/url"
	"strconv"
	"strings"
)

/**
 * @Author return <1140444693@qq.com>
 * @Description // 进行用户访问权限判断
 * @Date 2021/3/22 16:46:39
 * @Param
 * @return
 **/
func Rbac(c *gin.Context) {

	if !saasModel.SuperRole(c) {
		mid, exist := c.Get("mid")

		url := c.Request.URL
		urlPath := url.Path
		urlQuery := url.Query()

		db, err := util.NewDb(c)
		if err != nil {
			new(controller.Rest).Error(c, err.Error(), nil)
			c.Abort()
			return
		}

		// 判断当前url是否在所属的业务规则当中
		prefix := cmf.Conf().Database.Prefix

		var ruleApi []model.AuthRuleApi

		tx := db.Table(prefix+"auth_rule_api as api").
			Joins("INNER JOIN "+prefix+"auth_rule r ON api.auth_rule_name = r.name").
			Where("url = ?", urlPath).Scan(&ruleApi)

		// 存在规则，进行验证

		ruleName := ""
		param := ""
		if tx.RowsAffected > 0 {
			for _, ruleItem := range ruleApi {

				ruleName = ruleItem.AuthRuleName

				// 如果api存在参数
				if ruleItem.Param != "" {
					b := inRuleParam(ruleItem.Param, urlQuery)
					if !b {
						new(controller.Rest).ErrorCode(c, 10002, "您无权访问该页面！", nil)
						c.Abort()
						return
					}
					param = ruleItem.Param
					fmt.Println("param", param)
				}
			}

			// 查询当前用户角色
			user,err := new(saasModel.AdminUser).CurrentUser(c)

			if err !=nil {

			}

			// 获取当前用户全部的权限列表
			role := model.GetRoleById(c, user.Id)
			var roleIds []string
			for _, v := range role {
				roleIds = append(roleIds, strconv.Itoa(v.Id))
			}

			// 查询当前角色是否允许访问改权限
			roleIdsStr := strings.Join(roleIds, ",")

			var query []string
			var queryArgs []interface{}

			if roleIdsStr != "" {
				query = append(query, "role_id in (?)")
				queryArgs = append(queryArgs, roleIdsStr)
			}

			query = append(query, "rule_name = ?")
			queryArgs = append(queryArgs, ruleName)

			if exist {
				query = append(query, "mid = ?")
				queryArgs = append(queryArgs, mid)
			}

			queryStr := strings.Join(query, " AND ")

			var authAccessRule saasModel.AuthAccessRule
			prefix := cmf.Conf().Database.Prefix

			// 查询当前角色是否进行授权
			tx := db.Table(prefix+"auth_access access").Select("access.*,r.name").
				Joins("INNER JOIN "+prefix+"auth_rule r ON access.rule_name = r.name").Where(queryStr, queryArgs...).Scan(&authAccessRule)

			if tx.Error != nil {
				new(controller.Rest).Error(c, tx.Error.Error(), nil)
				c.Abort()
				return
			}

			if authAccessRule.Id == 0 {
				new(controller.Rest).ErrorCode(c, 10002, "您无权访问该页面！", nil)
				c.Abort()
				return
			}

		}
	}

	c.Next()

}

// 存在参数
func inRuleParam(param string, query url.Values) (result bool) {

	paramMap := strings.Split(param, "&")
	for _, p := range paramMap {
		paramItem := strings.Split(p, "=")
		if len(paramItem) > 0 {
			result := false
			for k, v := range query {
				queryValue := strings.Join(v, "")
				if paramItem[0] == k && paramItem[1] == queryValue {
					result = true
				}
			}
			if !result {
				return false
			}
		}
	}

	return true

}
