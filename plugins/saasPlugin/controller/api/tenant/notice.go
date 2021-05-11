/**
** @创建时间: 2021/3/15 6:14 下午
** @作者　　: return
** @描述　　:
 */
package tenant

import (
	"encoding/json"
	"errors"
	saasModel "gincmf/plugins/saasPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/cmfWebsocket"
	"github.com/gincmf/cmf/controller"
	cmfLog "github.com/gincmf/cmf/log"
	"gorm.io/gorm"
	"strconv"
	"time"
)

type Notice struct {
	rc controller.Rest
}

func (rest *Notice) Get(c *gin.Context) {

	mid, _ := c.Get("mid")
	notice := saasModel.AdminNotice{
		Mid: mid.(int),
	}
	noticeData, err := notice.Index(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", noticeData)

}

func (rest *Notice) Show(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	notice := saasModel.AdminNotice{
		Mid: mid.(int),
	}
	tx := cmf.NewDb().Where("id = ?", rewrite.Id).First(&notice)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该通知不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	notice.Status = 1
	tx = cmf.NewDb().Save(&notice)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "已读成功！", notice)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 全部已读
 * @Date 2021/4/9 11:11:41
 * @Param
 * @return
 **/
func (rest *Notice) ReadAll(c *gin.Context) {

	notice := saasModel.AdminNotice{}

	notice.Status = 1
	tx := cmf.NewDb().Session(&gorm.Session{AllowGlobalUpdate: true}).Updates(&notice)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "已读全部成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 标记已经播放
 * @Date 2021/4/9 11:12:2
 * @Param
 * @return
 **/
func (rest *Notice) IsPlay (c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	mid, _ := c.Get("mid")
	notice := saasModel.AdminNotice{
		Mid: mid.(int),
	}
	tx := cmf.NewDb().Where("id = ?", rewrite.Id).First(&notice)
	if tx.Error != nil {
		if errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "该通知不存在！", nil)
			return
		}
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	notice.IsPlay = 1
	tx = cmf.NewDb().Save(&notice)
	if tx.Error != nil {
		rest.rc.Error(c, tx.Error.Error(), nil)
		return
	}

	rest.rc.Success(c, "播放成功！", notice)

}

func (rest Notice) SocketGet(c *gin.Context) {

	var (
		conn  *cmfWebsocket.Connection
		err   error
		first = true
	)

	userId, _ := c.Get("user_id")
	userIdInt := userId.(int)
	userIdStr := strconv.Itoa(userIdInt)

	// 获取租户信息
	tenantId, _ := c.Get("tenant_id")
	tenantIdInt := tenantId.(int)
	tenantIdStr := strconv.Itoa(tenantIdInt)

	mid, _ := c.Get("mid")

	conn = new(cmfWebsocket.Client).GetClient(userIdStr).Conn

	for {
		// 查询当前用户订单
		notice := saasModel.AdminNotice{}
		tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").First(&notice)
		if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
			cmfLog.Error(tx.Error.Error())
			conn.Error(err.Error(), nil)
			return
		}

		// 读取redis是否是最新的订单
		eatInKey := "mp_isv:" + tenantIdStr + ":latest_notice"
		latestNotice, _ := cmf.NewRedisDb().Get(eatInKey).Result()
		latestNoticeInt, _ := strconv.Atoi(latestNotice)

		if latestNoticeInt < notice.Id || first {

			if latestNotice == "" || latestNoticeInt < notice.Id {
				cmf.NewRedisDb().Set(eatInKey, notice.Id, 0)
			}

			var noticeMap []saasModel.AdminNotice
			tx := cmf.NewDb().Where("mid = ?", mid).Order("id desc").Limit(10).Find(&noticeMap)
			if tx.Error != nil && !errors.Is(tx.Error, gorm.ErrRecordNotFound) {
				conn.Error(err.Error(), nil)
				return
			}

			result, _ := json.Marshal(&noticeMap)
			if err = conn.Success("获取成功！", string(result)); err != nil {
				new(cmfWebsocket.Client).DelClient(userIdStr)
			}
			first = false
		}

		time.Sleep(time.Second * 5)

	}

}
