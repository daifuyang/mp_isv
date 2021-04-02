/**
** @创建时间: 2021/1/1 8:24 下午
** @作者　　: return
** @描述　　:
 */
package settings

import (
	"encoding/json"
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
)

type Score struct {
	rc controller.Rest
}

func (rest *Score) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND mid = ?", "score", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}
	var score model.Score
	json.Unmarshal([]byte(op.OptionValue), &score)

	rest.rc.Success(c, "获取成功！", score)

}

// 编辑
func (rest *Score) Edit(c *gin.Context) {

	mid, _ := c.Get("mid")

	var form model.Score
	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	jsonStr, err := json.Marshal(form)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	op := model.Option{}

	result := cmf.NewDb().Where("option_name = ? AND mid = ?", "score", mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	op.Mid = mid.(int)
	op.AutoLoad = 1
	op.OptionName = "score"
	op.OptionValue = string(jsonStr)
	if result.RowsAffected == 0 {
		cmf.NewDb().Create(&op)
	} else {
		cmf.NewDb().Save(&op)
	}

	rest.rc.Success(c, "修改成功！", form)

}
