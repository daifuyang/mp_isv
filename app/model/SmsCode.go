/**
** @创建时间: 2020/9/30 3:30 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"errors"
	"fmt"
	"github.com/aliyun/alibaba-cloud-sdk-go/services/dysmsapi"
	"math/rand"
	"strconv"
	"time"
)

type smsCode struct {
	Phone  int    `json:"phone"`
	Code   string `json:"-"`
	Expire int64  `json:"expire"`
}

type Scene struct {
	Action string `json:"action"`
	Phone  int    `json:"phone"`
}

var SmsCodeArr map[Scene]*smsCode

func GetSmsCode(s Scene) (*smsCode, error) {

	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	code := fmt.Sprintf("%04v", rnd.Int31n(10000))

	if SmsCodeArr == nil {
		SmsCodeArr = make(map[Scene]*smsCode, 0)
	}

	if SmsCodeArr[s] != nil && SmsCodeArr[s].Expire > time.Now().Unix() {
		return nil, errors.New("获取验证码过于频繁！请先验证上一次验证码！")
	}

	client, err := dysmsapi.NewClientWithAccessKey("cn-hangzhou", "LTAIdhy1wQAGInuq", "rgr8uUn0ycorRAm79aBvK2B31pZBBd")
	request := dysmsapi.CreateSendSmsRequest()
	phone := strconv.Itoa(s.Phone)
	request.PhoneNumbers = phone
	request.Scheme = "https"
	request.SignName = "码上云"
	request.TemplateCode = "SMS_203678233"
	request.TemplateParam = `{"code":"` + code + `"}`
	response, err := client.SendSms(request)
	if err != nil {
		return nil, errors.New(err.Error())
	}
	fmt.Println("response", response)

	SmsCodeArr[s] = &smsCode{
		Phone:  s.Phone,
		Code:   code,
		Expire: time.Now().Unix() + 60*2,
	}

	return SmsCodeArr[s], nil
}

func ValidateSms(s Scene, code string) error {
	smsArr := SmsCodeArr[s]

	fmt.Println("smsArr", smsArr)

	if smsArr == nil {
		return errors.New("请先获取短信验证码！")
	}

	if smsArr.Expire < time.Now().Unix() {
		return errors.New("该短信验证码已经失效！请重新获取")
	}

	smsCode := code
	if smsCode == "" {
		return errors.New("短信验证码不能为空！")
	}

	if smsArr.Code != smsCode {
		return errors.New("短信验证码验证出错！请检查您的验证码是否正确")
	}

	delete(SmsCodeArr, s)

	return nil
}
