module gincmf

go 1.14

require (
	github.com/aliyun/alibaba-cloud-sdk-go v1.61.545
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/gin-contrib/sessions v0.0.3
	github.com/gin-gonic/gin v1.6.3
	github.com/gincmf/alipayEasySdk v0.0.1
	github.com/gincmf/cmf v0.0.3
	github.com/go-redis/redis v6.15.9+incompatible // indirect
	github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d
	github.com/pjebs/optimus-go v1.0.0
	github.com/skip2/go-qrcode v0.0.0-20200617195104-da1b6568686e
	github.com/speps/go-hashids v2.0.0+incompatible
	golang.org/x/oauth2 v0.0.0-20190604053449-0f29369cfe45
	gopkg.in/oauth2.v3 v3.12.0
	gorm.io/gorm v1.20.0
)

replace github.com/gincmf/cmf v0.0.3 => ../cmf

replace github.com/gincmf/alipayEasySdk v0.0.1 => ../alipay-easysdk-go
