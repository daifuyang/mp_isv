/**
** @创建时间: 2020/9/30 3:29 下午
** @作者　　: return
** @描述　　:
 */
package util

import (
	"errors"
	"fmt"
	"math/rand"
	"time"
)

type smsCode struct {
	Phone  int
	Code   string
	Expire int64
}

var SmsCodeArr map[int]*smsCode

func SmsCode(mobile int) (*smsCode, error) {

	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	code := fmt.Sprintf("%04v", rnd.Int31n(10000))

	if SmsCodeArr == nil {
		SmsCodeArr = make(map[int]*smsCode, 0)
	}

	if SmsCodeArr[mobile] != nil && SmsCodeArr[mobile].Expire > time.Now().Unix() {
		return nil, errors.New("获取验证码过于频繁！请先验证上一次验证码！")
	}

	//client, err := dysmsapi.NewClientWithAccessKey("cn-hangzhou", "LTAIdhy1wQAGInuq", "rgr8uUn0ycorRAm79aBvK2B31pZBBd")
	//request := dysmsapi.CreateSendSmsRequest()
	//phone := strconv.Itoa(mobile)
	//request.PhoneNumbers = phone
	//request.Scheme = "https"
	//request.SignName = "码上云"
	//request.TemplateCode = "SMS_203678233"
	//request.TemplateParam = `{"code":"`+smsCode+`"}`
	//response, err := client.SendSms(request)
	//if err != nil {
	//	return nil,errors.New(err.Error())
	//}
	//fmt.Println("response",response)

	SmsCodeArr[mobile] = &smsCode{
		Phone:  mobile,
		Code:   code,
		Expire: time.Now().Unix() + 60*2,
	}

	return SmsCodeArr[mobile], nil
}

func ValidateSms(mobile int, code string) error {
	smsArr := SmsCodeArr[mobile]
	if smsArr == nil {
		return errors.New("请先获取短信验证码！")
	}

	if smsArr.Expire < time.Now().Unix() {
		return errors.New("该短信验证码已经失效！请重新获取")
	}

	if code == "" {
		return errors.New("短信验证码不能为空！")
	}

	if smsArr.Code != code {
		return errors.New("短信验证码验证出错！请检查您的验证码是否正确")
	}

	delete(SmsCodeArr, mobile)

	return nil
}
