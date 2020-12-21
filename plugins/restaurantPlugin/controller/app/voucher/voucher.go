/**
** @创建时间: 2020/12/11 5:07 下午
** @作者　　: return
** @描述　　: 根据优惠券id获取
 */
package voucher

import (
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type Voucher struct {
	rc controller.RestController
}


// @Summary 优惠券列表
// @Description 获取个人优惠券列表
// @Tags app 优惠券列表
// @Accept mpfd
// @Produce mpfd
// @Success 200 {object} model.Paginate{data=[]model.Desk} "code:1 => 获取成功，code:0 => 获取失败"
// @Failure 400 {object} model.ReturnData "{"code":400,"msg":"登录状态已失效！"}"
// @Router /app/voucher [get]
func (rest *Voucher) Get(c *gin.Context) {

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	data,err := new(model.VoucherPost).Index(c,[]string{"user_id = ? AND status = ?"},[]interface{}{userId,1})
	if err != nil {
		rest.rc.Error(c,"获取失败！",nil)
		return
	}

	rest.rc.Success(c,"获取成功！",data)

}
