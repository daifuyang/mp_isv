/**
** @创建时间: 2021/4/27 1:48 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"testing"
)

// 微信支付类目
func TestWxpayCategory_AutoMigrate(t *testing.T) {

	cmf.Initialize("../../data/conf/config.json")

	new(WxpayCategory).AutoMigrate()

}
