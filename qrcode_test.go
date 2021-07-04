/**
** @创建时间: 2021/3/12 2:01 上午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"archive/zip"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/makiuchi-d/gozxing"
	deQrcode "github.com/makiuchi-d/gozxing/qrcode"
	"github.com/nfnt/resize"
	uuid "github.com/nu7hatch/gouuid"
	"github.com/skip2/go-qrcode"
	"image"
	"image/draw"
	_ "image/jpeg"
	"image/png"
	"math/rand"
	"os"
	"regexp"
	"strconv"
	"strings"
	"testing"
	"time"
)

func init() {
	cmf.Initialize("data/conf/config.json")
}

func Test_Qrcode(test *testing.T) {

	var qrArr []model.Qrcode

	var path []string

	for i := 0; i < 10; i++ {

		host := cmf.Conf().App.Domain

		if cmf.Conf().App.AppDebug {
			host = "https://console.mashangdian.cn"
		}

		year, month, day := util.CurrentDate()

		insertKey := "mp_isv:qrcode"

		rand.Seed(time.Now().UnixNano())
		salt := rand.Intn(100)

		code := util.EncryptUuid(insertKey, year+month+day, salt)

		qrcodeUrl := host + "/qrcode/" + code

		fileUuid, err := uuid.NewV4()

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

		publicPath := "public/uploads/"
		dirName := "qrcode"
		filename := dirName + "/" + timeDir + "/" + cmfUtil.GetMd5(fileUuid.String()) + ".png"

		uploadPath := publicPath + dirName + "/" + timeDir + "/"

		_, err = os.Stat(uploadPath)
		if err != nil {
			os.MkdirAll(uploadPath, os.ModePerm)
		}

		filepath := publicPath + filename

		q, err := qrcode.New(qrcodeUrl, qrcode.Highest)
		if err != nil {
			panic(err)
		}

		q.DisableBorder = true

		err = q.WriteFile(512, filepath)
		if err != nil {
		}

		// 加入logo
		qrFile, _ := os.Open(filepath)
		qrImg, _, err := image.Decode(qrFile)
		if err != nil {
		}
		defer qrFile.Close()

		// 缩小二维码
		qrImg = resize.Resize(280, 280, qrImg, resize.Lanczos3)

		qrWidth := qrImg.Bounds().Max.X
		qrHeight := qrImg.Bounds().Max.Y

		logoFile, _ := os.Open(util.GetAbsPath("images/alipay-logo.png"))
		logoImg, _, err := image.Decode(logoFile)
		if err != nil {
		}
		defer logoFile.Close()

		// 缩小logo
		logoImg = resize.Resize(60, 60, logoImg, resize.Lanczos3)

		logoWidth := logoImg.Bounds().Max.X
		logoHeight := logoImg.Bounds().Max.Y

		// 外框
		bgFile, _ := os.Open(util.GetAbsPath("images/bg.png"))
		bgImg, _, err := image.Decode(bgFile)
		if err != nil {
		}
		defer bgFile.Close()

		bgWidth := bgImg.Bounds().Max.X
		bgHeight := bgImg.Bounds().Max.Y

		// 二维码的位置
		qx := bgWidth/2 - qrWidth/2
		qy := (bgHeight/2 - qrHeight/2) - 45

		// logo的位置
		lx := qx + (qrWidth/2 - logoWidth/2)
		ly := qy + (qrHeight/2 - logoHeight/2)

		b := bgImg.Bounds()
		m := image.NewRGBA(b)

		draw.Draw(m, b, bgImg, image.Point{}, draw.Src)
		draw.Draw(m, qrImg.Bounds().Add(image.Pt(qx, qy)), qrImg, image.Point{}, draw.Over)
		draw.Draw(m, logoImg.Bounds().Add(image.Pt(lx, ly)), logoImg, image.Point{}, draw.Over)

		absPath := util.GetAbsPath(filename)
		imgw, err := os.Create(absPath)

		if err != nil {
			fmt.Println("err", err)
		}

		png.Encode(imgw, m)
		defer imgw.Close()

		key := filename
		if cmf.QiuNiuConf().Enabled == false {
			// 同步到七牛云
			key, err = new(cmf.QiNiu).UploadFile(filename, absPath)
			if err != nil {
				fmt.Println("err", err.Error())
			}
		}

		path = append(path, absPath)

		qr := model.Qrcode{
			Code:     code,
			FilePath: key,
			CreateAt: time.Now().Unix(),
		}

		qrArr = append(qrArr, qr)

	}

	tx := cmf.Db().Debug().Create(&qrArr)
	if tx.Error != nil {
		return
	}

	util.ZipCreate(path, "public/uploads/qrcode/out.zip")

}

func Test_Decode(test *testing.T) {

	rc, err := zip.OpenReader("aq.zip")

	if err != nil {
		defer rc.Close()
	}
	for _, f := range rc.File {
		fmt.Println(f.Name)

		rFile, err := f.Open()

		if err != nil {
			fmt.Printf(err.Error())
		}

		if !f.FileInfo().IsDir() {

			img, _, _ := image.Decode(rFile)

			// prepare BinaryBitmap
			bmp, _ := gozxing.NewBinaryBitmapFromImage(img)

			// decode image
			qrReader := deQrcode.NewQRCodeReader()
			result, err := qrReader.Decode(bmp, nil)

			if err != nil {
				return
			}

			fmt.Println(result.String())

			patter := "[^\\?[^\\s]+]*"
			reg := regexp.MustCompile(patter)

			regResult := reg.FindAllString(result.String(), -1)

			url := ""

			param := ""
			if len(regResult) == 2 {
				url = regResult[0]
				param = regResult[1]
			}

			inParamMap := strings.Split(param, "&")

			fmt.Println("inParamMap", inParamMap)

			paramMap := make(map[string]string, 0)

			for _, value := range inParamMap {
				if value != "" {
					parts := strings.Split(value, "=")
					if len(parts) == 2 {
						paramMap[parts[0]] = parts[1]
					}
				}
			}

			code := ""

			fmt.Println("url", url)

			patter = "/qrcode/\\d+"
			r := regexp.MustCompile(patter)
			matches := r.FindAllString(url, -1)

			fmt.Println("matches", matches)

			if len(matches) > 0 {
				code = strings.ReplaceAll(matches[0], "/qrcode/", "")
				fmt.Println("code", code)
			}

			if code == "" {
				continue
			}

			aqrfid := paramMap["aqrfid"]

			q := model.Qrcode{}
			tx := cmf.NewDb().Where("code = ? AND status < ?", code, 2).First(&q)
			if tx.Error != nil {
				continue
			}

			q.Aqrfid = aqrfid

			cmf.NewDb().Where("code = ? AND  status != ?", code, 2).Updates(&q)
		}

		rFile.Close()

	}

}
