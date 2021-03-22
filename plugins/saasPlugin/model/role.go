/**
** @创建时间: 2021/3/19 8:34 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
	"time"
)

type Role struct {
	Mid int `gorm:"type:int(11);comment:小程序加密编号;not null" json:"mid"`
	model.Role
}

func (m *Role) Init(mid int) {

	role := []Role{
		{
			Mid: mid,
			Role: model.Role{
				Name:      "超级管理员",
				Remark:    "拥有网站最高管理员权限！",
				ListOrder: 0,
				CreateAt:  time.Now().Unix(),
				UpdateAt:  time.Now().Unix(),
			},
		},
		{
			Mid: mid,
			Role: model.Role{
				Name:      "收银员",
				Remark:    "收银员！",
				ListOrder: 1,
				CreateAt:  time.Now().Unix(),
				UpdateAt:  time.Now().Unix(),
			},
		},
		{
			Mid: mid,
			Role: model.Role{
				Name:      "财务",
				Remark:    "财务！",
				ListOrder: 2,
				CreateAt:  time.Now().Unix(),
				UpdateAt:  time.Now().Unix(),
			},
		},
	}

	// 添加角色权限
	for _, v := range role {
		cmf.NewDb().Where("mid = ? AND name = ?", v.Mid, v.Name).FirstOrCreate(&v)
	}

}

func (m *Role) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var role []Role
	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	cmf.NewDb().Where(queryStr, queryArgs...).Find(&role).Count(&total)
	tx := cmf.NewDb().Limit(pageSize).Where(queryStr, queryArgs...).Offset((current - 1) * pageSize).Find(&role)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	paginationData := cmfModel.Paginate{Data: role, Current: current, PageSize: pageSize, Total: total}
	if len(role) == 0 {
		paginationData.Data = make([]string, 0)
	}

	return paginationData, nil

}
