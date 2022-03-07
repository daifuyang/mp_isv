/**
** @创建时间: 2021/8/1 7:28 上午
** @作者　　: return
** @描述　　:
 */
package util

import (
	"errors"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"gorm.io/gorm"
)

func NewDb(c *gin.Context) (*gorm.DB, error) {

	db, exist := c.Get("DB")
	if !exist {
		return nil, errors.New("数据库索引指定不存在！")
	}

	dbName := db.(string)

	return cmf.ManualDb(dbName), nil
}
