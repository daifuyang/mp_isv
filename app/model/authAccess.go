/**
** @创建时间: 2020/8/4 12:32 下午
** @作者　　: return
 */
package model

// 角色允许访问的规则
type AuthAccess struct {
	Id       int    `json:"id"`
	RoleId   int    `gorm:"type:int(11);comment:角色id;not null" json:"role_id"`
	RuleName string `gorm:"type:varchar(100);comment:规则唯一英文标识,全小写" json:"rule_name"`
}

// 获取允许访问的菜单
type AuthAccessRule struct {
	AuthAccess
	Name string `gorm:"type:varchar(100);comment:规则唯一英文标识,全小写" json:"name"`
}
