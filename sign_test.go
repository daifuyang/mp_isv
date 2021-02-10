/**
** @创建时间: 2020/11/20 6:02 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"crypto"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"fmt"
	"gincmf/app/util"
	easyUtil "github.com/gincmf/alipayEasySdk/util"
	"testing"
)

// 签名测试
func Test_sign(t *testing.T) {
	// 定义参数
	var params = make(map[string]string, 0)
	params["tenant_id"] = "0001"
	params["mp_id"] = "0001"
	params["type"] = "alipay"

	sign,_ := easyUtil.Sign(params)
	fmt.Println("sign", sign)
}

func Test_getSign(t *testing.T) {

	sign, err := base64.StdEncoding.DecodeString("XYwyhy92hYoKZQehKeIzf6UsH6sbVVYW5T+FMZvFHpk38B2NbM4lQb2E5cNAcEWrqOMvyZu8idETfBP4No0TGsY0HlicAgGcEiQQUwNJALbHaf+DwcMmd2rz/s1A7mXH1Y9XB2Whj/OyTlB5lxSj7AvHNaOTq1LP1cGezu0F4s9xC5BempMAPPhoZiRi+0+FhT1Q66awnH6ey0WPyHYGIgSvdoH5wD+L02mti4zqzSKR/JxQ/2+aHRSgTrKA4IgZ4wFPESKL1PdMpJc6+Pm/KfZwbnTdUxYqXhANJQMDuOettHAq51fTwSZZIaaD4wyIEt3jKpjI5pUd/ooNTnvmyg==")
	if err != nil {
		fmt.Println(err.Error())
	}

	block := []byte(`
-----BEGIN PUBLIC KEY-----
***REMOVED***
-----END PUBLIC KEY-----
`)

	blocks, _ := pem.Decode(block)
	pub, err := x509.ParsePKIXPublicKey(blocks.Bytes)
	if err != nil {
		fmt.Println("err", err.Error())
	}

	h := sha256.New()
	h.Write([]byte("mp_id=0001&tenant_id=0001&type=alipay"))

	digest := h.Sum(nil)

	err = rsa.VerifyPKCS1v15(pub.(*rsa.PublicKey), crypto.SHA256, digest, sign)

	if err != nil {
		fmt.Println("err", err)
	}

}

func Test_getDistance(t *testing.T){



	result := util.EarthDistance(31.3200050,121.4848560,31.2244920,121.5411470)

	fmt.Println(result)
}