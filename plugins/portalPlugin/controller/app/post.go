/**
** @创建时间: 2020/12/25 11:24 下午
** @作者　　: return
** @描述　　:
 */
package app

import (
	"encoding/json"
	"fmt"
	"gincmf/app/util"
	"gincmf/plugins/portalPlugin/model"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	"strings"
)

type Post struct {
	rc controller.RestController
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取文章列表
 * @Date 2021/1/10 17:10:34
 * @Param
 * @return
 **/
func (rest *Post) Get(c *gin.Context) {

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	categoryId := rewrite.Id
	pc := model.PortalCategory{Id: categoryId}
	ids, err := pc.ChildIds()
	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var query []string
	var queryArgs []interface{}

	queryRes := []string{"p.mid = ?"}
	queryArgs = append(queryArgs, mid)

	for _, v := range ids {
		query = append(query, "cp.category_id = ?")
		queryArgs = append(queryArgs, v)
	}

	queryRes = append(queryRes, "p.post_type = 1 AND p.delete_at = 0")

	if len(query) > 0 {
		queryStr := strings.Join(query, " OR ")
		queryRes = append(queryRes, queryStr)
	}

	data, err := model.PortalPost{}.IndexByCategory(c, queryRes, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取文章列表
 * @Date 2021/1/10 17:10:34
 * @Param
 * @return
 **/
func (rest *Post) ListWithCid(c *gin.Context) {

	var form struct {
		Ids []int `json:"ids"`
	}

	if err := c.BindJSON(&form); err != nil {
		fmt.Println(err.Error())
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	var query []string
	var queryArgs []interface{}

	for _, v := range form.Ids {
		query = append(query, "cp.category_id = ?")
		queryArgs = append(queryArgs, v)
	}

	queryRes := []string{"p.post_type = 1 AND p.delete_at = 0"}

	if len(query) > 0 {
		queryStr := strings.Join(query, " OR ")
		queryRes = append(queryRes, queryStr)
	}

	data, err := model.PortalPost{}.IndexByCategory(c, queryRes, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	rest.rc.Success(c, "获取成功！", data)

}

func (rest *Post) Show(c *gin.Context) {

	mid, _ := c.Get("mid")

	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err})
		return
	}

	id := rewrite.Id

	var query = []string{"mid = ?", "id = ?", "delete_at = ?"}
	var queryArgs = []interface{}{mid, id, 0}

	post, err := new(model.PortalPost).Show(query, queryArgs)

	if err != nil {
		rest.rc.Error(c, err.Error(), nil)
		return
	}

	var result struct {
		model.PortalPost
		ThumbPrevPath string                 `json:"thumb_prev_path"`
		AudioPrevPath string                 `json:"audio_prev_path"`
		VideoPrevPath string                 `json:"video_prev_path"`
		Template      string                 `json:"template"`
		Address       string                 `json:"address"`
		Keywords      []string               `json:"keywords"`
		Photos        []model.Path           `json:"photos"`
		Accessories   []model.Path           `json:"accessories"`
		Files         []model.Path           `json:"files"`
		Audio         string                 `json:"audio"`
		Video         string                 `json:"video"`
		Category      []model.PortalCategory `json:"category"`
	}

	json.Unmarshal([]byte(post.More), &result)

	if len(result.Photos) == 0 {
		result.Photos = make([]model.Path, 0)
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

	// 更新点击率
	post.PostHits = post.PostHits + 1
	cmf.NewDb().Updates(&post)

	rest.rc.Success(c, "获取成功！", result)
}
