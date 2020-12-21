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
	"gincmf/plugins/restaurantPlugin/controller/admin/settings"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	"github.com/gincmf/alipayEasySdk/payment"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"net/url"
	"strconv"
	"strings"
	"time"
)

type Card struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取开卡信息
 * @Date 2020/12/13 10:36:9
 * @Param
 * @return
 **/
func (rest *Card) VipDetail(c *gin.Context) {

	// 获取当前用户信息
	userId, _ := c.Get("mp_user_id")

	u := model.User{}

	userData, err := u.Show([]string{"u.id = ?"}, []interface{}{userId})

	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	// 获取会员卡状态
	card := model.CardTemplate{}
	tx := cmf.NewDb().Where("id = ? AND status = ? AND delete_at = ?", 1, 1, 0).First(&card)
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
		Num          float64       `json:"num"`
		ApplyCardUrl string        `json:"apply_card_url"`
		Allow        bool          `json:"allow"`
	}

	result.ValidPeriod = card.ValidPeriod

	if tx.RowsAffected == 0 {
		rest.rc.Error(c, "非法请求开卡，用户未开启开卡！", nil)
	}

	// 获取当前配置会员卡开卡信息
	vipInfo := appModel.Options("vip_info")

	var viMap model.VipInfo
	json.Unmarshal([]byte(vipInfo), &viMap)

	// 获取当前用户的信息
	for _, v := range viMap.Level {
		// 用户的经验取值范围
		if userData.Exp < v.ExpRangeEnd {

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
			result.Num = v.Num
			result.Benefit = v.Benefit
			break
		}
	}

	rest.rc.Success(c, "获取成功！", result)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 开卡投放
 * @Date 2020/12/13 18:29:10
 * @Param
 * @return
 **/
func (rest *Card) Send(c *gin.Context) {

	appId, _ := c.Get("app_id")
	mpUserId, _ := c.Get("mp_user_id")
	mpType, _ := c.Get("mp_type")
	Openid, _ := c.Get("open_id")
	// 获取当前用户信息
	mid, _ := c.Get("mid")

	userId, _ := c.Get("mp_user_id")

	u := model.User{}
	userData, err := u.Show([]string{"u.id = ?"}, []interface{}{userId})

	if err != nil {
		rest.rc.Error(c, "获取失败！"+err.Error(), err)
		return
	}

	// 获取会员卡状态
	card := model.CardTemplate{}
	tx := cmf.NewDb().Where("id = ? AND status = ? AND delete_at = ?", 1, 1, 0).First(&card)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	vipInfo := appModel.Options("vip_info")

	var viMap model.VipInfo
	json.Unmarshal([]byte(vipInfo), &viMap)

	// 获取会员信息
	vip := model.MemberCard{
		UserId: userData.Id,
	}

	nowUnix := time.Now().Unix()
	vip.StartAt = nowUnix
	vip.CreateAt = nowUnix
	vip.UpdateAt = nowUnix

	levelId, _ := strconv.Atoi(strings.Replace(vip.VipLevel, "VIP", "", -1))

	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */
	yearStr, monthStr, dayStr := util.CurrentDate()
	insertKey := "mp_isv" + strconv.Itoa(mid.(int)) + ":member_card:" + yearStr + monthStr + dayStr
	date := yearStr + monthStr + dayStr
	vipNum := util.DateUuid("",insertKey,date)
	// 新建会员卡
	switch viMap.Level[levelId].GetType {
	case "pay":

		co := model.MemberCardOrder{}
		// 返回付费订单号
		fee := viMap.Level[levelId].Num
		if fee <= 0 {
			rest.rc.Error(c, "商家会员卡配置出错！", nil)
			return
		}

		tx := cmf.NewDb().Where("user_id = ? AND vip_level = ? AND fee = ? AND pay_type = ? AND order_status = ?",mpUserId,vip.VipLevel,fee,"alipay","WAIT_BUYER_PAY").First(&co)

		if tx.Error != nil && !errors.Is(tx.Error,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,tx.Error.Error(),nil)
			return
		}

		if tx.RowsAffected > 0 {
			rest.rc.Success(c,"获取历史订单成功！",co)
			return
		}

		appIdInt, _ := appId.(int)
		appIdStr := strconv.Itoa(appIdInt)

		yearStr, monthStr, dayStr := util.CurrentDate()
		date := yearStr + monthStr + dayStr
		insertKey := "mp_isv" + appIdStr + ":card:" + date

		orderId := util.DateUuid("vip", insertKey, date)

		if orderId == "" {
			rest.rc.Error(c, "订单号生成出错！", nil)
			return
		}

		// 判断用户是否已经开过会员卡
		vipData ,err := vip.Show([]string{"user_id = ?"},[]interface{}{userId})
		if err != nil && !errors.Is(err,gorm.ErrRecordNotFound) {
			rest.rc.Error(c,err.Error(),nil)
			return
		}

		// 未开过卡
		if vipData.Id == 0 {
			vip.VipLevel = viMap.Level[0].LevelId
			vip.VipName = viMap.Level[0].LevelName
			vip.EndAt = int64(card.ValidPeriod) + nowUnix
			vip.EndAt = time.Now().Unix()
			vip.VipNum = vipNum
			vip.Status = 0
			cmf.NewDb().Create(&vip)
		}

		// 支付宝小程序下单
		businessJson := appModel.Options("business_info")
		bi := settings.BusinessInfo{}
		json.Unmarshal([]byte(businessJson), &bi)

		co.VipNum = vipNum
		co.VipLevel = viMap.Level[0].LevelId
		co.OrderId = orderId
		co.PayType = "alipay"
		co.UserId = mpUserId.(int)
		co.Fee = fee
		co.CreateAt = nowUnix
		co.OrderStatus = "WAIT_BUYER_PAY"

		// 支付宝小程序下单
		if mpType == "alipay" {

			var aliDetail []payment.GoodsDetail

			aliDetail = append(aliDetail, payment.GoodsDetail{
				GoodsId:   "memberCard",
				GoodsName: "付费会员卡",
				Quantity:  "1",
				Price:     fee,
				Body:      viMap.Level[levelId].LevelName,
			})

			common := payment.Common{}
			bizContent := make(map[string]interface{}, 0)
			bizContent["out_trade_no"] = orderId
			bizContent["total_amount"] = fee
			// bizContent["discountable_amount"] = 0
			bizContent["subject"] = bi.BrandName
			bizContent["body"] = bi.BrandName + "开通会员卡"
			bizContent["buyer_id"] = Openid
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

		tx = cmf.NewDb().Create(&co)
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
		fallthrough
	default:
		if userData.StartAt == 0 {
			vip.VipLevel = viMap.Level[0].LevelId
			vip.VipName = viMap.Level[0].LevelName
			vip.EndAt = int64(card.ValidPeriod) + nowUnix
			vip.EndAt = -1
			vip.VipNum = vipNum
			vip.Status = 1
			cmf.NewDb().Create(&vip)
			rest.rc.Success(c, "开卡成功！", nil)
		} else {
			rest.rc.Error(c, "该用户已经领取了会员卡！", nil)
		}
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

	card := model.CardTemplate{}
	tx := cmf.NewDb().Where("id = ?", 1).First(&card)

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
