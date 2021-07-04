/**
** @创建时间: 2020/11/25 2:01 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"encoding/json"
	"errors"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfModel "github.com/gincmf/cmf/model"
	"strings"
	"time"
)

type PortalPost struct {
	Id                  int               `json:"id"`
	Mid                 int               `gorm:"type:bigint(20);comment:对应小程序id;not null" json:"mid"`
	ParentId            int               `gorm:"type:int(11);comment:父级id;NOT NULL" json:"parent_id"`
	PostType            int               `gorm:"type:tinyint(3);comment:类型（1:文章，2:页面）;default:1;NOT NULL" json:"post_type"`
	PostFormat          int               `gorm:"type:tinyint(3);comment:内容格式（1:html，2:md）;default:1;NOT NULL" json:"post_format"`
	UserId              int               `gorm:"type:int(11);comment:发表者用户id;NOT NULL" json:"user_id"`
	PostStatus          int               `gorm:"type:tinyint(3);comment:状态（1:已发布，0:未发布）;default:1;NOT NULL" json:"post_status"`
	CommentStatus       int               `gorm:"type:tinyint(3);comment:评论状态（1:允许，0:不允许）;default:1;NOT NULL" json:"comment_status"`
	IsTop               int               `gorm:"type:tinyint(3);comment:是否置顶（1:置顶，0:不置顶）;default:0;NOT NULL" json:"is_top"`
	Recommended         int               `gorm:"type:tinyint(3);comment:是否推荐（1:推荐，0:不推荐）;default:0;NOT NULL" json:"recommended"`
	PostHits            int               `gorm:"type:int(11);comment:查看数;default:0;NOT NULL" json:"post_hits"`
	PostFavorites       int               `gorm:"type:int(11);comment:收藏数;default:0;NOT NULL" json:"post_favorites"`
	PostLike            int               `gorm:"type:int(11);comment:点赞数;default:0;NOT NULL" json:"post_like"`
	CommentCount        int               `gorm:"type:int(11);comment:评论数;default:0;NOT NULL" json:"comment_count"`
	CreateAt            int64             `gorm:"type:bigint(20);NOT NULL" json:"create_at"`
	UpdateAt            int64             `gorm:"type:bigint(20);NOT NULL" json:"update_at"`
	PublishedAt         int64             `gorm:"type:int(11);comment:发布时间;NOT NULL" json:"published_at"`
	DeleteAt            int64             `gorm:"type:int(11);comment:删除实际;NOT NULL" json:"delete_at"`
	CreateTime          string            `gorm:"-" json:"create_time"`
	UpdateTime          string            `gorm:"-" json:"update_time"`
	PublishTime         string            `gorm:"-" json:"publish_time"`
	DeleteTime          string            `gorm:"-" json:"delete_time"`
	PostTitle           string            `gorm:"type:varchar(100);comment:post标题;NOT NULL" json:"post_title"`
	PostKeywords        string            `gorm:"type:varchar(150);comment:SEO关键词;NOT NULL" json:"post_keywords"`
	PostExcerpt         string            `gorm:"type:varchar(500);comment:post摘要;NOT NULL" json:"post_excerpt"`
	PostSource          string            `gorm:"type:varchar(500);comment:转载文章的来源;NOT NULL" json:"post_source"`
	Thumbnail           string            `gorm:"type:varchar(100);comment:缩略图;NOT NULL" json:"thumbnail"`
	ThumbnailPrev       string            `gorm:"-" json:"thumbnail_prev"`
	PostContent         string            `gorm:"type:text;comment:文章内容;NOT NULL" json:"post_content"`
	PostContentFiltered string            `gorm:"type:text;comment:处理过的文章内容;NOT NULL" json:"post_content_filtered"`
	More                string            `gorm:"type:json;comment:扩展属性,如缩略图。格式为json;NOT NULL" json:"more"`
	Category            []PortalCategory  `gorm:"-" json:"category"`
	MoreJson            More              `gorm:"-" json:"more_json"`
	paginate            cmfModel.Paginate `gorm:"-"`
}

type More struct {
	Photos   []Path            `json:"photos"`
	Files    []Path            `json:"files"`
	Audio    string            `json:"audio"`
	Video    string            `json:"video"`
	Other    []Other           `json:"other"`
	Template string            `json:"template"`
	Extends  map[string]string `json:"extends"`
}

type Path struct {
	RemarkName string `json:"remark_name"`
	PrevPath   string `json:"prev_path"`
	FilePath   string `json:"file_path"`
}

type Other struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

// 分类关系表
type PortalCategoryPost struct {
	Id         int     `json:"id"`
	PostId     int     `gorm:"type:int(11);comment:文章id;not null" json:"post_id"`
	CategoryId int     `gorm:"type:int(11);comment:分类id;not null" json:"category_id"`
	ListOrder  float64 `gorm:"type:float(0);comment:排序;default:10000;not null" json:"list_order"`
	Status     int     `gorm:"type:tinyint(3);comment:状态,1:发布;0:不发布;default:1;not null" json:"status"`
}

func (model PortalPost) PortalList(query []string, queryArgs []interface{}) ([]PortalPost, error) {

	postType := model.PostType

	if postType == 0 {
		postType = 1
	}

	query = append(query, []string{"post_type = ?", "delete_at = ?"}...)
	queryArgs = append(queryArgs, postType, 0)

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")
	var post []PortalPost

	tx := cmf.NewDb().Where(queryStr, queryArgs...).Find(&post)

	if tx.Error != nil {
		return []PortalPost{}, tx.Error
	}

	return post, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 根据分类显示文字列表
 * @Date 2020/11/26 13:24:01
 * @Param
 * @return
 **/

func (model PortalPost) IndexByCategory(c *gin.Context, query []string, queryArgs []interface{}) (cmfModel.Paginate, error) {

	// 获取默认的系统分页
	current, pageSize, err := model.paginate.Default(c)

	if err != nil {
		return cmfModel.Paginate{}, err
	}

	// 合并参数合计
	queryStr := strings.Join(query, " AND ")

	var total int64 = 0

	prefix := cmf.Conf().Database.Prefix

	cmf.NewDb().Table(prefix+"portal_post p").Distinct("p.id").
		Joins("LEFT JOIN "+prefix+"portal_category_post cp ON p.id = cp.post_id").
		Joins("LEFT JOIN "+prefix+"portal_category pc ON pc.id = cp.category_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = p.user_id").
		Where(queryStr, queryArgs...).
		Group("p.id").
		Order("id desc").Count(&total)

	type temp struct {
		PortalPost
		UserLogin     string           `json:"user_login"`
		Category      []PortalCategory `gorm:"-" json:"category"`
		MoreJson      More             `gorm:"-" json:"more_json"`
		ThumbnailPrev string           `json:"thumbnail_prev"`
	}

	var tempArr []temp

	result := cmf.NewDb().Table(prefix+"portal_post p").Select("p.*,pc.name,u.user_login").
		Joins("LEFT JOIN "+prefix+"portal_category_post cp ON p.id = cp.post_id").
		Joins("LEFT JOIN "+prefix+"portal_category pc ON pc.id = cp.category_id").
		Joins("LEFT JOIN "+prefix+"user u ON u.id = p.user_id").
		Where(queryStr, queryArgs...).Limit(pageSize).Offset((current - 1) * pageSize).
		Group("p.id").Order("id desc").Scan(&tempArr)

	if result.Error != nil {
		return cmfModel.Paginate{}, nil
	}

	for k, v := range tempArr {
		category := PortalCategory{}
		categoryItem, _ := category.ListWithPost([]string{"p.id = ?"}, []interface{}{v.Id})
		tempArr[k].Category = categoryItem

		createTime := time.Unix(v.CreateAt, 0).Format("2006-01-02 15:04:05")
		tempArr[k].CreateTime = createTime

		updateTime := time.Unix(v.UpdateAt, 0).Format("2006-01-02 15:04:05")
		tempArr[k].UpdateTime = updateTime

		tempArr[k].ThumbnailPrev = util.GetFileUrl(v.Thumbnail, "clipper")

		m := More{}
		json.Unmarshal([]byte(v.More), &m)
		tempArr[k].MoreJson = m

	}

	paginate := cmfModel.Paginate{Data: tempArr, Current: current, PageSize: pageSize, Total: total}
	if len(tempArr) == 0 {
		paginate.Data = make([]string, 0)
	}

	return paginate, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description
 * @Date 2020/11/27 13:11:43
 * @Param
 * @return
 **/

func (model PortalPost) Show(query []string, queryArgs []interface{}) (post PortalPost, err error) {

	queryStr := strings.Join(query, " AND ")
	tx := cmf.NewDb().Debug().Where(queryStr, queryArgs...).Find(&post)

	if tx.Error != nil {
		return post, tx.Error
	}

	if post.Id == 0 {
		return post, errors.New("该文章不存在！")
	}

	category := PortalCategory{}
	categoryItem, _ := category.ListWithPost([]string{"p.id = ?"}, []interface{}{post.Id})
	post.Category = categoryItem

	createTime := time.Unix(post.CreateAt, 0).Format("2006-01-02 15:04:05")
	post.CreateTime = createTime

	updateTime := time.Unix(post.UpdateAt, 0).Format("2006-01-02 15:04:05")
	post.UpdateTime = updateTime

	post.ThumbnailPrev = util.GetFileUrl(post.Thumbnail, "clipper")

	m := More{}

	json.Unmarshal([]byte(post.More), &m)
	post.MoreJson = m

	return post, nil

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 创建文章
 * @Date 2020/11/25 15:59:30
 * @Param
 * @return
 **/

func (model PortalPost) Store() (PortalPost, error) {

	portal := PortalPost{}
	result := cmf.NewDb().Create(&model)

	if result.Error != nil {
		return portal, nil
	}

	return model, nil
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 更新
 * @Date 2020/11/27 14:18:22
 * @Param
 * @return
 **/
func (model PortalPost) Update() (PortalPost, error) {

	portal := PortalPost{}
	result := cmf.NewDb().Save(&model)

	if result.Error != nil {
		return portal, result.Error
	}

	return model, nil
}

func (model PortalCategoryPost) Store(pcpPost []PortalCategoryPost) ([]PortalCategoryPost, error) {

	var pcp []PortalCategoryPost
	result := cmf.NewDb().Where("post_id  = ?", model.PostId).Find(&pcp)
	if result.Error != nil {
		return pcp, nil
	}

	// 删除原来的
	var delQuery []string
	var delQueryArgs []interface{}

	for _, v := range pcp {
		if !model.inArray(v, pcpPost) || len(pcpPost) == 0 {
			delQuery = append(delQuery, "(post_id = ? and category_id = ?)")
			delQueryArgs = append(delQueryArgs, v.PostId, v.CategoryId)
		}

		// 如果未传参，全部删除
		if len(pcpPost) == 0 {
			delQuery = append(delQuery, "(post_id = ? and category_id = ?)")
			delQueryArgs = append(delQueryArgs, v.PostId, v.CategoryId)
		}
	}

	var toAddPcp []PortalCategoryPost

	// 添加待添加的
	for _, v := range pcpPost {
		if !model.inArray(v, pcp) || len(pcp) == 0 {
			toAddPcp = append(toAddPcp, PortalCategoryPost{
				PostId:     v.PostId,
				CategoryId: v.CategoryId,
			})
		}
	}

	// 删除要删除的
	delQueryStr := strings.Join(delQuery, " OR ")
	if delQueryStr != "" {
		cmf.NewDb().Debug().Where(delQueryStr, delQueryArgs...).Delete(&PortalCategoryPost{})
	}

	//添加要添加的
	if len(toAddPcp) > 0 {
		result = cmf.NewDb().Create(&toAddPcp)
		if result.Error != nil {
			return []PortalCategoryPost{}, nil
		}
	}

	// 查询最后的结果
	result = cmf.NewDb().Where("post_id  = ?", model.Id).Find(&pcp)
	if result.Error != nil {
		return pcp, nil
	}
	return pcp, nil
}

func (model PortalCategoryPost) inArray(inPost PortalCategoryPost, pcp []PortalCategoryPost) bool {

	for _, v := range pcp {

		if inPost.PostId == v.PostId && inPost.CategoryId == v.CategoryId {
			return true
		}
	}
	return false
}
