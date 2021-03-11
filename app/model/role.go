/**
** @创建时间: 2020/7/18 10:53 上午
** @作者　　: return
 */
package model

import (
	"errors"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
)

type Role struct {
	Id        int     `json:"id"`
	ParentId  int     `gorm:"type:int(11);comment:所属父类id;default:0" json:"parent_id"`
	Name      string  `gorm:"type:varchar(30);comment:名称" json:"name"`
	Remark    string  `gorm:"type:varchar(255);comment:备注" json:"remark"`
	ListOrder float64 `gorm:"type:float;comment:排序;default:10000" json:"list_order"`
	CreateAt  int64   `gorm:"type:bigint(20)" json:"create_at"`
	UpdateAt  int64   `gorm:"type:bigint(20)" json:"update_at"`
	Status    int     `gorm:"type:tinyint(3);comment:状态;default:1" json:"status"`
	paginate  cmfModel.Paginate
}

type RoleUser struct {
	Id     int `json:"id"`
	RoleId int `gorm:"type:int(11);comment:角色id;not null" json:"role_id"`
	UserId int `gorm:"type:int(11);comment:所属用户id;not null" json:"user_id"`
}

func (model *Role) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var role []Role
	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

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
