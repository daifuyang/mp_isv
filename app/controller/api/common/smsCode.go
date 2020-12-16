/**
** @创建时间: 2020/9/30 3:57 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"fmt"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"strconv"
)

type SmsCodeController struct {
	rc controller.RestController
}

func (rest *SmsCodeController) Post(c *gin.Context) {
	// 获取验证码
	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	mobileInt, err := strconv.Atoi(mobile)

	if err != nil {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	result, err := util.SmsCode(mobileInt)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	// 获取验证码
	fmt.Println("result", result)

	rest.rc.Success(c, "获取成功！", result)
}
