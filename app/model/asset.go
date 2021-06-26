/********************************************
 @Title asset.go
 @Description 资源模型文件
 @Author frank(belief_dfy@163.com)
 @Update 2020 07 10
*********************************************/
package model

import (
	"errors"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"gorm.io/gorm"
	"strings"
)

type Asset struct {
	Id         int    `json:"id"`
	UserId     int    `gorm:"type:int(11);comment:所属用户id;not null" json:"user_id"`
	FileSize   int64  `gorm:"type:int(11);comment:文件大小;not null" json:"file_size"`
	CreateAt   int64  `gorm:"type:bigint(20);comment:上传时间;default:0" json:"create_at"`
	Status     int    `gorm:"type:tinyint(3);comment:文件状态;default:1" json:"status"`
	FileKey    string `gorm:"type:varchar(64);comment:文件唯一码;not null" json:"file_key"`
	RemarkName string `gorm:"type:varchar(100);comment:文件备注名;not null" json:"remark_name"`
	FileName   string `gorm:"type:varchar(100);comment:文件索引名;not null" json:"file_name"`
	FilePath   string `gorm:"type:varchar(100);comment:文件路径;not null" json:"file_path"`
	Suffix     string `gorm:"type:varchar(10);comment:文件后缀;not null" json:"suffix"`
	AssetType  int    `gorm:"column:type;type:tinyint(3);comment:资源类型;not null" json:"asset_type"`
	More       string `gorm:"type:text;comment:更多配置" json:"more"`
	paginate   cmfModel.Paginate
}

type TempAsset struct {
	Asset
	PrevPath string `json:"prev_path"`
}

func (model *Asset) Get(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	var assets []Asset
	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0
	cmf.NewDb().Where(queryStr, queryArgs...).Find(&assets).Count(&total)
	tx := cmf.NewDb().Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).Order("id desc").Find(&assets)

	if tx.Error != nil && errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		return cmfModel.Paginate{}, tx.Error
	}

	var tempAssets []TempAsset

	for _, v := range assets {
		prevPath := util.GetFileUrl(v.FilePath,"clipper")
		tempAssets = append(tempAssets, TempAsset{Asset: v, PrevPath: prevPath})
	}

	paginationData := cmfModel.Paginate{Data: tempAssets, Current: current, PageSize: pageSize, Total: total}
	if len(tempAssets) == 0 {
		paginationData.Data = make([]string, 0)
	}

	return paginationData, nil

}
