/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　:
 */
package dishes

import (
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
)

type SpecController struct {
	rc controller.RestController
}

func (rest SpecController) AddKey(c *gin.Context) {

	name := c.PostForm("name")
	if name == "" {
		rest.rc.Error(c, "规格名称不能为空！", nil)
		return
	}

	attrKey := model.FoodAttrKey{
		Name: name,
	}

	result := cmf.NewDb().Where("name = ?", name).First(&attrKey)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	if result.RowsAffected == 0 {
		cmf.NewDb().Create(&attrKey)
	}

	rest.rc.Success(c, "添加成功！", attrKey)
}

func (rest SpecController) AddValue(c *gin.Context) {

	attrId := c.PostForm("attr_id")
	if attrId == "" {
		rest.rc.Error(c, "规格名称不能为空！", nil)
		return
	}
	attrIdInt, err := strconv.Atoi(attrId)
	if err != nil {
		rest.rc.Error(c, "规格名称参数非法！", nil)
		return
	}
	attrVal := c.PostForm("attr_value")

	attrValue := model.FoodAttrValue{
		AttrId:    attrIdInt,
		AttrValue: attrVal,
	}

	attrValue, err = attrValue.AddAttrValue()

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "添加成功！", attrValue)
}
