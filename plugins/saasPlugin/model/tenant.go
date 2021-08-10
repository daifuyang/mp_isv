/**
** @创建时间: 2020/10/3 12:43 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"strings"
)

type Tenant struct {
	Id           int    `json:"id"`
	TenantId     int    `gorm:"type:int(11);not null;index:idx_tenant_id" json:"tenant_id"`
	Company      string `gorm:"type:varchar(100);not null;comment:公司名称" json:"company"`
	UserLogin    string `gorm:"type:varchar(60);not null;index:idx_user_login" json:"user_login"`
	AliasName    string `gorm:"type:varchar(60);not null;index:idx_user_name;comment:子账户登录别名" json:"alias_name"`
	Mobile       string `gorm:"type:varchar(20);not null" json:"mobile"`
	UserPass     string `gorm:"type:varchar(64);not null" json:"user_pass"`
	Avatar       string `json:"avatar"`
	UserNickname string `gorm:"type:varchar(50)" json:"user_nickname"`
	UserRealName string `gorm:"type:varchar(50)" json:"user_realname"`
	UserEmail    string `gorm:"type:varchar(100)" json:"user_email"`
	AccountType  string `gorm:"-" json:"account_type"`
	UserStatus   int    `gorm:"type:tinyint(3);comment:租户状态;default:1;not null" json:"user_status"`
	CreateAt     int64  `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt     int64  `gorm:"type:bigint(20)" json:"update_at"`
}

func (model Tenant) List(query []string, queryArgs []interface{}) ([]Tenant, error) {

	queryStr := strings.Join(query, " AND ")

	var tenant []Tenant
	result := cmf.Db().Where(queryStr, queryArgs...).Find(&tenant)
	if result.Error != nil {
		return tenant, result.Error
	}
	return tenant, nil
}
