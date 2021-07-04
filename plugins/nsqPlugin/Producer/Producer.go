/**
** @创建时间: 2021/6/30 9:23 下午
** @作者　　: return
** @描述　　:
 */
package Producer

import (
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/nsqio/go-nsq"
)

type Producer struct {
}

type MessageJson struct {
	Database    string `json:"database"`
	Type        string `json:"type"`
	TargetId    int    `json:"target_id"`
	Description string `json:"description"`
	Mid         int    `json:"mid"`
}

var producer *nsq.Producer

func (rest *Producer) NewProducer() (*nsq.Producer, error) {

	if producer == nil {
		nsqIp := cmf.Conf().App.NsqIp
		if nsqIp == "" {
			nsqIp = "192.168.1.1"
		}

		nsqdPort := cmf.Conf().App.NsqdPort

		if nsqdPort == "" {
			nsqdPort = "4150"
		}

		addr := nsqIp + ":" + nsqdPort

		var err error

		producer, err = nsq.NewProducer(addr, nsq.NewConfig())
		if err != nil {
			return nil, err
		}
		err = producer.Ping()
		if nil != err {
			// 关闭生产者
			producer.Stop()
			producer = nil
			return nil, err
		}
	}

	return producer, nil

}
