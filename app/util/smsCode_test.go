/**
** @创建时间: 2020/9/30 3:35 下午
** @作者　　: return
** @描述　　:
 */
package util

import (
	"fmt"
	"math/rand"
	"testing"
	"time"
)

func TestSmsCode(t *testing.T) {
	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	smsCode := fmt.Sprintf("%04v", rnd.Int31n(10000))

	fmt.Println("smsCode", smsCode)
	return

	if SmsCodeArr == nil {
		SmsCodeArr = make(map[int]*smsCode, 0)
	}

	SmsCodeArr[15161178722] = &smsCode{
		Phone:  15161178722,
		Code:   smsCode,
		Expire: time.Now().Unix() + 60*5,
	}

	fmt.Println(*SmsCodeArr[15161178722])
}
