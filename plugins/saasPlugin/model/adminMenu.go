package model

/*
Author:frank
Desc  :后台菜单列表
*/
type AdminMenu struct {
	Id         int     `json:"id"`
	UniqueName string  `gorm:"type:varchar(30);comment:唯一名称" json:"unique_name"`
	ParentId   int     `gorm:"type:int(11);comment:所属父类id;default:0" json:"parent_id"`
	Name       string  `gorm:"type:varchar(30);comment:路由名称" json:"name"`
	Path       string  `gorm:"type:varchar(100);comment:路由路径" json:"path"`
	Icon       string  `gorm:"type:varchar(30);comment:图标名称" json:"icon"`
	HideInMenu int     `gorm:"type:tinyint(3);comment:菜单中隐藏;default:0" json:"hide_in_menu"`
	ListOrder  float64 `gorm:"type:float;comment:排序;default:10000" json:"list_order"`
}

type tempAdminMenu struct {
	UniqueName string  `gorm:"type:varchar(30);comment:唯一名称" json:"unique_name"`
	Name       string  `gorm:"type:varchar(30);comment:路由名称" json:"name"`
	Icon       string  `gorm:"type:varchar(30);comment:图标名称" json:"icon"`
	Path       string  `gorm:"type:varchar(100);comment:路由路径" json:"path"`
	Title      string  `gorm:"type:varchar(30);comment:规则描述" json:"title"`
	HideInMenu int     `gorm:"type:tinyint(3);comment:菜单中隐藏;default:0" json:"hide_in_menu"`
	ListOrder  float64 `gorm:"type:float;comment:排序;default:10000" json:"list_order"`
	Children   []tempAdminMenu
}

type AuthorizeMenu struct {
	Id         int    `json:"id"`
	ParentId   int    `gorm:"type:int(11);comment:所属父类id;default:0" json:"parent_id"`
	UniqueName string `gorm:"type:varchar(30);comment:唯一名称" json:"unique_name"`
	Name       string `gorm:"type:varchar(30);comment:路由名称" json:"name"`
}
