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

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

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
	} else if typ == "takeout" || typ == "pack" {
		opName = "takeout"
	} else {
		rest.rc.Error(c, "错误类型！", nil)
		return
	}

	// 获取当前门店是否开启预约
	op := model.Option{}
	result := db.Where("option_name = ? AND store_id = ? AND mid = ?", opName, storeId, mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	enabledAppointment := false
	day := 0

	if typ == "eatin" || typ == "pack" {
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

	if day == 0 {
		day = 1
	}

	var sh []model.StoreHours
	db.Where("store_id = ? AND  mid = ?", storeId, mid).Find(&sh)

	t := time.Now()
	wd := int(t.Weekday())

	var (
		startHours string
		endHours   string
	)

	for _, v := range sh {

		if !(v.AllTime == 0 && v.StartTime == "00:00" && v.EndTime == "00:00") {
			startHours = v.StartTime
			endHours = v.EndTime
		}

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

	fmt.Println(enabledAppointment)

	var timeMap = make([]TimeMap, 0)
	if enabledAppointment && startHours != "" && endHours != "" {

		startSplit := strings.Split(startHours, ":")
		startH := 0
		startM := 0
		if len(startSplit) > 1 {
			startH, _ = strconv.Atoi(startSplit[0])
			startM, _ = strconv.Atoi(startSplit[1])
		}

		endH := 0
		endM := 0

		endSplit := strings.Split(endHours, ":")
		if len(endSplit) > 1 {
			endH, _ = strconv.Atoi(endSplit[0])
			endM, _ = strconv.Atoi(endSplit[1])
		}

		if endH == 0 {
			endH = 24
		}

		h := t.Hour()

		min := t.Minute()

		// 今天超时不允许下单 （提前半小时停止下单）
		currentDay := true

		if h < startH {
			currentDay = false
		}

		if h < endH {
			if h == (endH-1) && (60-min)+endM < 30 {
				currentDay = false
			}
		}

		if h == endH && endM-min < 30 {
			currentDay = false
		}

		if h > endH {
			currentDay = false
		}

		for i := 0; i < day; i++ {

			if i == 0 {
				if !currentDay {
					day += 1
					continue
				}
			}

			year, month, day := t.Date()
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

			hour = rest.getHours(currentDay, startH, endH, startM, endM)

			dayItem.Children = &hour

			timeMap = append(timeMap, dayItem)

		}

	}

	rest.rc.Success(c, "获取成功！", timeMap)

}

func (rest *Appointment) getHours(currentDay bool, start, end, startM, endM int) []TimeMap {

	var hour = make([]TimeMap, 0)

	t := time.Now()

	ch := start

	if currentDay {
		ch = t.Hour() // 当前时间
	}

	hLen := end - ch

	for i := 0; i <= hLen; i++ {

		val := ch + i

		valStr := fmt.Sprintf("%02d", val)

		startMin := 0

		currentMin := 20

		if currentDay {
			currentMin = t.Minute()
		}

		if i == 0 {
			startMin = currentMin + 10
		}

		// 起送时间段
		if start == val {

			// 未到起送时间
			if ch < val {
				currentMin = 0
			}

			if startMin > currentMin {
				currentMin = startMin
			}

			if currentDay {
				startMin = currentMin
			}
		}

		hourItem := TimeMap{
			Label: valStr,
			Value: valStr,
		}

		minute := rest.getMinutes(false, startMin, endM)
		if i == hLen {
			minute = rest.getMinutes(true, startMin, endM)
		}

		if len(minute) > 0 {
			hourItem.Children = &minute
			hour = append(hour, hourItem)
		}
	}
	return hour
}

func (rest *Appointment) getMinutes(end bool, min int, endM int) []TimeMap {

	var minutes = make([]TimeMap, 0)

	minute := float64(min)

	minute = math.Ceil(minute/10) * 10

	minLen := (60 - int(minute)) / 10

	if end {
		minLen = (endM - int(minute)) / 10
	}

	for i := 0; i < minLen; i++ {

		minTemp := i*10 + int(minute)

		if minTemp < 60 {

			minValue := fmt.Sprintf("%02d", minTemp)

			minItem := TimeMap{
				Label: minValue,
				Value: minValue,
			}

			minutes = append(minutes, minItem)

		}

	}

	return minutes

}

func (rest *Appointment) ShowBak(c *gin.Context) {

	db, err := util.NewDb(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	mid, _ := c.Get("mid")

	storeId, _ := c.Get("store_id")
	// 获取当前门店是否开启预约
	op := model.Option{}
	result := db.Where("option_name = ? AND store_id = ? AND mid = ?", "eatin", storeId, mid).First(&op)
	if result.Error != nil && !errors.Is(result.Error, gorm.ErrRecordNotFound) {
		rest.rc.Error(c, result.Error.Error(), nil)
		return
	}

	ei := model.EatIn{}
	json.Unmarshal([]byte(op.OptionValue), &ei)

	var sh []model.StoreHours
	db.Where("store_id = ?", storeId).Find(&sh)

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
		timeStr := t.Format("15:04")

		// 早于营业时间，设置为营业时间预约
		if t.Unix() < tmp.Unix() {
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
			_ = rest.GetDuration(v["startTime"].(string), v["endHours"].(int))
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
