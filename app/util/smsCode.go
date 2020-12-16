/**
** @创建时间: 2020/9/30 3:29 下午
** @作者　　: return
** @描述　　:
 */
package util

import (
	"errors"
	"fmt"
	"gincmf/app/model"
	"math/rand"
	"time"
)

var SmsCodeArr map[int]*model.SmsCode

func SmsCode(mobile int) (*model.SmsCode, error) {

	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	smsCode := fmt.Sprintf("%04v", rnd.Int31n(10000))

	if SmsCodeArr == nil {
		SmsCodeArr = make(map[int]*model.SmsCode, 0)
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

	SmsCodeArr[mobile] = &model.SmsCode{
		Phone:  mobile,
		Code:   smsCode,
		Expire: time.Now().Unix() + 60*2,
	}

	return SmsCodeArr[mobile], nil
}
