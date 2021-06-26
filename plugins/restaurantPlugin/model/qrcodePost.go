/**
** @创建时间: 2021/4/11 7:17 下午
** @作者　　: return
** @描述　　: 点餐码管理
 */
package model

import (
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/data"
	cmfModel "github.com/gincmf/cmf/model"
	"strings"
	"time"
)

type QrcodePost struct {
	Id           int    `json:"id"`
	Mid          int    `gorm:"type:bigint(20);comment:小程序加密编号;not null" json:"mid"`
	StoreId      int    `gorm:"type:bigint(20);comment:门店id;not null" json:"store_id"`
	QrcodeCode   string `gorm:"type:bigint(20);comment:绑定主二维码编码;not null" json:"qrcode_code"`
	Name         string `gorm:"type:varchar(40);comment:二维码名称;not null" json:"name"`
	DeskId       int    `gorm:"type:bigint(20);comment:绑定桌号" json:"desk_id"`
	FilePath     string `gorm:"type:varchar(100);comment:文件路径;not null" json:"file_path"`
	FilePathPrev string `gorm:"->" json:"file_path_prev"`
	CreateAt     int64  `gorm:"type:bigint(20);not null" json:"create_at"`
	CreateTime   string `gorm:"-" json:"create_time"`
	UpdateAt     int64  `gorm:"type:bigint(20);not null" json:"update_at"`
	UpdateTime   string `gorm:"-" json:"update_time"`
	DeleteAt     int64  `gorm:"type:bigint(20);not null" json:"delete_at"`
	DeleteTime   string `gorm:"-" json:"delete_time"`
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取二维码列表（分页）
 * @Date 2021/4/12 16:0:12
 * @Param
 * @return
 **/
func (model *QrcodePost) Index(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {
	// 获取默认的系统分页
	current, pageSize, err := new(cmfModel.Paginate).Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	var qp []QrcodePost
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&qp).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&qp)

	for k, v := range qp {
		qp[k].FilePathPrev = util.GetFileUrl(v.FilePath, "clipper")
		qp[k].CreateTime = time.Unix(v.CreateAt, 0).Format(data.TimeLayout)
		qp[k].UpdateTime = time.Unix(v.UpdateAt, 0).Format(data.TimeLayout)
	}

	if tx.Error != nil {
		return cmfModel.Paginate{}, tx.Error
	}

	paginate := cmfModel.Paginate{Data: qp, Current: current, PageSize: pageSize, Total: total}
	if len(qp) == 0 {
		paginate.Data = make([]Printer, 0)
	}

	return paginate, nil
}
