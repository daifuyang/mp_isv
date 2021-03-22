/**
** @创建时间: 2020/12/12 2:08 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/base"
	"github.com/gincmf/alipayEasySdk/marketing"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/gincmf/cmf/data"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Index struct {
	rc controller.RestController
}

func (rest *Index) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	card := model.CardTemplate{}
	tx := cmf.NewDb().Where("id = ? AND mid = ?", "1", mid).First(&card)

	if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	benefitInfo := card.BenefitInfo

	var tbiArr []marketing.TemplateBenefitInfo
	json.Unmarshal([]byte(benefitInfo), &tbiArr)

	card.CardBackgroundPrev = util.GetFileUrl(card.CardBackground)
	card.CreateTime = time.Unix(card.CreateAt, 0).Format(data.TimeLayout)
	card.UpdateTime = time.Unix(card.CreateAt, 0).Format(data.TimeLayout)

	card.BenefitInfoJson = tbiArr
	rest.rc.Success(c, "获取成功！", card)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 创建会员卡
 * @Date 2020/12/12 14:8:55
 * @Param
 * @return
 **/

func (rest *Index) Edit(c *gin.Context) {

	appId, _ := c.Get("app_id")
	mid, _ := c.Get("mid")

	cardName := c.PostForm("card_name")
	if cardName == "" {
		rest.rc.Error(c, "会员卡名称不能为空！", nil)
		return
	}

	card := model.CardTemplate{}
	tx := cmf.NewDb().Where("id = ?", "1").First(&card)

	cardBackground := c.PostForm("card_background")
	if cardBackground == "" {
		cardBackground = "template/vip.png"
	}

	syncToAlipay := c.PostForm("sync_to_alipay")
	syncToAlipayInt := 0
	if syncToAlipay == "1" {
		syncToAlipayInt = 1
	}

	businessJson := saasModel.Options("business_info", mid.(int))

	bi := model.BusinessInfo{}

	json.Unmarshal([]byte(businessJson), &bi)

	if bi.BrandName == "" || bi.BrandLogo == "" || bi.Mobile == "" {
		rest.rc.Error(c, "请先完善基本信息！", nil)
		return
	}

	validPeriod := c.PostForm("valid_period")

	validPeriodInt, err := strconv.Atoi(validPeriod)
	if err != nil {
		rest.rc.Error(c, "有效期参数非法！", nil)
		return
	}

	// 会员权益
	benefitInfo := c.PostForm("benefit_info")
	benefitInfoJson := "[]"
	if benefitInfo != "" && json.Valid([]byte(benefitInfo)) {
		benefitInfoJson = benefitInfo
	}

	var tbiArr []marketing.TemplateBenefitInfo
	json.Unmarshal([]byte(benefitInfo), &tbiArr)

	timeLayout := "2006-01-02 15:04:05"
	nowUnix := time.Now().Unix()

	for k := range tbiArr {
		tbiArr[k].StartDate = time.Unix(nowUnix, 0).Format(timeLayout)
		tbiArr[k].EndDate = "2199-01-01 00:00:00"
	}

	t := time.Now().Unix()
	card.Mid = mid.(int)
	card.CardName = cardName
	card.CardShowName = cardName
	card.CardBackground = cardBackground

	card.ValidPeriod = validPeriodInt
	card.BenefitInfo = benefitInfoJson
	card.SyncToAlipay = syncToAlipayInt
	card.CreateAt = t
	card.UpdateAt = t

	if syncToAlipayInt == 1 {

		alipayUserId, _ := c.Get("alipay_user_id")
		if alipayUserId == 0 {
			rest.rc.Error(c, "请先完成支付宝授权绑定", nil)
			return
		}

		absPath := util.CurrentPath() + "/public/uploads/" + cardBackground

		b, err := util.ExistPath(absPath)
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		if !b {
			rest.rc.Error(c, "会员卡背景图地址错误！", nil)
			return
		}

		img := base.Image{}
		bizContent := make(map[string]string, 0)
		bizContent["image_type"] = "jpg"
		bizContent["image_name"] = "vip_background"
		imgResult, _ := img.Upload(bizContent, absPath)

		if imgResult.Response.Code != "10000" {
			rest.rc.Error(c, "上传失败！"+imgResult.Response.SubMsg, imgResult)
			return
		}

		card.AlipayBackgroundId = imgResult.Response.ImageId

		mCard := marketing.Card{}
		// 同步到支付宝

		var cardResult marketing.CardCreateResult

		// 开卡逻辑
		if tx.RowsAffected == 0 {
			// 会员卡支付宝样式
			tsi := marketing.TemplateStyleInfo{
				CardShowName: cardName,
				LogoId:       bi.AlipayLogoId,
				BackgroundId: card.AlipayBackgroundId,
				BgColor:      "#FFFFFF",
			}

			cil := []marketing.ColumnInfoList{{
				Code:  "BALANCE",
				Title: "余额",
				Value: "",
			}, {
				Code:  "TELEPHONE",
				Title: "客服电话",
				Value: bi.Mobile,
			}, {
				Code:  "Point",
				Title: "积分",
				Value: "",
			}}

			frl := []marketing.FiledRuleList{
				{
					FieldName: "Balance",
					RuleName:  "ASSIGN_FROM_REQUEST",
					RuleValue: "Balance",
				}, {
					FieldName: "Point",
					RuleName:  "ASSIGN_FROM_REQUEST",
					RuleValue: "Point",
				}, {
					FieldName: "OpenDate",
					RuleName:  "DATE_IN_FUTURE",
					RuleValue: "0d",
				},
			}

			// 追加有效期
			if validPeriodInt > 0 {
				frl = append(frl, marketing.FiledRuleList{
					FieldName: "ValidDate",
					RuleName:  "DATE_IN_FUTURE",
					RuleValue: validPeriod + "d",
				})
			}

			//行动点
			cal := []marketing.CardActionList{
				{
					Code:    "order",
					Text:    "点餐",
					UrlType: "url",
					Url:     "https://merchant.ali.com/ee/clock_in.do",
					MiniAppUrl: &marketing.MiniAppUrl{
						MiniAppId:     appId.(string),
						DisplayOnList: "true",
					}},
				{
					Code:    "pay",
					Text:    "充值",
					UrlType: "url",
					Url:     "https://www.baodu.com",
					MiniAppUrl: &marketing.MiniAppUrl{
						MiniAppId:     appId.(string),
						DisplayOnList: "true",
					}}, {
					Code:    "other",
					Text:    "其他",
					UrlType: "url",
					Url:     "https://www.baodu.com",
					MiniAppUrl: &marketing.MiniAppUrl{
						MiniAppId:     appId.(string),
						DisplayOnList: "true",
					}}}

			bizMap := map[string]interface{}{
				"request_id":            time.Now().Unix(),
				"card_type":             "OUT_MEMBER_CARD",
				"biz_no_suffix_len":     "12",
				"write_off_type":        "qrcode",
				"template_style_info":   tsi,
				"template_benefit_info": tbiArr,
				"column_info_list":      cil,
				"field_rule_list":       frl,
				"card_action_list":      cal,
			}

			cardResult = mCard.CreateTemplate(bizMap)

			if cardResult.Response.Code != "10000" {
				rest.rc.Error(c, "开卡失败！"+cardResult.Response.SubMsg, nil)
				return
			}

			card.TemplateId = cardResult.Response.TemplateId

			// 配置开卡表单
			bizFormContent := map[string]interface{}{
				"template_id": card.TemplateId,
				"fields": marketing.Fields{
					Required: `{"common_fields":["OPEN_FORM_FIELD_MOBILE"]}`,
					Optional: `{"common_fields":["OPEN_FORM_FIELD_NAME"]}`,
				},
			}
			new(marketing.Card).SetForm(bizFormContent)

		} else {
			// cardResult = mCard.Update(bizMap)
		}

	}

	if tx.RowsAffected == 0 {
		tx = cmf.NewDb().Create(&card)
	} else {
		tx = cmf.NewDb().Save(&card)
	}

	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "编辑成功！", card)

}
