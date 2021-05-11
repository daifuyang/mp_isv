/**
** @创建时间: 2021/4/11 7:25 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import cmf "github.com/gincmf/cmf/bootstrap"

type QrcodePost struct {
	Id         int    `json:"id"`
	Mid        int    `gorm:"type:bigint(20);comment:小程序加密编号;not null" json:"mid"`
	StoreId    int    `gorm:"type:bigint(20);comment:门店id;not null" json:"store_id"`
	QrcodeCode string `gorm:"type:varchar(100);comment:二维码码值;not null" json:"qrcode_code"`
	Name       string `gorm:"type:varchar(40);comment:二维码名称;not null" json:"name"`
	DeskId     int    `gorm:"type:bigint(20);comment:绑定桌号" json:"desk_id"`
	FilePath   string `gorm:"type:varchar(100);comment:文件路径;not null" json:"file_path"`
	CreateAt   int64  `gorm:"type:bigint(20);not null" json:"create_at"`
	UpdateAt   int64  `gorm:"type:bigint(20);not null" json:"update_at"`
	DeleteAt   int64  `gorm:"type:bigint(20);not null" json:"delete_at"`
}

func (migrate *QrcodePost) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&migrate)
}
