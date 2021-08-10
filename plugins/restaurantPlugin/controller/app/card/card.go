/**
** @创建时间: 2020/12/12 6:46 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"encoding/json"
	"errors"
	appModel "gincmf/app/model"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	"github.com/gincmf/alipayEasySdk/marketing"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/data"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/gincmf/wechatEasySdk"
	"github.com/gincmf/wechatEasySdk/pay"
	wechatUtil "github.com/gincmf/wechatEasySdk/util"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"strings"
	"time"
)

type Card struct {
	rc controller.Rest
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取开卡信息
 * @Date 2020/12/13 10:36:9
 * @Param
 * @return
 **/
func (rest *Card) VipDetail(c *gin.Context) {

	mid, _ := c.Get("mid")

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	u := model.User{
		Db: db,
	}

	userData, err := u.Show([]string{"u.id = ?"}, []interface{}{userId, mid})

	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	// 获取会员卡状态
	card := model.CardTemplate{}
	tx := db.Where("id = ? AND mid = ? AND status = ? AND delete_at = ?", 1, mid, 1, 0).First(&card)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	var result struct {
		Level        string        `json:"level"`
		Name         string        `json:"name"`
		GetType      string        `json:"get_type"` //获得方式 free:免费 pay:付费 storage:储值
		Benefit      model.Benefit `json:"benefit"`
		ValidPeriod  int           `json:"valid_period"` // 会员有效期
		Fee          float64       `json:"fee"`
		ApplyCardUrl string        `json:"apply_card_url"`
		Allow        bool          `json:"allow"`
	}

	result.ValidPeriod = card.ValidPeriod

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "非法请求开卡，用户未开启开卡！", nil)
	}

	// 获取当前配置会员卡开卡信息
	vipInfo, err := saasModel.Options(db, "vip_info", mid.(int))

	var viMap model.VipInfo
	json.Unmarshal([]byte(vipInfo), &viMap)

	// 获取当前用户的信息
	for k, v := range viMap.Level {

		// 用户的经验取值范围
		if userData.Exp < v.ExpRangeEnd || k == len(viMap.Level)-1 {

			// 获取发卡要求
			getType := v.GetType
			result.Benefit = v.Benefit

			switch getType {
			// 消费
			case "pay":
				// 获取当前会员开通状态
				result.GetType = "pay"
			// 储值
			case "storage":
				// 计算当前用户的储值信息是否达标，达标返回allow，不达标返回notAllow
				result.GetType = "storage"
				// 免费
			case "free":
				fallthrough
			default:
				result.GetType = "free"
			}
			result.Level = v.LevelId
			result.Name = v.LevelName
			result.Fee = v.Num

			voucherItem := make([]model.VoucherItem, 0)
			for _, iv := range v.Benefit.Voucher.Once {
				voucher, err := rest.validVoucher(db, iv)
				if err == nil {
					voucherItem = append(voucherItem, voucher)
				}
			}
			v.Benefit.Voucher.Once = voucherItem

			voucherItem = make([]model.VoucherItem, 0)
			for _, iv := range v.Benefit.Voucher.Month {

				voucher, err := rest.validVoucher(db, iv)
				if err == nil {
					voucherItem = append(voucherItem, voucher)
				}

			}

			v.Benefit.Voucher.Month = voucherItem
			result.Benefit = v.Benefit
			break
		}
	}

	rest.rc.Success(c, "获取成功！", result)

}

func (rest *Card) validVoucher(db *gorm.DB, VoucherItem model.VoucherItem) (model.VoucherItem, error) {

	prefix := cmf.Conf().Database.Prefix

	var voucher struct {
		VoucherName        string `json:"voucher_name"`
		VoucherDescription string `json:"voucher_description"`
		VoucherId          int    `json:"voucher_id"`
		TemplateId         string `json:"template_id"`
	}

	tx := db.Table(prefix+"voucher_post vp").
		Joins("INNER JOIN "+prefix+"voucher v ON vp.voucher_id = v.id").Where("v.id = ?", VoucherItem.VoucherId).Scan(&voucher)

	if tx.RowsAffected > 0 {

		var voucherDescriptionMap []string
		json.Unmarshal([]byte(voucher.VoucherDescription), &voucherDescriptionMap)

		return model.VoucherItem{
			SendType:              VoucherItem.SendType,
			Count:                 VoucherItem.Count,
			VoucherName:           voucher.VoucherName,
			VoucherDescription:    voucher.VoucherDescription,
			VoucherDescriptionMap: voucherDescriptionMap,
			VoucherId:             voucher.VoucherId,
			TemplateId:            voucher.TemplateId,
		}, nil
	}

	return model.VoucherItem{}, errors.New("暂无内容！")
}

func (rest *Card) getVipLevel(levelId int, level []model.SLevel) (model.SLevel, error) {
	for _, v := range level {
		temLevel, _ := strconv.Atoi(strings.Replace(v.LevelId, "VIP", "", -1))
		if temLevel == levelId {
			return v, nil
		}
	}
	return model.SLevel{}, errors.New("会员等级非法！")
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 开卡投放
 * @Date 2020/12/13 18:29:10
 * @Param
 * @return
 **/
func (rest *Card) Send(c *gin.Context) {

	mpUserId, _ := c.Get("mp_user_id")
	mpType, _ := c.Get("mp_type")
	openid, _ := c.Get("open_id")

	// 获取当前租户信息
	mid, _ := c.Get("mid")
	appId, _ := c.Get("app_id")

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	u := model.User{
		Db: db,
	}

	userData, err := u.Show([]string{"u.id = ?"}, []interface{}{userId})
	if err != nil {
		rest.rc.Error(c, "获取用户信息失败！"+err.Error(), err)
		return
	}

	// 获取会员卡状态
	card := model.CardTemplate{}
	tx := db.Where("id = ? AND mid = ? AND status = ? AND delete_at = ?", 1, mid, 1, 0).First(&card)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	vipInfo, err := saasModel.Options(db, "vip_info", mid.(int))

	var viMap model.VipInfo
	json.Unmarshal([]byte(vipInfo), &viMap)

	// 初始化一级会员
	vipLevel, err := rest.getVipLevel(1, viMap.Level)
	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	initVipLevel := vipLevel.LevelId

	if userData.VipLevel != "" {
		initVipLevel = userData.VipLevel
	}

	// 获取会员信息
	vip := model.MemberCard{
		UserId: userData.Id,
		Db:     db,
	}

	nowUnix := time.Now().Unix()
	vip.StartAt = nowUnix
	vip.CreateAt = nowUnix
	vip.UpdateAt = nowUnix

	levelId, _ := strconv.Atoi(strings.Replace(initVipLevel, "VIP", "", -1))

	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */
	yearStr, monthStr, dayStr := util.CurrentDate()
	insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":member_card:" + yearStr + monthStr + dayStr
	date := yearStr + monthStr + dayStr
	vipNum := util.DateUuid("", insertKey, date, mid.(int))

	// 获取会员会员等级
	memberLevel, err := rest.getVipLevel(levelId, viMap.Level)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	getType := memberLevel.GetType
	fee := memberLevel.Num

	// 新建会员卡
	switch getType {
	case "pay":

		co := model.MemberCardOrder{}
		// 返回付费订单号
		if fee <= 0 {
			rest.rc.Error(c, "商家会员卡配置出错！", nil)
			return
		}

		var payType = ""
		if mpType == "alipay" {
			payType = "alipay"
		} else if mpType == "wechat" {
			payType = "wxpay"
		} else {
			payType = ""
		}

		if payType == "" {
			rest.rc.Error(c, "支付方式错误！", nil)
			return
		}

		tx := db.Where("user_id = ? AND mid = ? AND vip_level = ? AND fee = ? AND pay_type = ? AND order_status = ?", mpUserId, mid, initVipLevel, fee, payType, "WAIT_BUYER_PAY").First(&co)

		if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		if tx.RowsAffected > 0 {

			if co.PayType == "wxpay" {
				co.RequestPayment.AppId = appId.(string)
				co.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
				co.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
				co.RequestPayment.Package = "prepay_id=" + co.TradeNo
				co.RequestPayment.SignType = "RSA"

				encryptData := []string{
					co.RequestPayment.AppId,
					co.RequestPayment.TimeStamp,
					co.RequestPayment.NonceStr,
					co.RequestPayment.Package,
				}

				signature := wechatUtil.Sign(encryptData)
				co.RequestPayment.PaySign = signature

			}

			rest.rc.Success(c, "获取历史订单成功！", co)
			return
		}

		yearStr, monthStr, dayStr := util.CurrentDate()
		date := yearStr + monthStr + dayStr
		insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":card:" + date

		orderId := util.DateUuid("vip", insertKey, date, mid.(int))

		if orderId == "" {
			rest.rc.Error(c, "订单号生成出错！", nil)
			return
		}

		// 判断用户是否已经开过会员卡
		vipData, err := vip.Show([]string{"user_id = ?"}, []interface{}{userId})
		if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		businessJson, err := saasModel.Options(db, "business_info", mid.(int))
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}
		bi := model.BusinessInfo{}
		json.Unmarshal([]byte(businessJson), &bi)

		// 未开过卡
		if vipData.Id == 0 {
			vip.Mid = mid.(int)
			vip.VipLevel = vipLevel.LevelId
			vip.VipName = vipLevel.LevelName
			vip.StartAt = time.Now().Unix()
			vip.EndAt = 0
			vip.VipNum = vipNum
			vip.Status = 0
			db.Create(&vip)
			co.VipName = vipLevel.LevelName
			co.VipLevel = vipLevel.LevelId
			co.VipNum = vipNum
		} else {
			co.VipName = vipData.VipName
			co.VipLevel = vipData.VipLevel
			co.VipNum = vipData.VipNum
		}

		co.Mid = mid.(int)
		co.OrderId = orderId
		co.PayType = "alipay"
		co.UserId = mpUserId.(int)
		co.Fee = fee
		co.CreateAt = nowUnix
		co.OrderStatus = "WAIT_BUYER_PAY"

		brandName := bi.BrandName
		if brandName == "" {
			brandName = "开通会员卡"
		}

		// 支付宝小程序下单
		if mpType == "alipay" {

			var aliDetail []payment.GoodsDetail

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   "memberCard",
				GoodsName: "付费会员卡",
				Quantity:  "1",
				Price:     fee,
				Body:      memberLevel.LevelName,
			})

			common := payment.Common{}
			bizContent := make(map[string]interface{}, 0)
			bizContent["out_trade_no"] = orderId
			// bizContent["total_amount"] = fee
			// 测试模板
			flag := new(appModel.TestAppId).InList(appId.(string))
			if flag {
				bizContent["total_amount"] = 0.01
			} else {
				bizContent["total_amount"] = fee
			}

			bizContent["discountable_amount"] = 0
			bizContent["subject"] = brandName
			bizContent["body"] = bi.BrandName + "开通会员卡"
			bizContent["buyer_id"] = openid
			bizContent["goods_detail"] = aliDetail
			extendParams := map[string]string{
				"food_order_type": "direct_payment",
			}
			bizContent["extend_params"] = extendParams
			result := common.Create(bizContent)

			if result.Response.Code == "10000" {
				co.TradeNo = result.Response.TradeNo
			} else {
				rest.rc.Error(c, "创建失败！", result.Response)
				return
			}
		}

		// 微信小程序下单
		if mpType == "wxpay" {

			co.PayType = "wxpay"
			mpTheme := saasModel.MpTheme{}
			tx := db.Where("mid = ?", mid).First(&mpTheme)
			if tx.Error != nil {
				if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
					rest.rc.Error(c, "小程序不存在！", nil)
					return
				}
				rest.rc.Error(c, tx.Error.Error(), nil)
				return
			}

			subMchid := mpTheme.SubMchid

			if subMchid == "" {
				rest.rc.Error(c, "请联系管理员配置收款账号！", nil)
				return
			}

			options := wechatEasySdk.OpenOptions()
			bizContent := make(map[string]interface{}, 0)
			bizContent["sp_appid"] = options.SpAppid
			bizContent["sp_mchid"] = options.SpMchid
			bizContent["out_trade_no"] = orderId
			bizContent["sub_appid"] = appId
			bizContent["sub_mchid"] = subMchid

			// 测试模板
			flag := new(appModel.TestAppId).InList(appId.(string))
			if flag {
				bizContent["amount"] = map[string]interface{}{
					"total":    1,
					"currency": "CNY",
				}
			} else {
				bizContent["amount"] = map[string]interface{}{
					"total":    fee * 100,
					"currency": "CNY",
				}
			}

			bizContent["description"] = bi.BrandName + "开通会员卡"

			host := "https://console.mashangdian.cn"
			bizContent["notify_url"] = host + "/api/v1/wechat/pay_notify"

			bizContent["payer"] = map[string]interface{}{
				"sub_openid": openid,
			}

			payResult := new(pay.PartnerPay).Jsapi(bizContent)
			if payResult.Code != "" {
				rest.rc.Error(c, payResult.Message, nil)
				return
			}

			co.TradeNo = payResult.PrepayId

			co.RequestPayment.AppId = appId.(string)
			co.RequestPayment.TimeStamp = strconv.FormatInt(time.Now().Unix(), 10)
			co.RequestPayment.NonceStr = cmfUtil.GetMd5(strconv.FormatInt(time.Now().Unix(), 10))
			co.RequestPayment.Package = "prepay_id=" + co.TradeNo
			co.RequestPayment.SignType = "RSA"

			encryptData := []string{
				co.RequestPayment.AppId,
				co.RequestPayment.TimeStamp,
				co.RequestPayment.NonceStr,
				co.RequestPayment.Package,
			}

			signature := wechatUtil.Sign(encryptData)
			co.RequestPayment.PaySign = signature

		}
		tx = db.Create(&co)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		rest.rc.Success(c, "创建订单成功！", co)

	case "storage":
		// 不达标提交提示不达标
		// 达标后直接开卡
		fallthrough
	case "free":
		if userData.StartAt == 0 {
			vip.Mid = mid.(int)
			vip.VipLevel = viMap.Level[0].LevelId
			vip.VipName = viMap.Level[0].LevelName
			vip.EndAt = int64(card.ValidPeriod) + nowUnix
			vip.EndAt = -1
			vip.VipNum = vipNum
			vip.Status = 1
			db.Create(&vip)
			rest.rc.Success(c, "开卡成功！", nil)
		} else {
			rest.rc.Error(c, "该用户已经领取了会员卡！", nil)
		}
	default:
		rest.rc.Success(c, "开卡失败！非法访问", nil)
	}

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取投放链接
 * @Date 2020/12/12 18:48:9
 * @Param
 * @return
 **/

func (rest *Card) Apply(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	card := model.CardTemplate{}
	tx := db.Where("id = ? AND mid = ?", 1, mid).First(&card)

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	bizContent := map[string]interface{}{
		"template_id": card.TemplateId,
	}

	result, err := new(marketing.Card).Apply(bizContent)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	if result.Response.Code != "10000" {
		rest.rc.Error(c, "获取失败！"+result.Response.SubMsg, result)
		return
	}

	enEscapeUrl, _ := url.QueryUnescape(result.Response.ApplyCardUrl)

	rest.rc.Success(c, "获取成功！", gin.H{"apply_card_url": enEscapeUrl})

}

// 同步到支付宝卡包
func (rest *Card) SyncCardToAlipay(c *gin.Context) {

	authToken := c.PostForm("auth_token")

	if authToken == "" {
		rest.rc.Error(c, "用户授权token不能为空！", nil)
		return
	}

	oauthResult := new(base.Oauth).GetSystemToken(authToken)

	if oauthResult.Response.Code != "" {
		rest.rc.Error(c, "授权令牌获取失败！"+oauthResult.Response.SubMsg, nil)
		return
	}

	accessToken := oauthResult.Response.AccessToken

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mpUserId, _ := c.Get("mp_user_id")
	Openid, _ := c.Get("open_id")
	mid, _ := c.Get("mid")

	cardTemplate := model.CardTemplate{
		Db: db,
	}

	ct, err := cardTemplate.Show([]string{"id = ? AND mid = ? AND status = ?"}, []interface{}{1, mid, 1})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	memberCard := model.MemberCard{
		Db: db,
	}
	mc, err := memberCard.Show([]string{"user_id = ? AND mid = ? AND status = ? and delete_at = ?"}, []interface{}{mpUserId, mid, 1, 0})

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	user := model.User{
		Db: db,
	}

	u, err := user.Show([]string{"u.id = ? AND mid = ? AND user_type = ? AND user_status = ?"}, []interface{}{mpUserId, mid, 0, 1})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	cui := marketing.CardUserInfo{
		UserUniId:     Openid.(string),
		UserUniIdType: "UID",
	}

	ftl := []marketing.FrontTextList{{
		Label: "文标题一",
		Value: "急速",
	}, {
		Label: "文标题二",
		Value: "高效",
	}, {
		Label: "文标题三",
		Value: "稳定",
	}}

	openDate := time.Unix(mc.StartAt, 0).Format(data.TimeLayout)
	ValidDate := time.Unix(mc.EndAt, 0).Format(data.TimeLayout)

	cei := marketing.CardExtInfo{
		OpenDate:       openDate,
		ValidDate:      ValidDate,
		Level:          mc.VipLevel,
		Point:          strconv.Itoa(u.Score),
		Balance:        strconv.FormatFloat(u.Balance, 'f', -1, 64),
		ExternalCardNo: mc.VipNum,
		FrontTextList:  ftl,
	}

	gende := ""
	if u.Gender == 1 {
		gende = "MALE"
	}
	if u.Gender == 2 {
		gende = "FEMALE"
	}

	mei := marketing.MemberExtInfo{
		Name:  u.UserRealName,
		Birth: "2016-06-27",
		Cell:  "15161178721",
	}

	if gende != "" {
		mei.Gende = gende
	}

	bizContent := map[string]interface{}{
		"out_serial_no":    time.Now().Unix(),
		"card_template_id": ct.TemplateId,
		"card_user_info":   cui,
		"card_ext_info":    cei,
		"member_ext_info":  mei,
	}

	cardResult := new(marketing.Card).Send(bizContent, accessToken)

	if cardResult.Response.Code != "10000" {
		rest.rc.Error(c, "同步失败！"+cardResult.Response.SubMsg, cardResult.Response)
		return
	}

	rest.rc.Success(c, "同步成功！", nil)

}
