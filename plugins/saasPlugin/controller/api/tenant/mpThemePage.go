/**
** @创建时间: 2020/10/5 8:56 下午
** @作者　　: return
** @描述　　: 小程序单页面
 */
package tenant

import (
	"encoding/json"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
)

type MpThemePage struct {
	rc controller.RestController
}

func (rest *MpThemePage) Get(c *gin.Context) {
	rest.rc.Success(c, "获取成功！", nil)
}

func (rest *MpThemePage) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	id := rewrite.Id

	origId := util.DecodeId(uint64(id))

	fmt.Println("origId", origId)

	mpThemePage := model.MpThemePage{}
	// 获取当前页面的数据
	result := cmf.NewDb().Where("id = ?", origId).First(&mpThemePage)

	if result.RowsAffected == 0 {
		rest.rc.Error(c, "获取失败", result.Error.Error())
		return
	}

	rest.rc.Success(c, "获取成功！", mpThemePage)
}

func (rest *MpThemePage) Edit(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	more := c.PostForm("more")
	wJson := json.Valid([]byte(more))

	if !wJson {
		rest.rc.Error(c, "提交参数错误！", nil)
		return
	}

	id := rewrite.Id
	origId := util.DecodeId(uint64(id))
	mpThemePage := model.MpThemePage{}

	result := cmf.NewDb().Where("id = ?", origId).First(&mpThemePage)
	if result.RowsAffected == 0 {
		rest.rc.Error(c, "该数据不存在！", nil)
		return
	}

	mpThemePage.More = more
	cmf.NewDb().Save(&mpThemePage)

	rest.rc.Success(c, "保存成功！", nil)
}

func (rest *MpThemePage) Store(c *gin.Context) {
	rest.rc.Forbidden(c)
}

func (rest *MpThemePage) Delete(c *gin.Context) {
	rest.rc.Forbidden(c)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据mid和主题file路径获取唯一主题配置信息
 * @Date 2021/1/17 15:59:55
 * @Param
 * @return
 **/

func (rest *MpThemePage) Detail(c *gin.Context) {

	mid, _ := c.Get("mid")

	var form struct {
		File string `json:"file"`
	}

	if err := c.BindJSON(&form); err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if form.File == "" {
		rest.rc.Error(c, "文件路径不能为空！", nil)
		return
	}

	mpThemePage := model.MpThemePage{}
	// 获取当前页面的数据
	tx := cmf.NewDb().Where("mid = ? AND file = ?", mid, form.File).First(&mpThemePage)

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "获取失败", tx.Error.Error())
		return
	}

	var result struct {
		model.MpThemePage
		StyleJson []map[string]interface{} `json:"style_json"`
		MoreJson  []map[string]interface{} `json:"more_json"`
	}

	result.MpThemePage = mpThemePage
	json.Unmarshal([]byte(mpThemePage.Style),&result.StyleJson)
	json.Unmarshal([]byte(mpThemePage.More),&result.MoreJson)

	rest.rc.Success(c, "获取成功！", result)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description // 根据主题获取首页
 * @Date 2021/1/20 22:28:20
 * @Param
 * @return
 **/

func (rest *MpThemePage) Home(c *gin.Context) {
	mid, _ := c.Get("mid")

	mpThemePage := model.MpThemePage{}
	// 获取当前页面的数据
	result := cmf.NewDb().Where("mid = ? AND home = 1", mid).First(&mpThemePage)

	if result.RowsAffected == 0 {
		rest.rc.Error(c, "获取失败", result.Error.Error())
		return
	}

	homeId := util.EncodeId(uint64(mpThemePage.Id))

	var data struct{
		model.MpThemePage
		HomeId int `json:"home_id"`
	}

	data.MpThemePage = mpThemePage
	data.HomeId = homeId

	rest.rc.Success(c, "获取成功！", data)

}
