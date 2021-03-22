/**
** @创建时间: 2021/3/19 9:02 下午
** @作者　　: return
** @描述　　:
 */
package model

import "gincmf/app/model"

type AuthAccess struct {
	Mid int `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	model.AuthAccess
}

type AuthAccessRule struct {
	Mid int `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	model.AuthAccessRule
}
