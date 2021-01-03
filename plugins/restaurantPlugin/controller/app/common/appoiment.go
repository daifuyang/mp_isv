/**
** @创建时间: 2020/12/19 10:14 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"encoding/json"
	"errors"
	"gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"math"
	"strconv"
	"strings"
	"time"
)

type Appointment struct {
	rc controller.RestController
}

func (rest *Appointment) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")
	// 获取当前门店是否开启预约
	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", "eat_in", storeId,mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	ei := model.EatIn{}
	json.Unmarshal([]byte(op.OptionValue), &ei)

	var sh []model.StoreHours
	cmf.NewDb().Where("store_id = ?", storeId).Find(&sh)

	t := time.Now()
	wd := int(t.Weekday())

	var (
		startHours string
		endHours   string
	)

	for _, v := range sh {

		startHours = v.StartTime
		endHours = v.EndTime

		switch wd {
		case v.Mon:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Tues:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Wed:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Thur:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Fri:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Sat:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		case v.Sun:
			if v.AllTime == 1 {
				startHours = "00:00"
				endHours = "23.59"
			}
		}

	}

	var timeResult []string
	if ei.EnabledAppointment == 1 && startHours != "" && endHours != "" {

		// 获取门店营业时间
		startHours := startHours
		endHours := endHours

		endSplit := strings.Split(endHours, ":")
		endH, _ := strconv.Atoi(endSplit[0])

		if endH == 0 {
			endH = 24
		}

		tmp, _ := time.ParseInLocation("15:04", startHours, time.Local)

		// 循环时间段
		// time.Now().Format("15:04")
		timeStr := time.Now().Format("15:04")

		// 早于营业时间，设置为营业时间预约
		if time.Now().Unix() < tmp.Unix() {
			timeStr = startHours
		}

		timeSplit := strings.Split(timeStr, ":")
		h := timeSplit[0]

		hour, _ := strconv.Atoi(h)
		timeIndex := endH - hour
		m := timeSplit[1]
		minute, _ := strconv.ParseFloat(m, 64)
		minute = math.Ceil(minute/10) * 10
		// 循环小时
		for i := 0; i < timeIndex; i++ {
			// 循环分钟
			minuteIndex := 6
			minuteInit := 00
			if i == 0 {
				minuteIndex = int((50 - minute) / 10)
				minuteInit = int(minute)

				if minuteInit == 0 {
					minuteInit = 10
				}

				if minuteIndex < 0 {
					minuteIndex = 0
				}
			}

			// 循环分钟段
			for mi := 0; mi < minuteIndex; mi++ {
				hourKey := hour + i
				minuteKey := strconv.Itoa(minuteInit + mi*10)
				if minuteKey == "0" {
					minuteKey = "00"
				}

				hd := strconv.Itoa(hourKey) + ":" + minuteKey
				timeResult = append(timeResult, hd)
			}
		}
	}
	rest.rc.Success(c, "获取成功！", timeResult)
}
