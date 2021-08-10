/**
** @创建时间: 2020/11/5 5:49 下午
** @作者　　: return
** @描述　　:
 */
package model

import cmf "github.com/gincmf/cmf/bootstrap"

type Region struct {
	AreaId   int    `json:"area_id"`
	AreaName string `json:"area_name"`
	AreaType int    `json:"area_type"`
	ParentId int    `json:"parent_id"`
}

type regionResult struct {
	Value    int            `json:"value"`
	Label    string         `json:"label"`
	AreaType int            `json:"area_type"`
	Children []regionResult `json:"children"`
}

func (model *Region) Region() []regionResult {
	// 第一步查询出全部的省市区
	var region []Region
	cmf.Db().Find(&region)
	result := recursionAddRegion(region, 0)
	return result
}

func (model *Region) GetChildrenById(areaId int) []Region {
	var region []Region
	cmf.Db().Where("parent_id = ?", areaId).Find(&region)
	return region
}

func (model *Region) GetOneById(areaId int) Region {
	var region Region
	cmf.Db().Where("area_id = ?", areaId).First(&region)
	return region
}

func recursionAddRegion(region []Region, parentId int) []regionResult {
	// 遍历当前层级
	var results []regionResult
	for _, v := range region {

		if parentId == v.ParentId && v.AreaType < 4 {
			result := regionResult{
				Value: v.AreaId,
				Label: v.AreaName,
				AreaType: v.AreaType,
			}
			result.Children = recursionAddRegion(region, v.AreaId)
			results = append(results, result)
		}

	}
	return results
}
