/**
** @创建时间: 2021/1/1 2:41 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfUtil "github.com/gincmf/cmf/util"
	"math"
	"strconv"
	"time"
)

type GeoResult struct {
	Status      string     `json:"status"`
	Info        string     `json:"info"`
	InfoCode    string     `json:"infocode"`
	Count       string     `json:"count"`
	MapGeoCodes []geoCodes `json:"geocodes"`
}

type geoCodes struct {
	FormattedAddress string `json:"formatted_address"`
	Country          string `json:"country"`
	Province         string `json:"province"`
	Citycode         string `json:"citycode"`
	City             string `json:"city"`
	District         string `json:"district"`
	Location         string `json:"location"`
}

func QueueNo(appId string) string {
	// 生成取餐号
	var number float64 = 10000

	now := time.Now()
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)

	unix := 86400 - today.Sub(now).Seconds()

	if unix < number {
		number += number
	} else {
		number = unix
	}

	queueNo := strconv.Itoa(int(math.Floor(number + 0.5)))

	// 获取redis自增队列

	yearStr, monthStr, dayStr := util.CurrentDate()
	date := yearStr + monthStr + dayStr

	insertKey := "mp_isv" + appId + ":order_queue:" + date
	// 设置当天失效时间
	cmf.NewRedisDb().ExpireAt(insertKey, today)

	return queueNo
}

func GeoAddress(address string) GeoResult {
	url := "https://restapi.amap.com/v3/geocode/geo?address=" + address + "&key=76ac3510ca6d38aac23ddd8ba6d92aab"
	_, geoResult := cmfUtil.Request("GET", url, nil, nil)

	var geo GeoResult
	_ = json.Unmarshal(geoResult,&geo)

	return geo
}