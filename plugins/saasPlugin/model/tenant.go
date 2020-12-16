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
	UserLogin    string `gorm:"type:varchar(60);not null;index:idx_user_login" json:"user_login"`
	Mobile       string `gorm:"type:varchar(20);not null" json:"mobile"`
	UserPass     string `gorm:"type:varchar(64);not null" json:"user_pass"`
	Avatar       string `json:"avatar"`
	TenantStatus int    `gorm:"type:tinyint(3);not null" json:"user_status"`
	CreateAt     int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt     int64  `gorm:"type:int(11)" json:"update_at"`
}

func (model Tenant) List(query []string, queryArgs []interface{}) ([]Tenant, error) {

	queryStr := strings.Join(query, " AND ")

	var tenant []Tenant
	result := cmf.Db().Where(queryStr,queryArgs...).Find(&tenant)
	if result.Error != nil {
		return tenant, result.Error
	}
	return tenant,nil
}
