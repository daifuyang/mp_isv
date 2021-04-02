/**
** @创建时间: 2020/12/6 3:17 下午
** @作者　　: return
** @描述　　:
 */
package app

import (
	"gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"regexp"
	"strconv"
	"time"
)

type User struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新用户信息
 * @Date 2020/12/6 19:10:3
 * @Param
 * @return
 **/

func (rest *User) Edit(c *gin.Context) {

	openId, _ := c.Get("open_id")

	userRealName := c.PostForm("user_realname")
	if userRealName == "" {
		rest.rc.Error(c, "用户真实名称不存在！", nil)
		return
	}

	gender := c.PostForm("gender")
	if gender == "" {
		rest.rc.Error(c, "性别不能为空！", nil)
		return
	}

	genderInt, err := strconv.Atoi(gender)
	if err != nil {
		rest.rc.Error(c, "性别参数非法！", nil)
		return
	}

	if genderInt == 1 {
		genderInt = 1
	} else {
		genderInt = 0
	}

	mobile := c.PostForm("mobile")
	if mobile == "" {
		rest.rc.Error(c, "手机号不能为空！", nil)
		return
	}

	reg := `0?(13|14|15|17|18|19)[0-9]{9}`
	rgx := regexp.MustCompile(reg)
	if !rgx.MatchString(mobile) {
		rest.rc.Error(c, "手机号格式不正确！", nil)
		return
	}

	birthDay := c.PostForm("birthday")

	if birthDay == "" {
		rest.rc.Error(c, "生日不能为空！", nil)
		return
	}

	tmp, err := time.ParseInLocation("2006-01-02", birthDay, time.Local)

	if err != nil {
		rest.rc.Error(c, "生日参数非法！", nil)
		return
	}

	u := model.User{
		UserRealName: userRealName,
		Gender:       genderInt,
		Mobile:       mobile,
		Birthday:     tmp.Unix(),
	}

	mpUserId, _ := c.Get("mp_user_id")

	if mpUserId.(int) == 0 {
		cmf.NewDb().Create(&u)
		// 更新第三方关系
		cmf.NewDb().Where("open_id", openId).Update("user_id", u.Id)
	} else {
		u.Id = mpUserId.(int)
		cmf.NewDb().Save(&u)
	}

	rest.rc.Success(c, "更新成功！", nil)

}
