module gincmf

go 1.14

require (
	github.com/360EntSecGroup-Skylar/excelize/v2 v2.3.1
	github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751
	github.com/aliyun/alibaba-cloud-sdk-go v1.61.991
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/gin-contrib/sessions v0.0.3
	github.com/gin-gonic/gin v1.6.3
	github.com/gincmf/alipayEasySdk v0.0.1
	github.com/gincmf/cmf v0.0.6
	github.com/gincmf/feieSdk v0.0.1
	github.com/go-openapi/spec v0.20.0 // indirect
	github.com/go-playground/validator/v10 v10.4.1 // indirect
	github.com/go-redis/redis v6.15.9+incompatible
	github.com/golang/protobuf v1.4.3 // indirect
	github.com/google/uuid v1.2.0 // indirect
	github.com/gorilla/sessions v1.2.1 // indirect
	github.com/gorilla/websocket v1.4.2
	github.com/json-iterator/go v1.1.10 // indirect
	github.com/makiuchi-d/gozxing v0.0.0-20210324052758-57132e828831
	github.com/maruel/rs v1.0.0 // indirect
	github.com/nfnt/resize v0.0.0-20180221191011-83c6a9932646
	github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d
	github.com/pjebs/optimus-go v1.0.0
	github.com/shopspring/decimal v1.2.0
	github.com/skip2/go-qrcode v0.0.0-20200617195104-da1b6568686e
	github.com/swaggo/gin-swagger v1.3.0 // indirect
	github.com/swaggo/swag v1.7.0
	github.com/tidwall/buntdb v1.1.4 // indirect
	golang.org/x/crypto v0.0.0-20201016220609-9e8e0b390897 // indirect
	golang.org/x/net v0.0.0-20201216054612-986b41b23924 // indirect
	golang.org/x/oauth2 v0.0.0-20200902213428-5d25da1a8d43
	golang.org/x/tools v0.0.0-20201215192005-fa10ef0b8743 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	gopkg.in/oauth2.v3 v3.12.0
	gorm.io/driver/mysql v1.0.3 // indirect
	gorm.io/gorm v1.20.9
)

replace github.com/gincmf/cmf v0.0.6 => ../cmf

replace github.com/gincmf/alipayEasySdk v0.0.1 => ../alipay-easysdk-go

replace github.com/gincmf/feieSdk v0.0.1 => ../feie-sdk
