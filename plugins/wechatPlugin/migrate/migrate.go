/**
** @创建时间: 2020/10/29 4:51 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import "gincmf/plugins/wechatPlugin/model"

type Migrate struct{}

func (migrate *Migrate) AutoMigrate() {
	new(model.Applyment).AutoMigrate()
}
