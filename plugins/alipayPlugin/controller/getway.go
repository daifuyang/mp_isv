/**
** @创建时间: 2020/12/30 9:48 下午
** @作者　　: return
** @描述　　:
 */
package controller

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strings"
)

type GetWay struct {
	rc controller.RestController
}

func (rest *GetWay) GetWay (c *gin.Context) {

	req := c.Request
	req.ParseForm()
	// 获取订单id
	param := req.Form

	getParams := ""
	for k, v := range param {
		getParams = getParams + k + "=" + strings.Join(v, "") + "&"
	}

	getParams = getParams[:len(getParams)-1]
	cmfLog.Info(getParams)

	inParam := make(map[string]string, 0)

	for k, v := range param {
		item := strings.Join(v, "")
		if k == "sign" || k == "sign_type" || item == "" {
			continue
		}
		inParam[k] = item
	}

	sign := strings.ReplaceAll(strings.Join(param["sign"], ""), " ", "+")

	encode := easyUtil.SortParam(inParam)

	err := easyUtil.AliVerifySign(encode, sign)

	if err != nil {
		rest.rc.Error(c, "非法访问！", err.Error())
		return
	}

	method := strings.Join(param["msg_method"],"")
	bizContent := strings.Join(param["biz_content"],"")

	reason := strings.Join(param["reason"],"")

	fmt.Println(bizContent)

	switch method {
	case "ant.merchant.expand.shop.save.passed":

		var biz struct{
			ShopId   string `json:"shop_id"`
			ShopName string `json:"shop_name"`
			OrderId  string `json:"order_id"`
			StoreId  string `json:"store_id"`
		}

		_ = json.Unmarshal([]byte(bizContent),&biz)

		store := model.Store{}
		tx := cmf.NewDb().Where("id = ?",biz.StoreId).First(&store)

		if tx.Error != nil && !errors.Is(tx.Error,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,tx.Error.Error(),nil)
			return
		}

		// 更新门店状态
		tx = cmf.NewDb().Where("id = ?",biz.StoreId).Updates(map[string]string{"audit_status":"passed","reason":reason})
		if tx.Error != nil {
			rest.rc.Error(c,tx.Error.Error(),nil)
			return
		}

		// 同意门店审核
	case "ant.merchant.expand.shop.save.rejected":
		// 拒绝

		var biz struct{
			ShopId   string `json:"shop_id"`
			ShopName string `json:"shop_name"`
			OrderId  string `json:"order_id"`
			StoreId  string `json:"store_id"`
		}

		_ = json.Unmarshal([]byte(bizContent),&biz)

		store := model.Store{}
		tx := cmf.NewDb().Where("id = ?",biz.StoreId).First(&store)

		if tx.Error != nil && !errors.Is(tx.Error,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,tx.Error.Error(),nil)
			return
		}

		// 更新门店状态
		tx = cmf.NewDb().Where("id = ?",biz.StoreId).Updates(map[string]string{"audit_status":"passed","reason":reason})
		if tx.Error != nil {
			rest.rc.Error(c,tx.Error.Error(),nil)
			return
		}

	}

	rest.rc.Success(c,"回调成功！",nil)

}