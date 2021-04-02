/**
** @创建时间: 2021/3/31 5:46 下午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"gincmf/plugins/alipayPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
)

type ContactButton struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取支付宝云客服配置
 * @Date 2021/3/31 17:47:40
 * @Param
 * @return
 **/
func (rest *ContactButton) Get(c *gin.Context) {
	mid,_ := c.Get("mid")
	cb := model.ContactButton{}
	data,err :=  cb.Show(mid.(int))

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}
	
	rest.rc.Success(c,"获取成功！",data)
}

func (rest *ContactButton) Edit(c *gin.Context) {

	mid,_ := c.Get("mid")
	
	var cb model.ContactButton
	if err := c.ShouldBindJSON(&cb); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	data,err :=cb.Edit(mid.(int))

	if err != nil {
		rest.rc.Error(c,err.Error(),nil)
		return
	}

	rest.rc.Success(c,"修改成功！",data)

	
}
