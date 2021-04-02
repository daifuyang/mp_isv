/**
** @创建时间: 2020/7/18 7:07 下午
** @作者　　: return
 */
package tenant

import (
	"fmt"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
)

type Menu struct {
	rc controller.Rest
}

func (rest *Menu) Get(c *gin.Context) {

	var adminMenu []saasModel.AdminMenu
	result := cmf.NewDb().Where("path <> ?", "").Order("list_order,id").Find(&adminMenu)

	if result.RowsAffected == 0 {
		rest.rc.Error(c, "暂无菜单,请联系管理员添加！", nil)
		return
	}

	authAccessRule := saasModel.GetAuthAccess(c)
	fmt.Println("authAccessRule",authAccessRule)

	// 获取当前用户类型

	var showMenu []saasModel.AdminMenu
	for _, v := range adminMenu {
		if rest.inMap(v.UniqueName, authAccessRule) {
			showMenu = append(showMenu, v)
		}
	}

	if len(authAccessRule) == 0 {
		showMenu = adminMenu
	}

	results := rest.recursionMenu(c, showMenu, 0)
	controller.Rest{}.Success(c, "获取成功！", results)

}

type resultStruct struct {
	Name       string        `gorm:"type:varchar(30);comment:'路由名称'" json:"name"`
	Path       string        `gorm:"type:varchar(100);comment:'路由路径'" json:"path"`
	Icon       string        `gorm:"type:varchar(30);comment:'图标名称'" json:"icon"`
	HideInMenu int           `gorm:"type:tinyint(3);comment:'菜单中隐藏';default:0" json:"hideInMenu"`
	ListOrder  float64       `gorm:"type:float;comment:'排序';default:10000" json:"list_order"`
	Routes     []interface{} `json:"routes"`
}

func (rest *Menu) inMap(s string, target []saasModel.AuthAccessRule) (result bool) {
	for _, v := range target {
		if s == v.Name {
			return true
		}
	}
	return false
}

func (rest *Menu) recursionMenu(c *gin.Context, menus []saasModel.AdminMenu, parentId int) []resultStruct {

	var results []resultStruct
	for _, v := range menus {
		if parentId == v.ParentId {
			result := resultStruct{
				Name:       v.Name,
				Path:       v.Path,
				Icon:       v.Icon,
				HideInMenu: v.HideInMenu,
				ListOrder:  v.ListOrder,
			}
			routes := rest.recursionMenu(c, menus, v.Id)
			childRoutes := make([]interface{}, len(routes))
			for i, v := range routes {
				childRoutes[i] = v
			}
			result.Routes = childRoutes
			results = append(results, result)
		}
	}
	return results
}
