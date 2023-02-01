# 阿里门店配送关系

## 数据库关系

通过门店和支付宝物流平台的关联关系
```
// 配送商家门店关联信息
type ImmediateDeliveryPost struct {
	Id         int      `json:"id"`
	OutBizNo   string   `gorm:"type:string(32);comment:外部业务编号" json:"out_biz_no"`
	DeliveryId string   `gorm:"type:varchar(20);comment:配送公司id" json:"delivery_id"`
	Channel    string   `gorm:"type:varchar(20);comment:渠道" json:"channel"`
	StoreId    int      `gorm:"type:int(11);comment:门店id;not null;comment:门店id" json:"store_id"`
	Status     string   `gorm:"type:varchar(32);comment:状态" json:"status"`
	AuditDesc  string   `gorm:"type:varchar(32);comment:审核说明" json:"audit_desc"`
	Db         *gorm.DB `gorm:"-" json:"-"`
}
```


