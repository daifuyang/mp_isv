/**
** @创建时间: 2021/4/3 10:46 上午
** @作者　　: return
** @描述　　: //生成二维码
 */
package admin

import (
	"archive/zip"
	"fmt"
	"gincmf/app/model"
	"gincmf/app/util"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	"github.com/gincmf/cmf/controller"
	cmfUtil "github.com/gincmf/cmf/util"
	"github.com/makiuchi-d/gozxing"
	deQrcode "github.com/makiuchi-d/gozxing/qrcode"
	"github.com/nfnt/resize"
	uuid "github.com/nu7hatch/gouuid"
	"github.com/skip2/go-qrcode"
	"image"
	"image/draw"
	"image/png"
	"io"
	"math/rand"
	"os"
	"regexp"
	"strconv"
	"strings"
	"time"
)

type Qrcode struct {
	rc controller.Rest
}

// 生成二维码
func (rest *Qrcode) Generate(c *gin.Context) {

	adminId := util.CurrentAdminId(c)

	if adminId != 1 {
		rest.rc.Error(c, "非法访问！", nil)
		return
	}

	count := c.PostForm("count")
	if count == "" {
		rest.rc.Error(c, "数量不能为空！", nil)
		return
	}

	countInt, _ := strconv.Atoi(count)

	var qrArr []model.Qrcode

	var path []string

	var (
		qrFile   *os.File
		logoFile *os.File
		bgFile   *os.File
		imgW     *os.File
		result   []string
	)

	for i := 0; i < countInt; i++ {

		host := cmf.Conf().App.Domain

		year, month, day := util.CurrentDate()

		insertKey := "mp_isv:qrcode"

		rand.Seed(time.Now().UnixNano())
		salt := rand.Intn(100)

		code := util.EncryptUuid(insertKey, year+month+day, salt)

		qrcodeUrl := host + "/qrcode/" + code

		fileUuid, err := uuid.NewV4()
		if err != nil {
			result = append(result, err.Error())
			continue
		}

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
			_ = os.MkdirAll(uploadPath, os.ModePerm)
		}

		filepath := publicPath + filename

		q, err := qrcode.New(qrcodeUrl, qrcode.Highest)
		if err != nil {
			result = append(result, err.Error())
			continue
		}

		q.DisableBorder = true

		err = q.WriteFile(512, filepath)
		if err != nil {
			result = append(result, err.Error())
			continue
		}

		// 加入logo
		qrFile, _ = os.Open(filepath)
		qrImg, _, err := image.Decode(qrFile)
		if err != nil {
			result = append(result, err.Error())
			continue
		}

		// 缩小二维码
		qrImg = resize.Resize(280, 280, qrImg, resize.Lanczos3)

		qrWidth := qrImg.Bounds().Max.X
		qrHeight := qrImg.Bounds().Max.Y

		logoFile, _ = os.Open(util.GetAbsPath("images/alipay-logo.png"))
		logoImg, _, err := image.Decode(logoFile)
		if err != nil {
			result = append(result, err.Error())
			continue
		}

		// 缩小logo
		logoImg = resize.Resize(60, 60, logoImg, resize.Lanczos3)

		logoWidth := logoImg.Bounds().Max.X
		logoHeight := logoImg.Bounds().Max.Y

		// 外框
		bgFile, _ = os.Open(util.GetAbsPath("images/bg.png"))
		bgImg, _, err := image.Decode(bgFile)

		if err != nil {
			result = append(result, err.Error())
			continue
		}

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
		imgW, err = os.Create(absPath)

		if err != nil {
			result = append(result, err.Error())
			continue
		}

		err = png.Encode(imgW, m)
		if err != nil {
			result = append(result, err.Error())
			continue
		}

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

	if qrFile != nil {
		defer qrFile.Close()
	}
	if bgFile != nil {
		defer bgFile.Close()
	}
	if logoFile != nil {
		defer logoFile.Close()
	}

	if imgW != nil {
		defer imgW.Close()
	}

	tx := cmf.Db().Create(&qrArr)
	if tx.Error != nil {
		return
	}

	targetName := "public/uploads/qrcode/out.zip"
	zRes, rErr := util.ZipCreate(path, targetName)

	if rErr != nil {
		result = append(result, zRes...)
	}

	errCount := strconv.Itoa(len(result))

	rest.rc.Success(c, "发起成功！错误数："+errCount, gin.H{
		"url": util.GetFileUrl("qrcode/out.zip", false),
		"err": result,
	})

}

// 绑定aqrfid
func (rest *Qrcode) BindAqrfid(c *gin.Context) {

	form, _ := c.MultipartForm()
	files := form.File["file"]

	if len(files) <= 0 {
		rest.rc.Error(c, "压缩包不能为空！", nil)
		return
	}

	var (
		f   *os.File
		err error
		rc  *zip.ReadCloser
	)

	for _, fileItem := range files {

		file, _ := fileItem.Open()

		_ = os.Mkdir("public/temp/", 0777)

		fileName := "public/temp/" + fileItem.Filename

		f, err = os.OpenFile(fileName, os.O_WRONLY|os.O_CREATE, 0666)

		if err != nil {
			return
		}

		_, _ = io.Copy(f, file)

		rc, err = zip.OpenReader(fileName)

		if err != nil {
			fmt.Println("err", err.Error())
			continue
		}

		for _, f := range rc.File {

			fmt.Println("fileItem", f.Name)

			rFile, err := f.Open()

			if err != nil {
				fmt.Printf(err.Error())
				continue
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
				tx := cmf.NewDb().Debug().Where("code = ? AND status < ?", code, 2).First(&q)
				if tx.Error != nil {
					continue
				}

				q.Aqrfid = aqrfid

				cmf.NewDb().Where("code = ? AND  status != ?", code, 2).Updates(&q)
			}

			_ = rFile.Close()

		}

	}

	if err != nil {
		if rc != nil {
			defer rc.Close()
		}
	}

	defer f.Close()

	rest.rc.Success(c, "绑定成功！", nil)

}

/**
 * @Author return <1140444693@qq.com>
 * @Description 用户小程序查看二维码状态
 * @Date 2021/4/12 13:32:9
 * @Param
 * @return
 **/
func (rest *Qrcode) Show(c *gin.Context) {

	// 完成业务
	var rewrite struct {
		Id int `uri:"id"`
	}

	if err := c.ShouldBindUri(&rewrite); err != nil {
		c.JSON(400, gin.H{"msg": err.Error()})
		return
	}

	qrcode := model.Qrcode{}
	tx := cmf.Db().Where("code = ? AND status = 0", rewrite.Id).First(&qrcode)
	if tx.Error != nil {
		rest.rc.Error(c, "该二维码已被绑定！", nil)
		return
	}

	rest.rc.Success(c, "获取成功！", qrcode)

}
