/**
** @创建时间: 2020/10/3 12:43 下午
** @作者　　: return
** @描述　　:
 */
package model

type Tenant struct {
	Id        int    `json:"id"`
	TenantId  string `gorm:"type:varchar(32);not null" json:"tenant_id"`
	UserLogin string `gorm:"type:varchar(60);not null" json:"user_login"`
	Mobile    string `gorm:"type:varchar(20);not null" json:"mobile"`
	UserPass  string `gorm:"type:varchar(64);not null" json:"user_pass"`
	Avatar    string `json:"avatar"`
	CreateAt  int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt  int64  `gorm:"type:int(11)" json:"update_at"`
}
