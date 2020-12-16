/**
** @创建时间: 2020/12/12 6:46 下午
** @作者　　: return
** @描述　　:
 */
package card

import (
	"encoding/json"
	"gincmf/app/util"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	"github.com/gincmf/alipayEasySdk/marketing"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"net/url"
	"strconv"
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
	vipInfo := util.Options("vip_info")

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

	vipInfo := util.Options("vip_info")

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

	// 新建会员卡
	switch viMap.Level[0].GetType {
	case "pay":
		// 返回付费订单号
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

			/*
			 ** 唯一uid编号生成逻辑
			 ** 日期 + 当天排号数量
			 */
			yearStr, monthStr, dayStr := util.CurrentDate()
			insertKey := "mp_isv"+strconv.Itoa(mid.(int))+":member_card:" + yearStr + monthStr + dayStr

			// 设置当天失效时间
			year, month, day := time.Now().Date()
			today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
			cmf.NewRedisDb().ExpireAt(insertKey, today)
			val := util.SetIncr(insertKey)

			nStr := yearStr + monthStr + dayStr + strconv.FormatInt(val, 10)
			n, _ := strconv.Atoi(nStr)
			vipNum := util.EncodeId(uint64(n))
			vip.VipNum = strconv.Itoa(vipNum)

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
