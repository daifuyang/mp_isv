/**
** @创建时间: 2021/3/19 12:56 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	appModel "gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
)

type Notice struct{}

func (model *Notice) Index(c *gin.Context) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	var total int64 = 0

	var noticeMap []appModel.AdminNotice
	tx := cmf.NewDb().Order("id desc").Find(&noticeMap).Count(&total)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	tx = cmf.NewDb().Order("id desc").Limit(pageSize).Offset((current - 1) * pageSize).Find(&noticeMap)
	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: noticeMap, Current: current, PageSize: pageSize, Total: total}
	if len(noticeMap) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil

}
