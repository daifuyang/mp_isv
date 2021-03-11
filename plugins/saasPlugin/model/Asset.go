/**
** @创建时间: 2021/2/28 11:30 上午
** @作者　　: return
** @描述　　:
 */
package model

import "gincmf/app/model"

type Asset struct {
	model.Asset
	Mid int `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
}
