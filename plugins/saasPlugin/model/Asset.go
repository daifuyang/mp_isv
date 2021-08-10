/**
** @创建时间: 2021/2/28 11:30 上午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"bytes"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"path"
	"strconv"
	"strings"
	"time"
)

type Asset struct {
	model.Asset
	Mid int      `gorm:"type:bigint(20);comment:小程序加密编号;not null" json:"mid"`
}

// 同步网络图片到七牛云
func (model *Asset) SyncUpload(mid int, url string) (filePath string, err error) {

	res, err := http.Get(url)

	if err != nil {
		return filePath, err
	}
	defer res.Body.Close()
	// 获得get请求响应的reader对象

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		fmt.Println("err", err.Error())
	}

	publicPath := "public/uploads"
	t := time.Now()
	timeArr := []int{t.Year(), int(t.Month()), t.Day()}

	var timeDir string
	for key, timeInt := range timeArr {

		current := strconv.Itoa(timeInt)
		if key > 0 {
			if len(current) <= 1 {
				current = "0" + current
			}
		}
		timeDir += current

	}

	temPath := "default"
	if mid > 0 {
		temPath = "tenant/" + strconv.Itoa(mid)
	}

	uploadPath := temPath + "/" + timeDir + "/"

	urlArr := strings.Split(url, "?")

	filePath = uploadPath + path.Base(urlArr[0])

	_, err = os.Stat(publicPath + "/" + uploadPath)

	if err != nil {
		err = os.MkdirAll(publicPath+"/"+uploadPath, os.ModePerm)

		if err != nil {
			fmt.Println("os MkdirAll", err.Error())
		}

	}

	file, err := os.Create(publicPath + "/" + filePath)

	if err != nil {
		return filePath, err
	}

	defer file.Close()

	// 获得文件的writer对象
	_, err = io.Copy(file, bytes.NewReader(body))
	if err != nil {
		fmt.Println("err", err.Error())
		return filePath, err
	}

	if cmf.QiuNiuConf().Enabled {
		// 同步到七牛云
		_, err := new(cmf.QiNiu).UploadFile(filePath, util.GetAbsPath(filePath))
		if err != nil {
			fmt.Println("err", err)
			return filePath, err
		}

	}

	return filePath, nil

}
