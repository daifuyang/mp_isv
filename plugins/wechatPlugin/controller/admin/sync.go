/**
** @创建时间: 2021/5/5 10:53 上午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"fmt"
	appModel "gincmf/app/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/wechatEasySdk/open"
)

type Sync struct {
	rc controller.Rest
}

// 同步模板
func (rest *Sync) Template(c *gin.Context) {
	ak, exist := c.Get("accessToken")
	if !exist {
		rest.rc.Error(c, "同步失败！ak不存在", nil)
		return
	}
	result, err := new(appModel.WechatIsvApp).Edit(ak.(string))
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	rest.rc.Success(c, "同步成功！", result)
}

// 同步微信审核类目
func (rest *Sync) MiniCategory(c *gin.Context) {

	ak, exist := c.Get("authorizerAccessToken")

	fmt.Println("ak", ak)
	if !exist {
		rest.rc.Error(c, "授权失败！,aak不存在", nil)
		return
	}
	result := new(open.Wxa).GetAllCategories(ak.(string))

	if result.Errcode != 0 {
		rest.rc.Error(c, result.Errmsg, nil)
		return
	}

	var mc []appModel.MiniCategory
	cmf.Db().Find(&mc)

	for _, v := range result.CategoriesList.Categories {

		cate, b := rest.inMiniCategory(v.Name, mc)

		if v.Name == "餐饮服务场所/餐饮服务管理企业" {
			b = true
			cate.Id = 6
		}

		if b {

			// 更新数据库
			cate.WechatCategoryId = v.Id
			cate.WechatCategoryName = v.Name
			cate.WechatParentId = v.Father

			cmf.Db().Where("id = ?", cate.Id).Updates(&cate)
		}
	}

	rest.rc.Success(c, "同步成功！", result)
}

func (rest *Sync) inMiniCategory(name string, mc []appModel.MiniCategory) (cate appModel.MiniCategory, bool bool) {

	for _, v := range mc {
		if name == v.CategoryName {
			return v, true
		}
	}

	return cate, false

}
