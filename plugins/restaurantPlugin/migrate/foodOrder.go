/**
** @创建时间: 2021/3/29 9:47 下午
** @作者　　: return
** @描述　　:
 */
package migrate

import (
	"gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
)

type FoodOrder struct {
	Id              int     `json:"id"`
	Mid             int     `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	OrderId         string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	TradeNo         string  `gorm:"type:varchar(60);comment:支付宝订单号;not null" json:"trade_no"`
	QueueNo         string  `gorm:"type:varchar(10);comment:取餐队列号;not null" json:"queue_no"`
	PayType         string  `gorm:"type:varchar(10);comment:第三方支付类型;not null" json:"pay_type"`
	StoreId         int     `gorm:"type:int(11);comment:所属门店id;not null" json:"store_id"`
	OrderType       int     `gorm:"type:tinyint(3);comment:订单类型（1 => 门店扫码就餐; 2 => 门店堂食就餐; 3 => 门店打包外带; 4 => 外卖;not null" json:"order_type"`
	AppointmentAt   int     `gorm:"type:bigint(20);comment:预约取餐时间" json:"appointment_at"`
	AppointmentType int64   `gorm:"type:tinyint(3);comment:是否预约单;default:0" json:"appointment_type"`
	OrderDetail     string  `gorm:"type:json;comment:订单详情;not null" json:"order_detail"`
	BoxFee          float64 `gorm:"type:decimal(3,2);comment:餐盒费;default:0;not null" json:"box_fee"`
	DeliveryFee     float64 `gorm:"type:decimal(3,2);comment:配送费;default:0;not null" json:"delivery_fee"`
	CouponFee       float64 `gorm:"type:decimal(7,2);comment:优惠金额;default:0;not null" json:"coupon_fee"`
	VoucherId       int     `gorm:"type:int(11);comment:优惠券id" json:"voucher_id"`
	Remark          string  `gorm:"type:varchar(255);comment:备注" json:"remark"`
	Fee             float64 `gorm:"type:decimal(7,2);comment:合计金额;default:0;not null" json:"fee"`
	OriginalFee     float64 `gorm:"type:decimal(7,2);comment:原价金额;default:0;not null" json:"original_fee"`
	DeskId          int     `gorm:"type:int(11);comment:桌号id" json:"desk_id"`
	DeskName        string  `gorm:"type:varchar(40);comment:桌位名称详情" json:"desk_name"`
	UserId          int     `gorm:"type:bigint(20);comment:下单人信息" json:"user_id"`
	Name            string  `gorm:"type:varchar(20);comment:用户预留姓名" json:"name"`
	Mobile          string  `gorm:"type:varchar(11);comment:用户预留手机号;not null" json:"mobile"`
	Address         string  `gorm:"type:varchar(255);comment:用户预留收货地址" json:"address"`
	AddressId       int     `gorm:"type:int(11);comment:选择地址id" json:"address_id"`
	CreateAt        int64   `gorm:"type:bigint(20)" json:"create_at"`
	FinishedAt      int64   `gorm:"type:int(11)" json:"finished_at"`
	OrderStatus     string  `gorm:"type:varchar(20);comment:订单状态（WAIT_BUYER_PAY => 待支付，TRADE_SUCCESS => 待使用/已支付，TRADE_FINISHED=> 已完成，TRADE_REFUSED => 已拒绝，TRADE_CLOSED => 已关闭，TRADE_REFUND=>已退款）;default:WAIT_BUYER_PAY;not null" json:"order_status"`
	DeliveryStatus  string  `gorm:"type:varchar(20);comment:运输状态（TRADE_RECEIVED => 已接单，TRADE_DELIVERY => 运输中" json:"delivery_status"`
	FormId          string  `gorm:"type:varchar(64);comment:支付宝推送formId;not null" json:"form_id"`
	RefundFee       float64 `gorm:"type:decimal(7,2);comment:剩余可退金额;default:0;not null" json:"refund_fee"`
}

// 定单明细表
type FoodOrderDetail struct {
	Id               int     `json:"id"`
	Code             string  `gorm:"type:varchar(32);comment:菜品唯一编号;not null" json:"code"`
	OrderId          string  `gorm:"type:varchar(40);comment:订单号;not null" json:"order_id"`
	FoodId           int     `gorm:"type:int(11);comment:所属食物id;not null" json:"food_id"`
	FoodThumbnail    string  `gorm:"type:varchar(255);comment:菜品缩略图;not null" json:"food_thumbnail"`
	AlipayMaterialId string  `gorm:"type:varchar(256);comment:阿里素材标识;not null" json:"alipay_material_id"`
	FoodName         string  `gorm:"type:varchar(255);comment:菜品名称;not null" json:"food_name"`
	SkuId            int     `gorm:"type:int(11);comment:所属食物规格id;not null" json:"sku_id"`
	SkuDetail        string  `gorm:"type:varchar(255);comment:规格详情;not null" json:"sku_detail"`
	FoodRemark       string  `gorm:"type:varchar(255);comment:最终拼接详情;not null" json:"food_remark"`
	UseMember        int     `gorm:"type:tinyint(3);comment:是否启用菜品会员价;not null" json:"use_member"`
	MemberPrice      float64 `gorm:"type:decimal(9,2);comment:菜品会员价;not null" json:"member_price"`
	Count            int     `gorm:"type:int(11);comment:购买数量;not null" json:"count"`
	Material         string  `gorm:"type:json;comment:加料;not null" json:"material"`
	Tasty            string  `gorm:"type:json;comment:口味;not null" json:"tasty"`
	DishType         string  `gorm:"type:varchar(40);comment:菜品类型;" json:"dish_type"`
	Flavor           string  `gorm:"type:varchar(40);comment:菜品口味;" json:"flavor"`
	CookingMethod    string  `gorm:"type:varchar(40);comment:菜品做法;" json:"cooking_method"`
	Price            float64 `gorm:"type:decimal(9,2);comment:菜品单价;not null" json:"price"`
	Total            float64 `gorm:"type:decimal(9,2);comment:菜品总价;not null" json:"total"`
	BoxFee           float64 `gorm:"type:decimal(9,2);comment:餐盒费;not null" json:"box_fee"`
}

func (migrate *FoodOrder) AutoMigrate() {
	cmf.NewDb().AutoMigrate(&migrate)
	cmf.NewDb().AutoMigrate(&model.FoodOrderRefund{})
	cmf.NewDb().AutoMigrate(&FoodOrderDetail{})

	prefix := cmf.Conf().Database.Prefix

	cmf.NewDb().Exec("drop event if exists orderCloseStatus")
	cmf.NewDb().Exec("drop event if exists orderFinishStatus")

	// 超时未支付和订单自动完成
	sql := "CREATE EVENT orderCloseStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "food_order SET order_status = 'TRADE_CLOSED' WHERE order_status = 'WAIT_BUYER_PAY' AND UNIX_TIMESTAMP(NOW()) > create_at + 600;"
	cmf.NewDb().Exec(sql)

	sql = "CREATE EVENT orderFinishStatus ON SCHEDULE EVERY 1 SECOND DO " +
		"UPDATE " + prefix + "food_order SET order_status = 'TRADE_FINISHED',finished_at = UNIX_TIMESTAMP( NOW() ) WHERE order_status = 'TRADE_SUCCESS' AND UNIX_TIMESTAMP(NOW()) > appointment_at + 43200;"
	cmf.NewDb().Exec(sql)

	cmf.NewDb().Exec("UPDATE cmf_food_order SET refund_fee = fee WHERE refund_fee = 0 AND (order_status !=  'TRADE_CLOSED'' OR order_status != 'TRADE_CLOSED')")

}
