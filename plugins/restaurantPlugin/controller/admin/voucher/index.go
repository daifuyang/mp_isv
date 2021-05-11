/**
** @创建时间: 2020/12/11 2:03 下午
** @作者　　: return
** @描述　　:
 */
package voucher

import (
	"encoding/json"
	"errors"
	"fmt"
	appModel "gincmf/app/model"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/data"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type Index struct {
	rc controller.Rest
}

func (rest *Index) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"mid = ?"}
	var queryArgs = []interface{}{mid}

	voucherName := c.PostForm("voucher_name")
	if voucherName != "" {
		query = append(query, "v.voucher_name like ?")
		queryArgs = append(queryArgs, "%"+voucherName+"%")
	}

	t := c.PostForm("type")
	if t != "" {
		query = append(query, "v.type = ?")
		queryArgs = append(queryArgs, t)
	}

	publishStartTime := c.PostForm("publish_start_time")
	publishEndTime := c.PostForm("publish_end_time")

	if publishStartTime != "" && publishEndTime != "" {
		startTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", publishStartTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "起始时间非法！", err.Error())
			return
		}

		endTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", publishEndTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "结束时间非法！", err.Error())
		}

		query = append(query, "p.create_at > ? AND p.create_at < ?")
		queryArgs = append(queryArgs, startTimeStamp, endTimeStamp)
	}

	voucher := model.Voucher{}
	data, err := voucher.Index(c, query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *Index) List(c *gin.Context) {

	mid, _ := c.Get("mid")

	var query = []string{"mid = ? AND status = ?"}
	var queryArgs = []interface{}{mid, 1}

	data, err := new(model.Voucher).List(query, queryArgs)

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Index) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	v := model.Voucher{}
	data, err := v.Show([]string{"id = ? AND  mid = ? AND delete_at = ?"}, []interface{}{rewrite.Id, mid, 0})

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功", data)
}

func (rest *Index) Edit(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	alipayUserId, exist := c.Get("alipay_user_id")

	var form struct {
		StoreIds       []int  `json:"store_ids"`
		SyncToAlipay   int    `json:"sync_to_alipay"`
		PublishEndTime string `json:"publish_end_time"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	publishEndTime := form.PublishEndTime

	if publishEndTime == "" {
		rest.rc.Error(c, "发放结束时间不能为空！", nil)
		return
	}

	businessJson := saasModel.Options("business_info", mid.(int))
	bi := model.BusinessInfo{}
	_ = json.Unmarshal([]byte(businessJson), &bi)
	if bi.BrandName == "" {
		rest.rc.Error(c, "请先完善品牌信息！", nil)
		return
	}
	if bi.BrandLogo == "" {
		rest.rc.Error(c, "请先完善品牌LOGO！", nil)
		return
	}
	if bi.Mobile == "" {
		rest.rc.Error(c, "请先完善客服电话！", nil)
		return
	}

	brandName := bi.BrandName

	voucher := model.Voucher{}

	voucher, err = voucher.Show([]string{"id = ? AND  mid = ? AND delete_at = ?"}, []interface{}{rewrite.Id, mid, 0})

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	timeLayout := "2006-01-02 15:04:05" //转化所需模板
	tmp := voucher.PublishStartTime
	tsUnix := tmp.Unix()

	tmp = voucher.PublishEndTime
	teUnix := tmp.Unix()

	tmp, _ = time.ParseInLocation(timeLayout, publishEndTime, time.Local)
	uTeUnix := tmp.Unix()

	if uTeUnix < teUnix {
		rest.rc.Error(c, "截止时间不能前调！", nil)
		return
	}

	if uTeUnix < tsUnix {
		rest.rc.Error(c, "截止时间不能早于起始时间！", nil)
		return
	}

	if uTeUnix-tsUnix > 90*86400 {
		rest.rc.Error(c, "截止时间不能超过起始时间90天！", nil)
		return
	}

	voucher.PublishEndTime = tmp

	storeIds := form.StoreIds

	var store []model.Store

	var sQuery []string
	var sQueryArgs []interface{}

	var storeArr []string
	var storeIdArr []string

	if len(storeIds) > 0 {
		for _, v := range storeIds {
			sQuery = append(sQuery, "id = ?")
			sQueryArgs = append(sQueryArgs, v)
		}

		sQueryStr := strings.Join(sQuery, " OR ")
		tx := cmf.NewDb().Where(sQueryStr, sQueryArgs...).Find(&store)

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		for _, v := range store {
			number := strconv.Itoa(v.StoreNumber)
			storeArr = append(storeArr, number)
			storeIdArr = append(storeIdArr, strconv.Itoa(v.Id))
		}

	}

	// 新建优惠券
	if voucher.TemplateId == "" && form.SyncToAlipay == 1 {

		if !exist {
			rest.rc.Error(c, "请先绑定支付宝！", nil)
			return
		}

		if voucher.Type == 0 {

			ruleConf := marketing.RuleConf{
				Pid: alipayUserId.(string),
			}

			if len(storeArr) > 0 {
				ruleConf.Store = strings.Join(storeArr, ",")
			}

			bizContent := map[string]interface{}{
				"voucher_type":           voucher.VoucherType,
				"brand_name":             brandName,
				"publish_start_time":     voucher.PublishStartTime,
				"publish_end_time":       form.PublishEndTime,
				"voucher_valid_period":   voucher.VoucherValidPeriod,
				"voucher_available_time": voucher.VoucherAvailableTime,
				"out_biz_no":             time.Now().Unix(),
				"voucher_description":    voucher.VoucherDescription,
				"voucher_quantity":       voucher.VoucherQuantity,
				"amount":                 voucher.Amount,
				"floor_amount":           voucher.FloorAmount,
				"rule_conf":              ruleConf,
			}

			templateId, err := rest.SyncToAlipay(bizContent, voucher.TotalAmount)
			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
			voucher.TemplateId = templateId
			voucher.SyncToAlipay = 1

		}

	}

	if voucher.SyncToAlipay == 1 {

		if !exist {
			rest.rc.Error(c, "请先绑定支付宝！", nil)
			return
		}

		ruleConf := marketing.RuleConf{
			Pid: alipayUserId.(string),
		}

		if len(storeArr) > 0 {
			ruleConf.Store = strings.Join(storeArr, ",")
		}

		bizContent := map[string]interface{}{
			"template_id":      voucher.TemplateId,
			"out_biz_no":       time.Now().Unix(),
			"publish_end_time": publishEndTime,
			"rule_conf":        ruleConf,
		}

		result := new(marketing.CashlessVoucher).ModifyTemplate(bizContent, "")

		if result.Response.Code != "10000" {
			rest.rc.Error(c, "更新失败！"+result.Response.SubMsg, result)
			return
		}
	}

	tx := cmf.NewDb().Save(&voucher)
	if tx.Error != nil {
		rest.rc.Error(c, "更新失败！"+tx.Error.Error(), nil)
		return
	}

	// 保存门店关系
	v := model.VoucherStorePost{VoucherId: voucher.Id}
	err = v.Store(storeIdArr)

	if err != nil {
		cmfLog.Error(err.Error())
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "更新成功！", voucher)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 新增优惠券
 * @Date 2020/12/11 14:6:20
 * @Param
 * @return
 **/
func (rest *Index) Store(c *gin.Context) {

	alipayUserId, exist := c.Get("alipay_user_id")

	fmt.Println("alipayUserId", alipayUserId)

	var form struct {
		StoreIds             []int                            `json:"store_ids"`
		VoucherName          string                           `json:"voucher_name"`
		Type                 int                              `json:"type"`
		SyncToAlipay         int                              `json:"sync_to_alipay"`
		VoucherType          string                           `json:"voucher_type"`
		PublishStartTime     string                           `json:"publish_start_time"`
		PublishEndTime       string                           `json:"publish_end_time"`
		VoucherValidPeriod   *marketing.VoucherValidPeriod    `json:"voucher_valid_period"`
		VoucherAvailableTime []marketing.VoucherAvailableTime `json:"voucher_available_time"`
		VoucherDescription   []string                         `json:"voucher_description"`
		VoucherQuantity      int                              `json:"voucher_quantity"`
		Amount               float64                          `json:"amount"`
		TotalAmount          float64                          `json:"total_amount"`
		FloorAmount          float64                          `json:"floor_amount"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	if form.VoucherName == "" {
		rest.rc.Error(c, "优惠券名称为必填！", nil)
		return
	}

	if form.Type > 1 {
		rest.rc.Error(c, "优惠券类型非法！", nil)
		return
	}

	if form.VoucherType == "" {
		rest.rc.Error(c, "优惠券类型不能为空！", nil)
		return
	}

	if form.PublishStartTime == "" {
		rest.rc.Error(c, "发放开始时间不能为空！", nil)
		return
	}

	if form.PublishEndTime == "" {
		rest.rc.Error(c, "发放结束时间不能为空！", nil)
		return
	}

	if form.VoucherValidPeriod == nil {
		rest.rc.Error(c, "券有效期不能为空！", nil)
		return
	}

	var voucherValidPeriod = form.VoucherValidPeriod

	if form.Amount > 1000 {
		rest.rc.Error(c, "抵扣的金额不能大于1000！", nil)
		return
	}

	storeIds := form.StoreIds

	var store []model.Store

	var subQuery []string
	var subQueryArgs []interface{}
	if len(storeIds) > 0 {
		for _, v := range storeIds {
			subQuery = append(subQuery, "id = ?")
			subQueryArgs = append(subQueryArgs, v)
		}

		var subQueryStr string
		if len(subQuery) > 0 {
			subQueryStr = strings.Join(subQuery, " OR ")
		}

		var sQuery = []string{"mid = ?", "delete_at = 0"}
		var sQueryArgs = []interface{}{mid, 0}

		if subQueryStr != "" {
			sQuery = append(sQuery, "("+subQueryStr+")")
		}

		sQueryStr := strings.Join(sQuery, " AND ")

		tx := cmf.NewDb().Where(sQueryStr, sQueryArgs...).Find(&store)

		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

	}

	var storeArr []string
	var storeIdArr []string
	for _, v := range store {
		number := strconv.Itoa(v.StoreNumber)
		storeArr = append(storeArr, number)
		storeIdArr = append(storeIdArr, strconv.Itoa(v.Id))
	}

	syncToAlipay := 0
	if form.SyncToAlipay == 1 {
		syncToAlipay = form.SyncToAlipay
	}

	businessJson := saasModel.Options("business_info", mid.(int))
	bi := model.BusinessInfo{}
	_ = json.Unmarshal([]byte(businessJson), &bi)
	if bi.BrandName == "" || bi.BrandLogo == "" || bi.Mobile == "" {
		rest.rc.Error(c, "请先完善基本信息！", nil)
		return
	}

	brandName := bi.BrandName

	voucherValidPeriodJson, _ := json.Marshal(voucherValidPeriod)
	vatJson, _ := json.Marshal(form.VoucherAvailableTime)
	descJson, _ := json.Marshal(form.VoucherDescription)

	publishStartTime, _ := time.ParseInLocation(data.TimeLayout, form.PublishStartTime, time.Local)
	publishEndTime ,_ := time.ParseInLocation(data.TimeLayout, form.PublishEndTime, time.Local)

	voucher := model.Voucher{
		Mid:                  mid.(int),
		VoucherName:          form.VoucherName,
		Type:                 form.Type,
		VoucherType:          form.VoucherType,
		PublishStartTime:     publishStartTime,
		PublishEndTime:       publishEndTime,
		VoucherValidPeriod:   string(voucherValidPeriodJson),
		VoucherAvailableTime: string(vatJson),
		VoucherDescription:   string(descJson),
		VoucherQuantity:      form.VoucherQuantity,
		Amount:               form.Amount,
		TotalAmount:          form.TotalAmount,
		FloorAmount:          form.FloorAmount,
		CreateAt:             time.Now().Unix(),
		UpdateAt:             time.Now().Unix(),
		SyncToAlipay:         syncToAlipay,
	}
	// 同步到支付宝
	if syncToAlipay == 1 && exist {

		if form.Type == 0 {

			ruleConf := marketing.RuleConf{
				Pid: alipayUserId.(string),
			}

			if len(storeArr) > 0 {
				ruleConf.Store = strings.Join(storeArr, ",")
			}

			bizContent := map[string]interface{}{
				"voucher_type":           form.VoucherType,
				"brand_name":             brandName,
				"publish_start_time":     form.PublishStartTime,
				"publish_end_time":       form.PublishEndTime,
				"voucher_valid_period":   voucherValidPeriod,
				"voucher_available_time": form.VoucherAvailableTime,
				"out_biz_no":             time.Now().Unix(),
				"voucher_description":    form.VoucherDescription,
				"voucher_quantity":       form.VoucherQuantity,
				"amount":                 form.Amount,
				"floor_amount":           form.FloorAmount,
				"rule_conf":              ruleConf,
			}

			templateId, err := rest.SyncToAlipay(bizContent, form.TotalAmount)
			if err != nil {
				rest.rc.Error(c, err.Error(), nil)
				return
			}
			voucher.TemplateId = templateId
		}

	}

	// 创建入库
	result := cmf.NewDb().Create(&voucher)
	if result.Error != nil {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	// 保存门店关系
	v := model.VoucherStorePost{VoucherId: voucher.Id}
	err = v.Store(storeIdArr)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "创建成功！", nil)

}

func (rest *Index) SyncToAlipay(bizContent map[string]interface{}, totalAmount float64) (string, error) {

	host := cmf.Conf().App.Domain

	if cmf.Conf().App.AppDebug {
		host = "https://www.codecloud.ltd"
	}

	notify := host + "/api/v1/app/alipay/voucher_receive_notify"

	var result marketing.VoucherCreateResult

	if bizContent["voucher_type"] == "CASHLESS_RANDOM_VOUCHER" {
		if totalAmount > 10000000 || totalAmount < 1 {
			return "", errors.New("券总金额参数非法！")
		}
		bizContent["total_amount"] = totalAmount
	}

	result = new(marketing.CashlessVoucher).CreateTemplate(bizContent, "", notify)

	if result.Response.Code == "10000" {
		// 创建成功
		return result.Response.TemplateId, nil
	} else {
		// 创建失败
		return "", errors.New("创建失败！" + result.Response.SubMsg)
	}
}

func (rest *Index) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	v := model.Voucher{}
	tx := cmf.NewDb().Where("id = ? AND mid = ?", rewrite.Id, mid).First(&v)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	if v.Status != 2 {
		rest.rc.Success(c, "未过期的优惠券无法删除！", nil)
		return
	}

	v.DeleteAt = time.Now().Unix()

	tx = cmf.NewDb().Where("id = ? AND mid = ?", rewrite.Id, mid).Updates(&v)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "删除成功！", nil)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 给用户发券
 * @Date 2020/12/17 22:12:13
 * @Param
 * @return
 **/

func (rest *Index) Send(c *gin.Context) {

	var form struct {
		UserId    int `json:"user_id"`
		VoucherId int `json:"voucher_id"`
	}

	err := c.ShouldBindJSON(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")

	_, exist := c.Get("alipay_user_id")

	if form.UserId == 0 {
		rest.rc.Error(c, "接收人不能为空！", nil)
		return
	}

	if form.VoucherId == 0 {
		rest.rc.Error(c, "优惠券id不能为空！", nil)
		return
	}

	v := model.Voucher{}
	vp := marketing.VoucherValidPeriod{}

	data, err := v.Show([]string{"id = ? AND mid = ? AND status = ?"}, []interface{}{form.VoucherId, mid, 1})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	json.Unmarshal([]byte(data.VoucherValidPeriod), &vp)

	nowUnix := time.Now().Unix()
	var validEndAt int64

	if vp.Type == "ABSOLUTE" {
		tmp, _ := time.ParseInLocation("2006-01-02 15:04:05", vp.End, time.Local)
		validEndAt = tmp.Unix()
	} else {
		unix := 0
		switch vp.Unit {
		case "MINUTE":
			unix = 60 * vp.Duration
		case "HOUR":
			unix = 3600 * vp.Duration
		case "DAY":
			unix = 86400 * vp.Duration
		}

		validEndAt = nowUnix + int64(unix)
	}

	vPost := model.VoucherPost{
		Mid:          mid.(int),
		VoucherId:    data.Id,
		ValidStartAt: nowUnix,
		ValidEndAt:   validEndAt,
		UserId:       form.UserId,
		CreateAt:     nowUnix,
		UpdateAt:     nowUnix,
	}

	if data.SyncToAlipay == 1 {

		if !exist {
			rest.rc.Error(c, "请先绑定支付宝小程序！", nil)
			return
		}

		tp := appModel.UserPart{}
		tpData, err := tp.Show([]string{"u.id = ? AND tp.type = ? AND u.user_status = ?"}, []interface{}{form.UserId, "alipay-mp", 1})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if tpData.Id == 0 {
			rest.rc.Error(c, "该用户已过期！", nil)
			return
		}

		result := new(model.Voucher).Send(data.TemplateId, tpData.OpenId, data.VoucherName)

		if result.Response.Code != "10000" {
			rest.rc.Error(c, "发送失败！"+result.Response.SubMsg, result)
			return
		}

		vPost.AlipayVoucherId = result.Response.VoucherId

	}

	tx := cmf.NewDb().Create(&vPost)

	if tx.Error != nil {
		rest.rc.Error(c, "发送失败！"+tx.Error.Error(), tx.Error)
		return
	}

	rest.rc.Success(c, "发送成功！", nil)

}
