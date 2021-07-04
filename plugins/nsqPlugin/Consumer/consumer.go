/**
** @创建时间: 2020/10/29 4:29 下午
** @作者　　: return
** @描述　　: 插件名采用大驼峰命名法，都带 Plugin类名后缀，如 DemoPlugin,CustomAdminLoginPlugin
 */
package Consumer

import (
	"encoding/json"
	"fmt"
	"gincmf/plugins/nsqPlugin/Producer"
	resModel "gincmf/plugins/restaurantPlugin/model"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/nsqio/go-nsq"
	"time"
)

type Nsq struct{}


// 消费者
type ConsumerT struct{}

// 主函数
func (rest *Nsq) Init() {
	nsqIp := cmf.Conf().App.NsqIp
	if nsqIp == "" {
		nsqIp = "192.168.1.1"
	}

	nsqaPort := cmf.Conf().App.NsqaPort

	if nsqaPort == "" {
		nsqaPort = "4161"
	}

	addr := nsqIp + ":" + nsqaPort
	fmt.Println("nsq listen", addr)
	InitConsumer("mpIsv", "mpIsv-channel", addr)
	for {
		time.Sleep(time.Second * 10)
	}
}

//处理消息
func (*ConsumerT) HandleMessage(msg *nsq.Message) error {

	messageJson := Producer.MessageJson{}
	_ = json.Unmarshal(msg.Body, &messageJson)

	fmt.Println("receive", msg.NSQDAddress, "message:", string(msg.Body))

	if messageJson.Type == "printer" {

		if messageJson.Database == "" {
			return nil
		}

		cmf.ManualDb(messageJson.Database)
		err := new(resModel.Printer).Send(messageJson.Mid, messageJson.TargetId)
		fmt.Println("err", err)
		return err
	}
	return nil
}

//初始化消费者
func InitConsumer(topic string, channel string, address string) {
	cfg := nsq.NewConfig()
	cfg.LookupdPollInterval = time.Second          //设置重连时间
	c, err := nsq.NewConsumer(topic, channel, cfg) // 新建一个消费者
	if err != nil {
		panic(err)
	}

	c.SetLogger(nil, 0)        //屏蔽系统日志
	c.AddHandler(&ConsumerT{}) // 添加消费者接口
	//建立NSQLookupd连接
	if err := c.ConnectToNSQLookupd(address); err != nil {
		fmt.Println("err", err)
	}
	//建立多个nsqd连接
	// if err := c.ConnectToNSQDs([]string{"127.0.0.1:4150", "127.0.0.1:4152"}); err != nil {
	//  panic(err)
	// }
	// 建立一个nsqd连接

	nsqIp := cmf.Conf().App.NsqIp
	if nsqIp == "" {
		nsqIp = "192.168.1.1"
	}

	nsqdPort := cmf.Conf().App.NsqdPort

	if nsqdPort == "" {
		nsqdPort = "4150"
	}

	addr := nsqIp + ":" + nsqdPort

	if err := c.ConnectToNSQD(addr); err != nil {
		fmt.Println("err", err)
	}
}
