/**
** @创建时间: 2020/10/4 1:57 下午
** @作者　　: return
** @描述　　: 租户创建的主题类型
 */
package model

type MpTheme struct {
	Id        int     `json:"-"`
	Number    int     `gorm:"type:int(11);comment:小程序编号;not null" json:"number"`
	Category  int     `gorm:"type:tinyint(3);comment:小程序类型分类;not null;default:0" json:"category"`
	Name      string  `gorm:"type:varchar(40);comment:小程序主题名称;not null" json:"name"`
	Version   string  `gorm:"type:varchar(10);comment:小程序版本;not null" json:"version"`
	Thumbnail string  `gorm:"type:varchar(255);comment:小程序缩略图;not null" json:"thumbnail"`
	ThemeId   int     `gorm:"type:int(11);comment:小程序原主题id;not null" json:"theme_id"`
	TenantId  int     `gorm:"type:int(11);comment:小程序所属租户id;not null" json:"-"`
	CreateAt  int64   `gorm:"type:int(10);comment:'创建时间';default:0" json:"create_at"`
	UpdateAt  int64   `gorm:"type:int(10);comment:'更新时间';default:0" json:"update_at"`
	ListOrder float64 `gorm:"type:float;comment:'排序';default:10000" json:"list_order"`
	DeleteAt  int64   `gorm:"type:int(10);comment:'删除时间';default:0" json:"delete_at"`
}

type MpThemePage struct {
	Id          int `json:"id"`
	ThemeId     int `gorm:"type:int(11)" json:"theme_id"`
	Home        int `gorm:"type:tinyint(3);comment:'是否为首页';not null;default:0" json:"home"`
	Title       string `gorm:"type:varchar(20);comment:'页面名称';not null" json:"title"`
	Style       string `gorm:"type:text;comment:'主题文件用户公共样式'" json:"style"`
	ConfigStyle string `gorm:"type:text;comment:'主题文件默认公共样式'" json:"global_style"`
	More        string `gorm:"type:text;comment:'主题文件用户配置文件'" json:"more"`
	ConfigMore  string `gorm:"type:text;comment:'主题文件默认配置文件'" json:"config_more"`
	CreateAt    int64  `gorm:"type:int(11)" json:"create_at"`
	UpdateAt    int64  `gorm:"type:int(11)" json:"update_at"`
}
