/**
** @创建时间: 2021/4/12 11:05 上午
** @作者　　: return
** @描述　　: 点餐码管理
 */
package qrocde

import (
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"time"
)

// 点餐码管理
type Qrcode struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取绑定的点餐码
 * @Date 2021/4/12 11:6:1
 * @Param
 * @return
 **/
func (rest *Qrcode) Get(c *gin.Context) {

	// 获取mid
	mid, _ := c.Get("mid")

	// 获取store_id
	storeId := c.Query("store_id")

	s := model.Store{}
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, storeId).First(&s)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp := model.QrcodePost{}
	data, err := qp.Index(c, []string{"mid = ? AND  store_id = ? AND delete_at = 0"}, []interface{}{mid, storeId})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 显示单个点餐码
 * @Date 2021/4/12 11:6:16
 * @Param
 * @return
 **/

func (rest *Qrcode) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 获取mid
	mid, _ := c.Get("mid")

	// 获取store_id
	storeId := c.Query("store_id")

	s := model.Store{}
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, storeId).First(&s)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp := model.QrcodePost{}

	tx = cmf.NewDb().Where("id = ? AND mid = ? AND  store_id = ? AND  delete_at = 0", rewrite.Id, mid, storeId).First(&qp)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp.FilePathPrev = util.GetFileUrl(qp.FilePath)

	rest.rc.Success(c, "获取成功！", qp)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 修改单个点餐码
 * @Date 2021/4/12 11:6:36
 * @Param
 * @return
 **/

func (rest *Qrcode) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	name := c.PostForm("name")

	if name == "" {
		rest.rc.Error(c, "名称不能为空！", nil)
		return
	}

	// 获取mid
	mid, _ := c.Get("mid")

	// 获取store_id
	storeId := c.PostForm("store_id")

	s := model.Store{}
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, storeId).First(&s)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp := model.QrcodePost{}

	tx = cmf.NewDb().Where("id = ? AND mid = ? AND  store_id = ? AND  delete_at = 0", rewrite.Id, mid, storeId).First(&qp)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp.Name = name

	tx = cmf.NewDb().Save(&qp)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "修改成功！", qp)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 绑定空点餐码
 * @Date 2021/4/12 11:6:36
 * @Param
 * @return
 **/

func (rest *Qrcode) Store(c *gin.Context) {

	tenantId, _ := c.Get("tenant_id")
	tenantInt := tenantId.(int)

	appId, _ := c.Get("app_id")
	aliAppId := appId.(string)

	// 获取mid
	mid, _ := c.Get("mid")
	midInt := mid.(int)

	// 获取store_id
	storeId := c.PostForm("store_id")

	s := model.Store{}
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, storeId).First(&s)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	// 获取绑定桌号
	deskId := c.PostForm("desk_id")
	desk := model.Desk{}

	deskName := "桌号"
	if desk.Id > 0 {
		tx = cmf.NewDb().Debug().Where("mid = ? AND id = ?", mid, deskId).First(&desk)
		if tx.Error != nil {
			if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				rest.rc.Error(c, "该桌号不存在！", nil)
				return
			}
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}
		deskName = desk.Name
	}

	// 获取code
	// 获取二维码是否存在并且未被绑定
	code := c.PostForm("code")
	if code == "" {
		rest.rc.Error(c, "二维码编号不能为空！", nil)
		return
	}

	qrcode := appModel.Qrcode{}
	tx = cmf.Db().Where("code = ? and status = 0", code).First(&qrcode)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该二维码不存在或已绑定！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	vals := url.Values{}
	vals.Add("scene", "eatin")
	vals.Add("store_number", strconv.Itoa(s.StoreNumber))
	if desk.Id > 0 {
		vals.Add("desk_number", strconv.Itoa(desk.DeskNumber))
	}

	query := vals.Encode()
	fmt.Println("query", query)

	// 存入绑定关系
	qrcode.Mid = midInt
	qrcode.TenantId = tenantInt
	qrcode.UpdateAt = time.Now().Unix()
	qrcode.Page = "pages/store/index"
	qrcode.Query = query
	qrcode.AliAppId = aliAppId
	qrcode.Status = 1

	qp := model.QrcodePost{}

	tx = cmf.NewDb().Where("qrcode_code = ?", qrcode.Code).First(&qp)
	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp = model.QrcodePost{
		Id:         qp.Id,
		Mid:        midInt,
		StoreId:    s.Id,
		QrcodeCode: qrcode.Code,
		Name:       deskName,
		DeskId:     desk.Id,
		FilePath:   qrcode.FilePath,
		CreateAt:   time.Now().Unix(),
		DeleteAt:   0,
	}

	if tx.RowsAffected == 0 {
		cmf.NewDb().Create(&qp)
	} else {
		cmf.NewDb().Debug().Save(&qp)
	}

	tx = cmf.Db().Save(&qrcode)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "绑定成功！", nil)

}

func (rest *Qrcode) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	// 获取mid
	mid, _ := c.Get("mid")

	// 获取store_id
	storeId := c.Query("store_id")

	s := model.Store{}
	if storeId == "" {
		rest.rc.Error(c, "门店id不能为空！", nil)
		return
	}

	tx := cmf.NewDb().Where("mid = ? AND id = ?", mid, storeId).First(&s)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该门店不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp := model.QrcodePost{}

	tx = cmf.NewDb().Where("id = ? AND mid = ? AND  store_id = ? AND  delete_at = 0", rewrite.Id, mid, storeId).First(&qp)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qp.DeleteAt = time.Now().Unix()

	tx = cmf.NewDb().Save(&qp)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qr := appModel.Qrcode{}
	tx = cmf.Db().Where("code = ?", qp.QrcodeCode).First(&qr)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	qr.Status = 0
	tx = cmf.Db().Save(&qr)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "绑定成功！", nil)

}
