/**
** @创建时间: 2020/12/19 10:14 下午
** @作者　　: return
** @描述　　:
 */
package common

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/util"
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
	rc controller.Rest
}

type TimeMap struct {
	Label    string     `json:"label"`
	Value    string     `json:"value"`
	Children *[]TimeMap `json:"children,omitempty"`
}

func (rest *Appointment) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")

	typ := c.Query("type")

	if typ == "" {
		rest.rc.Error(c, "类型不能为空！", nil)
		return
	}

	opName := ""
	if typ == "eatin" {
		opName = "eatin"
	}else if typ == "takeout" || typ == "pack" {
		opName = "takeout"
	} else {
		rest.rc.Error(c, "错误类型！", nil)
		return
	}

	// 获取当前门店是否开启预约
	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", opName, storeId, mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	enabledAppointment := false
	day := 0

	if typ == "eatin" {
		ei := model.EatIn{}
		json.Unmarshal([]byte(op.OptionValue), &ei)
		if ei.EnabledAppointment == 1 {
			enabledAppointment = true
		}
		day = ei.Day
	} else {
		to := model.TakeOut{}
		json.Unmarshal([]byte(op.OptionValue), &to)
		if to.EnabledAppointment == 1 {
			enabledAppointment = true
		}
		day = to.Day
	}

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

	var timeMap = make([]TimeMap, 0)
	if enabledAppointment && startHours != "" && endHours != "" {

		endSplit := strings.Split(endHours, ":")
		endH, _ := strconv.Atoi(endSplit[0])
		if endH == 0 {
			endH = 24
		}

		h := time.Now().Hour()
		min := time.Now().Minute()

		// 今天超时不允许下单 （提前半小时停止下单）
		currentDay := true
		if h == (endH-1) && min > 30 {
			currentDay = false
		}

		for i := 0; i < day; i++ {

			if i == 0 {
				if !currentDay {
					day += 1
					continue
				}
			}

			year, month, day := time.Now().Date()
			temDay := day + i
			temStr := fmt.Sprintf("%02d", temDay)

			monthInt := int(month)
			monthTotal := util.MonthCount(year, monthInt)
			// 如果大于最后一天
			if temDay > monthTotal {
				temStr = "01"
				monthInt += 1
			}
			monthStr := fmt.Sprintf("%02d", monthInt)

			if monthInt > 12 {
				monthStr = "01"
				year += 1
			}
			yearStr := strconv.Itoa(year)

			label := monthStr + "-" + temStr
			value := yearStr + "-" + label
			if i == 0 && h < endH {
				label = "今天(" + label + ")"
			}
			if i == 1 {
				label = "明天(" + label + ")"
			}
			if i == 2 {
				label = "后天(" + label + ")"
			}

			dayItem := TimeMap{
				Label: label,
				Value: value,
			}

			// 获取小时（今天）
			var hour = make([]TimeMap, 0)
			if i == 0 {
				hour = rest.getHours(true, h, endH)
			} else {
				timeSplit := strings.Split(startHours, ":")
				h, _ := strconv.Atoi(timeSplit[0])
				hour = rest.getHours(false, h, endH)
			}


			dayItem.Children = &hour

			timeMap = append(timeMap, dayItem)


		}

	}

	rest.rc.Success(c, "获取成功！", timeMap)

}

func (rest *Appointment) getHours(current bool, start int, end int) []TimeMap {
	var hour = make([]TimeMap, 0)
	hLen := end - start

	if hLen > 0 {
		for i := 0; i < hLen; i++ {

			val := start + i

			valStr := fmt.Sprintf("%02d", val)

			minStart := 0

			if i == 0 {
				minStart = 10
			}

			min := time.Now().Minute()

			startRange := 20
			if current && i == 0 {

				minStart = min + startRange
				hour := time.Now().Hour()
				// 最后截止30分钟营业
				if hour == end-1 && min > 30 {
					continue
				}

				// 间隔10分钟
				if min > 50 {
					continue
				}
			}

			if current && i == 1 {
				if min > 50 {
					minStart = startRange
				}
			}

			hourItem := TimeMap{
				Label: valStr,
				Value: valStr,
			}

			minute := rest.getMinutes(minStart)
			if len(minute) > 0 {
				hourItem.Children = &minute
				hour = append(hour, hourItem)
			}
		}
	}
	return hour
}

func (rest *Appointment) getMinutes(min int) []TimeMap {

	var minutes = make([]TimeMap, 0)

	minute := float64(min)
	minute = math.Ceil(minute/10) * 10
	minLen := (60 - int(minute)) / 10

	for i := 0; i < minLen; i++ {

		minTemp := i*10 + int(minute)

		minValue := fmt.Sprintf("%02d", minTemp)

		minItem := TimeMap{
			Label: minValue,
			Value: minValue,
		}

		minutes = append(minutes, minItem)
	}

	return minutes

}

func (rest *Appointment) ShowBak(c *gin.Context) {

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")
	// 获取当前门店是否开启预约
	op := model.Option{}
	result := cmf.NewDb().Where("option_name = ? AND store_id = ? AND mid = ?", "eatin", storeId, mid).First(&op)
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

	var timeResult [][]string
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
		timeStr := time.Now().Format("15:04")

		// 早于营业时间，设置为营业时间预约
		if time.Now().Unix() < tmp.Unix() {
			timeStr = startHours
		}

		var date = make([]map[string]interface{}, 0)
		date = append(date, map[string]interface{}{
			"startTime": timeStr,
			"endHours":  endH,
		})

		for i := 0; i < ei.Day; i++ {
			date = append(date, map[string]interface{}{
				"startTime": startHours,
				"endHours":  endH,
			})
		}

		for _, v := range date {
			r := rest.GetDuration(v["startTime"].(string), v["endHours"].(int))
			fmt.Println("r", r)
		}

	}
	rest.rc.Success(c, "获取成功！", timeResult)
}

func (rest *Appointment) GetDuration(startTime string, endH int) []string {

	var timeResult []string

	timeSplit := strings.Split(startTime, ":")
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

	return timeResult

}
