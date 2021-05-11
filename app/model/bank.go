/**
** @创建时间: 2021/4/27 10:59 上午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

type Bank struct {
	Id           int    `json:"id"`
	BankName     string `gorm:"type:varchar(128);comment:银行全称;not null" json:"bank_name"`
	BankBranchId string `gorm:"type:varchar(128);comment:联行号" json:"bank_branch_id"`
	Type         string `gorm:"type:tinyint(3);comment:类型（0 => 银行大类，1=> 支行详情）;default:0;not null" json:"type"`
}

func (model *Bank) List() ([]Bank, error) {
	// 第一步查询出全部的省市区
	var b []Bank
	tx := cmf.Db().Where("type = 0").Find(&b)
	if tx.Error != nil {
		return b, tx.Error
	}
	return b, nil
}

func (model *Bank) ListLike(keywords string) ([]Bank, error) {
	// 第一步查询出全部的省市区
	var b []Bank
	tx := cmf.Db().Where("bank_name like ? AND type = ?", "%"+keywords+"%", 1).Limit(10).Find(&b)
	if tx.Error != nil {
		return b, tx.Error
	}
	return b, nil
}
