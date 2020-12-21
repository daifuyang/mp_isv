/**
** @创建时间: 2020/12/13 2:00 下午
** @作者　　: return
** @描述　　:
 */
package user

import (
	"encoding/json"
	appModel "gincmf/app/model"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/cmf/controller"
	"time"
)

type User struct {
	rc controller.RestController
}

func (rest *User) Show(c *gin.Context) {

	userId, _ := c.Get("mp_user_id")
	u := model.User{}
	data, err := u.Show([]string{"u.id = ?"}, []interface{}{userId})
	data.StartTime = time.Unix(data.StartAt, 0).Format("2006-01-02 15:04:05")
	if data.EndAt != -1 {
		data.EndTime = time.Unix(data.EndAt, 0).Format("2006-01-02 15:04:05")
	}

	var result struct {
		model.User
		ExpRangeEnd   int `json:"exp_range_end"`
	}

	vipInfo := appModel.Options("vip_info")

	var viMap model.VipInfo
	json.Unmarshal([]byte(vipInfo), &viMap)

	for _,v := range viMap.Level{
		if v.LevelId == data.VipLevel {
			result.ExpRangeEnd =v.ExpRangeEnd
			break
		}
	}

	result.User = data
	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	rest.rc.Success(c, "获取成功！", result)
}
