package model

import (
	"encoding/json"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io/ioutil"
	"strings"
)

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

// 配置菜单结构体
type ruleApi struct {
	Url   string `gorm:"type:varchar(100);comment:规则唯一英文标识,全小写" json:"url"`
	Param string `gorm:"type:varchar(100);comment:额外url参数" json:"param"`
}
type confAdminMenu struct {
	UniqueName string          `gorm:"type:varchar(30);comment:唯一名称" json:"unique_name"`
	Name       string          `gorm:"type:varchar(30);comment:路由名称" json:"name"`
	Icon       string          `gorm:"type:varchar(30);comment:图标名称" json:"icon"`
	Path       string          `gorm:"type:varchar(100);comment:路由路径" json:"path"`
	Title      string          `gorm:"type:varchar(30);comment:规则描述" json:"title"`
	HideInMenu int             `gorm:"type:tinyint(3);comment:菜单中隐藏;default:0" json:"hide_in_menu"`
	ListOrder  float64         `gorm:"type:float;comment:排序;default:10000" json:"list_order"`
	RuleApi    []ruleApi       `gorm:"-" json:"rule_api"`
	Children   []confAdminMenu `json:"children;omitempty"`
}

type AuthorizeMenu struct {
	Id         int    `json:"id"`
	ParentId   int    `gorm:"type:int(11);comment:所属父类id;default:0" json:"parent_id"`
	UniqueName string `gorm:"type:varchar(30);comment:唯一名称" json:"unique_name"`
	Name       string `gorm:"type:varchar(30);comment:路由名称" json:"name"`
}

func AddAdminMenu(pid int, uniName string, name string, path string, hide int) {
	adminMenu := AdminMenu{
		ParentId:   pid,
		UniqueName: uniName,
		Name:       name,
		Path:       path,
		HideInMenu: hide,
	}
	cmf.NewDb().FirstOrCreate(&adminMenu)
}

func GetAdminMenu(query []string, queryArgs []interface{}) AdminMenu {
	adminMenu := AdminMenu{}
	queryStr := strings.Join(query, " AND ")
	cmf.NewDb().Where(queryStr, queryArgs...).First(&adminMenu)
	return adminMenu
}

func EditAdminMenu(id int, pid int, uniName string, name string, path string, hide int) {
	adminMenu := AdminMenu{}
	result := cmf.NewDb().Where("id = ?", id).First(&adminMenu)
	if result.RowsAffected > 0 {
		adminMenu.ParentId = pid
		adminMenu.UniqueName = uniName
		adminMenu.Name = name
		adminMenu.Path = path
		adminMenu.HideInMenu = hide
		cmf.NewDb().Save(&adminMenu)
	}
}

// 自动生成菜单和权限控制
func AutoAdminMenu() {
	var adminMenus []confAdminMenu

	bytes, err := ioutil.ReadFile("./data/conf/menu.json")
	if err != nil {
		return
	}

	err = json.Unmarshal(bytes, &adminMenus)
	if err == nil {
		// 增加json中的菜单
		recursionAddMenu(adminMenus, 0)
	}
}

/**
 * @Author return
 * @Description //递归增加菜单
 * @Date 8:09 上午 2020/8/5
 * @Param
 * @return
 **/

func recursionAddMenu(menus []confAdminMenu, parentId int) {

	// 增加当前层级
	for _, v := range menus {

		adminMenu := AdminMenu{
			ParentId:   parentId,
			UniqueName: v.UniqueName,
			Name:       v.Name,
			Icon:       v.Icon,
			Path:       v.Path,
			HideInMenu: v.HideInMenu,
			ListOrder:  v.ListOrder,
		}

		// 保存菜单
		if v.Path != "" {
			result := cmf.NewDb().Create(&adminMenu)
			if result.RowsAffected > 0 {
				if len(v.Children) > 0 {
					recursionAddMenu(v.Children, adminMenu.Id)
				}
			}
		}

		title := v.Title

		if title == "" {
			title = v.Name
		}
		inRule(v.UniqueName, v.Title,v.RuleApi)
	}
}

func inRule(name string, title string, ruleApi []ruleApi)  {

	authRule := AuthRule{
		Name:  name,
		Title: title,
	}

	// 加入到authRule规则表
	tx := cmf.NewDb().Where("name = ?", name).FirstOrCreate(&authRule)
	if tx.Error != nil {
		return
	}

	var rApi = make([]AuthRuleApi,0)

	for _,v := range ruleApi{
		rApi = append(rApi,AuthRuleApi{
			AuthRuleName: authRule.Name,
			Url:v.Url,
			Param: v.Param,
		})
	}

	if len(rApi) > 0 {
		tx = cmf.NewDb().Create(&rApi)
		if tx.Error != nil {
			return
		}
	}

}
