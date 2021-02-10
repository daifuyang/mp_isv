/**
** @创建时间: 2020/11/25 1:59 下午
** @作者　　: return
** @描述　　:
 */
package admin

import (
	"encoding/json"
	"errors"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/portalPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"gorm.io/gorm"
	"strconv"
	"strings"
	"time"
)

type PortalPost struct {
	rc controller.RestController
}

// 获取文章列表
func (rest *PortalPost) Get(c *gin.Context) {

	query := []string{"p.delete_at = ?"}
	queryArgs := []interface{}{0}

	title := c.Query("post_title")
	if title != "" {
		query = append(query, "p.post_title like ?")
		queryArgs = append(queryArgs, "%"+title+"%")
	}

	postType := c.Query("post_type")
	if postType == "2" {
		postType = "2"
	} else {
		postType = "1"
	}

	query = append(query, "p.post_type = ?")
	queryArgs = append(queryArgs, postType)

	startTime := c.Query("start_time")
	endTime := c.Query("end_time")

	if startTime != "" && endTime != "" {
		startTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", startTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "起始时间非法！", err.Error())
			return
		}

		endTimeStamp, err := time.ParseInLocation("2006-01-02 15:04:05", endTime, time.Local)
		if err != nil {
			rest.rc.Error(c, "结束时间非法！", err.Error())
		}

		query = append(query, "((p.publish_at BETWEEN ? AND ?) OR (p.update_at BETWEEN ? AND ?))")
		queryArgs = append(queryArgs, startTimeStamp, endTimeStamp, startTimeStamp, endTimeStamp)
	}

	post := model.PortalPost{}
	data, err := post.IndexByCategory(c, query, queryArgs)

	if err != nil {
		rest.rc.Error(c, "获取失败！", nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)
}

func (rest *PortalPost) Show(c *gin.Context) {
	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	post := model.PortalPost{
		Id: rewrite.Id,
	}

	query := []string{"id = ? AND delete_at = ?"}
	queryArgs := []interface{}{rewrite.Id, 0}

	post, err := post.Show(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var result struct {
		model.PortalPost
		Alias         string                 `json:"alias"`
		Template      string                 `json:"template"`
		ThumbPrevPath string                 `json:"thumb_prev_path"`
		AudioPrevPath string                 `json:"audio_prev_path"`
		VideoPrevPath string                 `json:"video_prev_path"`
		Keywords      []string               `json:"keywords"`
		Photos        []model.Path           `json:"photos"`
		Accessories   []model.Path           `json:"accessories"`
		Files         []model.Path           `json:"files"`
		Audio         string                 `json:"audio"`
		Video         string                 `json:"video"`
		Category      []model.PortalCategory `json:"category"`
		Extends       map[string]string      `json:"extends"`
	}

	json.Unmarshal([]byte(post.More), &result)

	if len(result.Photos) == 0 {
		result.Photos = make([]model.Path, 0)
	}
	if len(result.Accessories) == 0 {
		result.Accessories = make([]model.Path, 0)
	}
	if len(result.Files) == 0 {
		result.Files = make([]model.Path, 0)
	}

	if post.PostKeywords != "" {
		result.Keywords = strings.Split(post.PostKeywords, ",")
	}

	result.PortalPost = post
	result.ThumbPrevPath = util.GetFileUrl(result.Thumbnail)
	result.AudioPrevPath = util.GetFileUrl(result.Audio)
	result.VideoPrevPath = util.GetFileUrl(result.Video)

	pQuery := []string{"p.id = ? AND p.delete_at = ?"}
	pQueryArgs := []interface{}{rewrite.Id, 0}
	pc := model.PortalCategory{

	}
	category, err := pc.ListWithPost(pQuery, pQueryArgs)

	result.Category = category

	rest.rc.Success(c, "获取成功！", result)

}

func (rest *PortalPost) Edit(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt, _ := mid.(int)

	var rewrite struct {
		Id int `uri:"id"`
	}
	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	var form struct {
		CategoryIds       []string          `json:"category_ids"`
		PostType          int               `json:"post_type"`
		PostTitle         string            `json:"post_title"`
		Alias             string            `json:"alias"`
		Thumbnail         string            `json:"thumbnail"`
		PostKeywords      []string          `json:"post_keywords"`
		PostSource        string            `json:"post_source"`
		PostExcerpt       string            `json:"post_excerpt"`
		PostContent       string            `json:"post_content"`
		IsTop             int               `json:"is_top"`
		Recommended       int               `json:"recommended"`
		PostStatus        int               `json:"post_status"`
		Photos            []model.Path      `json:"photos"`
		Accessories       []model.Path      `json:"accessories"`
		Files             []model.Path      `json:"files"`
		Audio             string            `json:"audio"`
		Video             string            `json:"video"`
		MsrpRange         string            `json:"msrp_range"`
		ReferenceQuote    string            `json:"reference_quote"`
		Moq               string            `json:"moq"`
		ReferenceLeadTime string            `json:"reference_lead_time"`
		Other             []model.Other     `json:"other"`
		Template          string            `json:"template"`
		Extends           map[string]string `json:"extends"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	postType := 1
	if form.PostType == 2 {
		postType = 2
	}

	if postType == 1 && len(form.CategoryIds) == 0 {
		rest.rc.Error(c, "分类不能为空！", nil)
		return
	}

	if form.PostTitle == "" {
		rest.rc.Error(c, "标题不能为空！", nil)
		return
	}

	currentTime := time.Now().Unix()

	var more model.More

	more.Photos = form.Photos
	more.Files = form.Files
	more.Audio = form.Audio
	more.Video = form.Video
	more.Other = form.Other
	more.Extends = form.Extends

	if form.Template != "" {
		more.Template = form.Template
	}

	if form.Template != "" {
		more.Template = form.Template
	}

	moreJson, err := json.Marshal(more)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	userId := util.CurrentAdminId(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	userIdInt, _ := strconv.Atoi(userId)

	portal := model.PortalPost{}

	portal, err = portal.Show([]string{"id = ?"}, []interface{}{rewrite.Id})
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	isTop := 0
	if form.IsTop == 1 {
		isTop = 1
	}

	recommended := 0
	if form.Recommended == 1 {
		recommended = 1
	}

	postStatus := 0
	if form.PostStatus == 1 {
		postStatus = 1
	}

	portal.Mid = midInt
	portal.PostType = postType
	portal.PostTitle = form.PostTitle
	portal.Thumbnail = form.Thumbnail
	portal.UserId = userIdInt
	portal.PostKeywords = strings.Join(form.PostKeywords, ",")
	portal.PostSource = form.PostSource
	portal.PostExcerpt = form.PostExcerpt
	portal.PostContent = form.PostContent
	portal.CreateAt = currentTime
	portal.UpdateAt = currentTime
	portal.IsTop = isTop
	portal.Recommended = recommended
	portal.PostStatus = postStatus
	portal.More = string(moreJson)

	var data struct {
		model.PortalPost
		Category []model.PortalCategoryPost `json:"category"`
	}

	postData, err := portal.Update()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var tag []int

	for _, v := range form.PostKeywords {
		// 查询当前tag是否存在
		portalTag, err := new(model.PortalTag).Show([]string{"name = ?"}, []interface{}{v})
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		portalTag.Name = v

		portalTag, err = portalTag.FirstOrSave()
		if err != nil {
			rest.rc.Error(c, err.Error(), err)
		}

		tag = append(tag, portalTag.Id)
	}

	tagPost := model.PortalTagPost{
		PostId: postData.Id,
	}
	tagPost.FirstOrSave(tag)

	data.PortalPost = postData

	var pcpPost = make([]model.PortalCategoryPost, 0)

	pcp := model.PortalCategoryPost{}

	category := model.PortalCategory{
		Mid: midInt,
	}
	existsCate, err := category.List()

	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "请先添加分类！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	for _, v := range form.CategoryIds {

		cidInt, _ := strconv.Atoi(v)

		if !rest.inArray(cidInt, existsCate) {
			rest.rc.Error(c, "分类参数非法！", nil)
			return
		}

		pcp.PostId = postData.Id
		pcp.CategoryId = cidInt
		pcpPost = append(pcpPost, pcp)
	}

	pcpData, pcpErr := pcp.Store(pcpPost)
	if pcpErr != nil {
		rest.rc.Error(c, pcpErr.Error(), nil)
		return
	}

	data.Category = pcpData

	rest.rc.Success(c, "更新成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 添加文章
 * @Date 2020/11/25 15:26:10
 * @Param
 * @return
 **/

func (rest *PortalPost) Store(c *gin.Context) {

	mid, _ := c.Get("mid")
	midInt, _ := mid.(int)

	var form struct {
		CategoryIds       []string          `json:"category_ids"`
		PostType          int               `json:"post_type"`
		PostTitle         string            `json:"post_title"`
		Thumbnail         string            `json:"thumbnail"`
		PostKeywords      []string          `json:"post_keywords"`
		PostSource        string            `json:"post_source"`
		PostExcerpt       string            `json:"post_excerpt"`
		PostContent       string            `json:"post_content"`
		IsTop             int               `json:"is_top"`
		Recommended       int               `json:"recommended"`
		Status            int               `json:"status"`
		Photos            []model.Path      `json:"photos"`
		Accessories       []model.Path      `json:"accessories"`
		Files             []model.Path      `json:"files"`
		Audio             string            `json:"audio"`
		Video             string            `json:"video"`
		MsrpRange         string            `json:"msrp_range"`
		ReferenceQuote    string            `json:"reference_quote"`
		Moq               string            `json:"moq"`
		ReferenceLeadTime string            `json:"reference_lead_time"`
		Other             []model.Other     `json:"other"`
		Template          string            `json:"template"`
		Extends           map[string]string `json:"extends"`
	}

	err := c.ShouldBind(&form)
	if err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	postType := 1
	if form.PostType == 2 {
		postType = 2
	}

	if postType == 1 && len(form.CategoryIds) == 0 {
		rest.rc.Error(c, "分类不能为空！", nil)
		return
	}

	if form.PostTitle == "" {
		rest.rc.Error(c, "标题不能为空！", nil)
		return
	}

	currentTime := time.Now().Unix()

	var more model.More
	more.Photos = form.Photos
	more.Files = form.Files
	more.Audio = form.Audio
	more.Video = form.Video
	more.Other = form.Other
	more.Extends = form.Extends

	if form.Template != "" {
		more.Template = form.Template
	}

	moreJson, err := json.Marshal(more)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	userId := util.CurrentAdminId(c)
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}
	userIdInt, _ := strconv.Atoi(userId)

	portal := model.PortalPost{
		Mid:          midInt,
		PostType:     postType,
		PostTitle:    form.PostTitle,
		Thumbnail:    form.Thumbnail,
		UserId:       userIdInt,
		PostKeywords: strings.Join(form.PostKeywords, ","),
		PostSource:   form.PostSource,
		PostExcerpt:  form.PostExcerpt,
		PostContent:  form.PostContent,
		CreateAt:     currentTime,
		UpdateAt:     currentTime,
		IsTop:        form.IsTop,
		Recommended:  form.Recommended,
		PostStatus:   form.Status,
		More:         string(moreJson),
	}

	var data struct {
		model.PortalPost
		Category []model.PortalCategoryPost `json:"category"`
	}
	postData, err := portal.Store()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var tag []int
	for _, v := range form.PostKeywords {
		// 查询当前tag是否存在
		portalTag, err := new(model.PortalTag).Show([]string{"name = ?"}, []interface{}{v})
		if err != nil {
			rest.rc.Error(c, err.Error(), nil)
			return
		}

		portalTag.Name = v

		_, err = portalTag.FirstOrSave()
		if err != nil {
			rest.rc.Error(c, err.Error(), err)
		}

		tag = append(tag, portalTag.Id)

	}

	tagPost := model.PortalTagPost{
		Id: postData.Id,
	}

	tagPost.FirstOrSave(tag)

	data.PortalPost = postData

	var pcpPost = make([]model.PortalCategoryPost, 0)

	pcp := model.PortalCategoryPost{}

	category := model.PortalCategory{
		Mid: midInt,
	}

	existsCate, err := category.List()

	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			rest.rc.Error(c, "请先添加分类！", nil)
			return
		}
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	for _, v := range form.CategoryIds {

		cidInt, _ := strconv.Atoi(v)

		if !rest.inArray(cidInt, existsCate) {
			fmt.Println(v)
			rest.rc.Error(c, "分类参数非法！", nil)
			return
		}

		pcp.PostId = postData.Id
		pcp.CategoryId = cidInt
		pcpPost = append(pcpPost, pcp)
	}

	fmt.Println("pcp", pcpPost)

	pcpData, pcpErr := pcp.Store(pcpPost)
	if pcpErr != nil {
		rest.rc.Error(c, pcpErr.Error(), nil)
		return
	}

	data.Category = pcpData

	rest.rc.Success(c, "添加成功！", data)

}

func (rest *PortalPost) inArray(cid int, pc []model.PortalCategory) bool {
	for _, v := range pc {
		if v.Id == cid {
			return true
		}
	}
	return false
}
func (rest *PortalPost) Delete(c *gin.Context) {

	var rewrite struct {
		Id int `uri:"id"`
	}

	ids := c.QueryArray("ids")

	fmt.Println("first_ids", ids)
	post := &model.PortalPost{}

	if len(ids) == 0 {
		if err := c.ShouldBindUri(&rewrite); err != nil {
			c.JSON(400, gin.H{"msg": err})
			return
		}

		fmt.Println("Id", rewrite.Id)

		result := cmf.NewDb().First(&post, rewrite.Id)
		if result.RowsAffected == 0 {
			rest.rc.Error(c, "该内容不存在！", nil)
			return
		}

		post.Id = rewrite.Id
		post.DeleteAt = time.Now().Unix()

		if err := cmf.NewDb().Save(post).Error; err != nil {
			rest.rc.Error(c, "删除失败！", nil)
			return
		}
	} else {
		fmt.Println("ids", ids)
		if err := cmf.NewDb().Model(&post).Where("id IN (?)", ids).Updates(map[string]interface{}{"delete_at": time.Now().Unix()}).Error; err != nil {
			rest.rc.Error(c, "删除失败！", nil)
			return
		}
	}

	rest.rc.Success(c, "删除成功！", nil)

}
