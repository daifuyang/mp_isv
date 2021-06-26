/**
** @创建时间: 2021/3/16 10:50 下午
** @作者　　: return
** @描述　　: 工作台数据
 */
package dashboard

import (
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	resModel "gincmf/plugins/restaurantPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"github.com/shopspring/decimal"
	"math"
	"strings"
	"time"
)

type Dashboard struct {
	rc controller.Rest
}

type dashboardCard struct {
	ActuallyAmount  float64 `json:"actually_amount"`
	SalesAmount     float64 `json:"sales_amount"`
	FoodOrderAmount float64 `json:"food_order_amount"`
	MemberAmount    float64 `json:"member_amount"`
	RechargeAmount  float64 `json:"recharge_amount"`
	OrderCount      int64   `json:"order_count"`
	FoodOrderCount  int64   `json:"food_order_count"`
	MemberCount     int64   `json:"member_count"`
	RechargeCount   int64   `json:"recharge_count"`
	NewMembersCount int64   `json:"new_members_count"`
}

type data struct {
	Label string  `json:"label"`
	Value float64 `json:"value"`
}

//门店排名
type storeSalesRanking struct {
	StoreName   string  `json:"store_name"`   //门店名称
	SalesAmount float64 `json:"sales_amount"` // 销售额
}

type dashboardAnalysis struct {
	SalesAnalysis     []data              `json:"sales_analysis"`
	StoreSalesRanking []storeSalesRanking `json:"store_sales_ranking"`
}

// 获取首页面板数据
func (rest *Dashboard) DashboardCard(c *gin.Context) {

	var whenMap = []string{"today", "yesterday", "week"}

	var dashboardResult struct {
		Today                     dashboardCard `json:"today"`
		Yesterday                 dashboardCard `json:"yesterday"`
		Week                      dashboardCard `json:"week"`
		DayActuallyGrowth         float64       `json:"day_actually_growth"`
		WeekActuallyGrowth        float64       `json:"week_actually_growth"`
		DaySalesGrowth            float64       `json:"day_sales_growth"`
		WeekSalesGrowth           float64       `json:"week_sales_growth"`
		DayOrderCountGrowth       float64       `json:"day_order_count_growth"`
		WeekOrderCountGrowth      float64       `json:"week_order_count_growth"`
		DayNewMembersCountGrowth  float64       `json:"day_new_members_count_growth"`
		WeekNewMembersCountGrowth float64       `json:"week_new_members_count_growth"`
	}

	for _, v := range whenMap {

		actuallyQuery := []string{"trade_status = ?"}
		actuallyQueryArgs := []interface{}{"TRADE_SUCCESS"}

		salesQuery := []string{"(order_status = ? OR order_status = ?)"}
		salesQueryArgs := []interface{}{"TRADE_SUCCESS", "TRADE_FINISHED"}

		userQuery := []string{"user_status = ?", "delete_at = ?"}
		userQueryArgs := []interface{}{1, 0}

		var dashboard dashboardCard

		year, month, day := time.Now().Date()

		startTime := time.Date(year, month, day, 0, 0, 0, 0, time.Local)
		endTime := time.Date(year, month, day, 23, 59, 59, 0, time.Local)

		if v == "yesterday" {
			startTime = startTime.AddDate(0, 0, -1)
			endTime = endTime.AddDate(0, 0, -1)
		}

		if v == "week" {
			startTime = startTime.AddDate(0, 0, -7)
			endTime = endTime.AddDate(0, 0, -7)
		}

		startUnix := startTime.Unix()
		endUnix := endTime.Unix()

		actuallyQuery = append(actuallyQuery, "gmt_payment between ? AND ?")
		actuallyQueryArgs = append(actuallyQueryArgs, startUnix, endUnix)

		salesQuery = append(salesQuery, "create_at between ? AND ?")
		salesQueryArgs = append(salesQueryArgs, startUnix, endUnix)

		userQuery = append(userQuery, "create_at between ? AND ?")
		userQueryArgs = append(userQueryArgs, startUnix, endUnix)

		queryStr := strings.Join(actuallyQuery, " AND ")

		/*
			actually_amount 今日实收金额
			payLog 查询支付日志
		*/
		tx := cmf.NewDb().Model(&model.PayLog{}).Select("sum(receipt_amount) as actually_amount").Where(queryStr, actuallyQueryArgs...).Scan(&dashboard)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		/*
			sales_amount 今日营业额
			订单营业额(堂食+外卖) + 会员订单 + 充值订单
		*/
		queryStr = strings.Join(salesQuery, " AND ")
		tx = cmf.NewDb().Debug().Model(&resModel.FoodOrder{}).Select("sum(fee) as food_order_amount").Where(queryStr, salesQueryArgs...).Scan(&dashboard)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		tx = cmf.NewDb().Model(&resModel.MemberCardOrder{}).Select("sum(fee) as member_amount").Where(queryStr, salesQueryArgs...).Scan(&dashboard)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		tx = cmf.NewDb().Model(&resModel.RechargeOrder{}).Select("sum(fee) as recharge_amount").Where(queryStr, salesQueryArgs...).Scan(&dashboard)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		dashboard.SalesAmount = dashboard.FoodOrderAmount + dashboard.MemberAmount + dashboard.RechargeAmount

		/*
			total_orders 今日订单数
			订单数(堂食+外卖) + 会员订单 + 充值订单
		*/

		tx = cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&resModel.FoodOrder{}).Count(&dashboard.FoodOrderCount)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		tx = cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&resModel.MemberCardOrder{}).Count(&dashboard.MemberCount)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		tx = cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&resModel.RechargeOrder{}).Count(&dashboard.RechargeCount)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		dashboard.OrderCount = dashboard.FoodOrderCount + dashboard.MemberCount + dashboard.RechargeCount
		/*
			new_members 今日新增会员数
			会员数
		*/
		userQueryStr := strings.Join(userQuery, " AND ")
		var user []resModel.User
		tx = cmf.NewDb().Where(userQueryStr, userQueryArgs...).Find(&user).Count(&dashboard.NewMembersCount)
		if tx.Error != nil {
			rest.rc.Error(c, tx.Error.Error(), nil)
			return
		}

		if v == "today" {
			{
				dashboardResult.Today = dashboard
			}
		}

		if v == "yesterday" {
			{
				dashboardResult.Yesterday = dashboard
			}
		}

		if v == "week" {
			{
				dashboardResult.Week = dashboard
			}
		}

	}

	decimal.DivisionPrecision = 2

	// 日同比
	var dayActuallyGrowth float64
	if dashboardResult.Yesterday.ActuallyAmount == 0 {
		dayActuallyGrowth = 0
	} else {
		dayActuallyGrowth, _ = decimal.NewFromFloat(dashboardResult.Today.ActuallyAmount - dashboardResult.Yesterday.ActuallyAmount).Div(decimal.NewFromFloat(dashboardResult.Yesterday.ActuallyAmount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.DayActuallyGrowth = dayActuallyGrowth

	/*---------------------------------------------------*/

	var daySalesGrowth float64
	if dashboardResult.Yesterday.SalesAmount == 0 {
		daySalesGrowth = 0
	} else {
		daySalesGrowth, _ = decimal.NewFromFloat(dashboardResult.Today.SalesAmount - dashboardResult.Yesterday.SalesAmount).Div(decimal.NewFromFloat(dashboardResult.Yesterday.SalesAmount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}
	dashboardResult.DaySalesGrowth = daySalesGrowth

	/*--------------------------------------------------*/

	var dayOrderCountGrowth float64
	if dashboardResult.Yesterday.FoodOrderCount == 0 {
		dayOrderCountGrowth = 0
	} else {
		dayOrderCountGrowth, _ = decimal.NewFromInt(dashboardResult.Today.FoodOrderCount - dashboardResult.Yesterday.FoodOrderCount).Div(decimal.NewFromInt(dashboardResult.Yesterday.FoodOrderCount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}
	dashboardResult.DayOrderCountGrowth = dayOrderCountGrowth

	/*--------------------------------------------------*/

	var dayNewMembersCountGrowth float64
	if dashboardResult.Yesterday.NewMembersCount == 0 {
		dayNewMembersCountGrowth = 0
	} else {
		dayNewMembersCountGrowth, _ = decimal.NewFromInt(dashboardResult.Today.NewMembersCount - dashboardResult.Yesterday.NewMembersCount).Div(decimal.NewFromInt(dashboardResult.Yesterday.NewMembersCount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.DayNewMembersCountGrowth = dayNewMembersCountGrowth

	/*--------------------------------------------------*/

	// 周同比
	var weekActuallyGrowth float64
	if dashboardResult.Week.ActuallyAmount == 0 {
		weekActuallyGrowth = 0
	} else {
		weekActuallyGrowth, _ = decimal.NewFromFloat(dashboardResult.Today.ActuallyAmount - dashboardResult.Week.ActuallyAmount).Div(decimal.NewFromFloat(dashboardResult.Week.ActuallyAmount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.WeekActuallyGrowth = weekActuallyGrowth
	/*---------------------------------------------------*/

	var weekSalesGrowth float64
	if dashboardResult.Week.SalesAmount == 0 {
		weekSalesGrowth = 0
	} else {
		weekSalesGrowth, _ = decimal.NewFromFloat(dashboardResult.Today.SalesAmount - dashboardResult.Week.SalesAmount).Div(decimal.NewFromFloat(dashboardResult.Week.SalesAmount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.WeekSalesGrowth = weekSalesGrowth

	/*--------------------------------------------------*/

	var weekOrderCountGrowth float64
	if dashboardResult.Week.OrderCount == 0 {
		weekOrderCountGrowth = 0
	} else {
		weekOrderCountGrowth, _ = decimal.NewFromInt(dashboardResult.Today.OrderCount - dashboardResult.Week.OrderCount).Div(decimal.NewFromInt(dashboardResult.Week.OrderCount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.WeekOrderCountGrowth = weekOrderCountGrowth

	/*--------------------------------------------------*/

	var weekNewMembersCountGrowth float64
	if dashboardResult.Week.NewMembersCount == 0 {
		weekNewMembersCountGrowth = 0
	} else {
		weekNewMembersCountGrowth, _ = decimal.NewFromInt(dashboardResult.Today.NewMembersCount - dashboardResult.Week.NewMembersCount).Div(decimal.NewFromInt(dashboardResult.Week.NewMembersCount)).Mul(decimal.NewFromInt(100)).Round(2).Float64()
	}

	dashboardResult.WeekNewMembersCountGrowth = weekNewMembersCountGrowth

	rest.rc.Success(c, "获取成功！", dashboardResult)

}

// 获取分析看板
func (rest *Dashboard) DashboardSales(c *gin.Context) {

	tQuery := c.Query("filter")
	if tQuery == "" {
		rest.rc.Error(c, "筛选条件不能为空！", nil)
		return
	}

	var analysis dashboardAnalysis

	// 查询几天全部订单
	salesQuery := []string{"(order_status = ? OR order_status = ?)"}
	salesQueryArgs := []interface{}{"TRADE_SUCCESS", "TRADE_FINISHED"}

	startTimeStamp := time.Date(time.Now().Year(), time.Now().Month(), time.Now().Day(), 00, 00, 00, 0, time.Local)
	endTimeStamp := time.Date(time.Now().Year(), time.Now().Month(), time.Now().Day(), 23, 59, 59, 0, time.Local)

	// 7天内
	beforeStartStamp := startTimeStamp.AddDate(0, 0, -7)
	beforeEndStamp := endTimeStamp.AddDate(0, 0, -7)

	// 30天内
	if tQuery == "30d" {
		beforeStartStamp = startTimeStamp.AddDate(0, -1, 0)
		beforeEndStamp = endTimeStamp.AddDate(0, -1, 0)
	}

	// 3个月内
	if tQuery == "3m" {
		beforeStartStamp = startTimeStamp.AddDate(0, -3, 0)
		beforeEndStamp = endTimeStamp.AddDate(0, -3, 0)
	}

	// 1年内
	if tQuery == "1y" {
		yearStartTime := time.Date(time.Now().Year(), time.Now().Month(), 1, 00, 00, 00, 0, time.Local)
		beforeStartStamp = yearStartTime.AddDate(-1, 0, 0)
		beforeEndStamp = endTimeStamp.AddDate(-1, 0, 0)
	}

	salesQuery = append(salesQuery, "finished_at between ? AND ?")
	salesQueryArgs = append(salesQueryArgs, beforeStartStamp.Unix(), endTimeStamp.Unix())

	/*
		sales_amount 今日营业额
		订单营业额(堂食+外卖) + 会员订单 + 充值订单
	*/
	queryStr := strings.Join(salesQuery, " AND ")

	var (
		fo  []resModel.FoodOrder
		mco []resModel.MemberCardOrder
		ro  []resModel.RechargeOrder
	)

	tx := cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&fo)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	tx = cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&mco)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	tx = cmf.NewDb().Where(queryStr, salesQueryArgs...).Find(&ro)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	tInt := 0
	switch tQuery {
	case "7d":
		tInt = 7
	case "30d":
		tInt = util.MonthCount(time.Now().Year(), int(time.Now().Month()-1))
	case "3m":
		tInt = 14
	case "1y":
		tInt = 12
	}

	labelMap := make([]data, 0)

	dur := startTimeStamp.Sub(beforeStartStamp).Hours()

	durDay := math.Floor(dur / 24 / float64(tInt))

	if tQuery == "3m" || tQuery == "1y" {
		tInt += 1
	}

	for i := 0; i < tInt; i++ {

		nextDay := int(durDay) * i

		if tQuery == "3m" && i > 0 {
			nextDay += 1
		}

		beforeDate := beforeStartStamp.AddDate(0, 0, nextDay)
		label := beforeDate.Format("2006-01-02")

		endLabel := ""
		if tQuery == "3m" {
			if i > 0 {
				nextDay -= 1
			}
			endLabel = beforeStartStamp.AddDate(0, 0, nextDay+int(durDay)).Format("2006-01-02")
		}

		startUnix := beforeStartStamp.AddDate(0, 0, i).Unix()
		endUnix := beforeEndStamp.AddDate(0, 0, i).Unix()

		if tQuery == "1y" {

			beforeEndDate := beforeEndStamp.AddDate(0, i, 0)
			startUnix = beforeStartStamp.AddDate(0, i, 0).Unix()
			beforeEndDate = time.Date(beforeEndDate.Year(), beforeEndDate.Month(), util.MonthCount(beforeEndDate.Year(), int(beforeEndDate.Month())), 23, 59, 59, 0, time.Local)
			endUnix = beforeEndDate.Unix()
		}

		// 最后
		if tInt == i+1 {
			if beforeStartStamp.AddDate(0, 0, nextDay+int(durDay)).Unix() < startTimeStamp.AddDate(0, 0, -1).Unix() || beforeStartStamp.AddDate(0, 0, nextDay+int(durDay)).Unix() > startTimeStamp.AddDate(0, 0, -1).Unix() {
				endLabel = startTimeStamp.AddDate(0, 0, -1).Format("2006-01-02")
				endUnix = endTimeStamp.AddDate(0, 0, -1).Unix()
			}
		}

		if tQuery == "3m" {
			label += "~" + endLabel
		}

		if tQuery == "1y" {
			label = beforeDate.Format("2006-01")
		}

		var salesAmount float64 = 0

		// 菜品订单
		for _, v := range fo {
			if v.FinishedAt >= startUnix && v.FinishedAt <= endUnix {
				salesAmount += v.Fee
			}
		}

		// 会员订单
		for _, v := range mco {
			if v.FinishedAt >= startUnix && v.FinishedAt <= endUnix {
				salesAmount += v.Fee
			}
		}

		// 储值订单
		for _, v := range ro {
			if v.FinishedAt >= startUnix && v.FinishedAt <= endUnix {
				salesAmount += v.Fee
			}
		}

		labelMap = append(labelMap, data{
			Label: label,
			Value: salesAmount,
		})
	}

	analysis.SalesAnalysis = labelMap

	// 门店销售额统计
	var store []resModel.Store
	tx = cmf.NewDb().Where("delete_at = ?", 0).Find(&store)
	if tx.Error != nil {
		fmt.Println(tx.Error)
		return
	}

	// 查询门店销售额
	var tempSalesRanking = make([]storeSalesRanking, 0)
	for _, v := range store {

		var salesAmount float64

		salesQuery = append(salesQuery, "store_id = ?")
		salesQueryArgs = append(salesQueryArgs, v.Id)

		queryStr := strings.Join(salesQuery, " AND ")

		row := cmf.NewDb().Model(&resModel.FoodOrder{}).Select("sum(fee) as salesAmount").Where(queryStr, salesQueryArgs...).Row()

		tx := row.Scan(&salesAmount)
		if tx != nil {
		}

		tempSalesRanking = append(tempSalesRanking, storeSalesRanking{
			StoreName:   v.StoreName,
			SalesAmount: salesAmount,
		})
	}

	storeSalesRanking := rest.recursionStoreRanking(tempSalesRanking, 0)

	analysis.StoreSalesRanking = storeSalesRanking

	rest.rc.Success(c, "获取成功！", analysis)

}

func (rest *Dashboard) recursionStoreRanking(sr []storeSalesRanking, start float64) (resultSales []storeSalesRanking) {

	var tem []storeSalesRanking
	var key *int
	var storeName string = ""

	for k, v := range sr {
		if k == 0 || v.SalesAmount <= start {
			storeName = v.StoreName
			start = v.SalesAmount
			temp := k
			key = &temp
		}
	}

	for k, v := range sr {
		if key != nil && *key != k {
			tem = append(tem, storeSalesRanking{
				StoreName:   v.StoreName,
				SalesAmount: v.SalesAmount,
			})
		}
	}

	if storeName != "" {
		resultSales = append(resultSales, storeSalesRanking{
			StoreName:   storeName,
			SalesAmount: start,
		})
	}

	if len(tem) > 0 {
		rs := rest.recursionStoreRanking(tem, start)
		resultSales = append(resultSales, rs...)
	}

	return
}
