/**
** @创建时间: 2020/12/6 8:10 下午
** @作者　　: return
** @描述　　:
 */
package model

type Address struct {
	Id      int    `json:"id"`
	Mid     int    `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	Name    string `gorm:"type:varchar(40);not null" json:"name"`
	Gender  int    `gorm:"type:tinyint(3);comment:性别;default:0;comment:性别;0:保密,1:男,2:女;not null" json:"gender"`
	Mobile  int    `gorm:"type:varchar(20);comment:手机号;not null" json:"mobile"`
	Address string `gorm:"type:varchar(255);comment:地址;not null" json:"address"`
	Room    string `gorm:"type:varchar(100);comment:门牌号;not null; json:"room"`
	Default int    `gorm:"type:tinyint(3);comment:默认;not null" json:"default"`
}
