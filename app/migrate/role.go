/**
** @创建时间: 2020/7/18 10:56 上午
** @作者　　: return
 */
package migrate

import (
	"gincmf/app/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"time"
)

type role struct {
	Migrate
}

func (_ *role) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&model.Role{})

	role := []model.Role{
		model.Role{
			Name:      "超级管理员",
			Remark:    "拥有网站最高管理员权限！",
			ListOrder: 0,
			CreateAt:  time.Now().Unix(),
			UpdateAt:  time.Now().Unix(),
		},
		model.Role{
			Name:      "收银员",
			Remark:    "收银员！",
			ListOrder: 1,
			CreateAt:  time.Now().Unix(),
			UpdateAt:  time.Now().Unix(),
		},
		model.Role{
			Name:      "财务",
			Remark:    "财务！",
			ListOrder: 2,
			CreateAt:  time.Now().Unix(),
			UpdateAt:  time.Now().Unix(),
		},
	}

	// 添加角色权限
	for _, v := range role {
		cmf.NewDb().Where(model.Role{Name: v.Name}).FirstOrCreate(&v)
	}

	// 添加role_user关系表
	cmf.NewDb().AutoMigrate(&model.RoleUser{})

}
