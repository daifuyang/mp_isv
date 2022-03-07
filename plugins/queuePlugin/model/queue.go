/**
** @创建时间: 2020/11/30 11:02 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/go-redis/redis"
	"strconv"
	"time"
)

// 定义入列的结构体

/*
	所属空间
	入列时间
	失效时间
	任务类型

*/
type Queue struct {
	DbName    string `json:"db_name"`
	CreateAt  int64  `json:"create_at"`
	ExpireAt  int64  `json:"expire_at"`
	QueueType string `json:"queue_type"`
	TargetId  int    `json:"target_id"`
	Key       string `json:"-"`
}

// 增加一条
func (q Queue) Add() error {
	inJson, err := json.Marshal(q)
	if err != nil {
		return err
	}

	delay := q.CreateAt + q.ExpireAt
	// 有序集合，存入当前时间戳 + 延时动作
	members := redis.Z{
		Score:  float64(delay),
		Member: inJson,
	}
	key := q.Key
	if key == "" {
		panic("键不能为空！")
	}
	cmd :=cmf.RedisDb().ZAdd(key, members)
	if cmd.Err() != nil {
		return cmd.Err()
	}
	return nil
}

func (q Queue) AddAll(members []redis.Z) error {

	key := q.Key
	if key == "" {
		panic("键不能为空！")
	}

	cmd :=cmf.RedisDb().ZAdd(key, members...)
	if cmd.Err() != nil {
		return cmd.Err()
	}

	return nil
}

func (q Queue) ExpireAllData() ([]redis.Z, error) {

	key := q.Key
	if key == "" {
		panic("键不能为空！")
	}

	dateTime := strconv.FormatInt(time.Now().Unix(), 10)

	cmd :=cmf.RedisDb().ZRangeByScoreWithScores(key, redis.ZRangeBy{
		Min: "-inf",
		Max: dateTime,
	})

	if cmd.Err() != nil {
		return nil, cmd.Err()
	}

	result := cmd.Val()

	return result, nil
}
