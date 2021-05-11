package util

import (
	"archive/zip"
	"crypto"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"errors"
	"fmt"
	"github.com/gin-gonic/gin"
	cmf "github.com/gincmf/cmf/bootstrap"
	cmfUtil "github.com/gincmf/cmf/util"
	uuid "github.com/nu7hatch/gouuid"
	"github.com/pjebs/optimus-go"
	"io"
	"log"
	"math"
	"os"
	"path"
	"runtime"
	"strconv"
	"strings"
	"time"
)

//获取当前登录管理员id
func CurrentAdminId(c *gin.Context) int {
	userId, _ := c.Get("user_id")
	return userId.(int)
}

// 获取真实路径
func CurrentPath() string {

	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	rPath := strings.Replace(dir, "\\", "/", -1)

	if rPath[:len(rPath)-1] != "/" {
		rPath += "/"
	}

	return rPath
}

// 获取文件是否存在
func ExistPath(path string) (bool, error) {
	_, err := os.Stat(path)
	if err == nil {
		return true, nil
	}
	if os.IsNotExist(err) {
		fmt.Println(err.Error())
		return false, nil
	}
	fmt.Println(err.Error())
	return false, err
}

// 获取真实url
func GetFileUrl(path string,b ...bool) string {

	if path == "" {
		return ""
	}

	domain := cmf.Conf().App.Domain

	prevPath := domain + "/uploads/" + path

	ishttps := strings.Contains(domain,"https://")
	protocol := "http://"
	if ishttps {
		protocol = "https://"
	}

	if len(b) == 0 {
		if cmf.QiuNiuConf().Enabled {
			style := "clipper"

			if cmf.QiuNiuConf().IsHttps {
				protocol = "https://"
			}

			domain = protocol + cmf.QiuNiuConf().Domain + "/"

			prevPath = domain + path

			prevPath += "!" + style

		}
	}

	return prevPath
}

// 获取绝对地址
func GetAbsPath(path string) string {
	if path == "" {
		return ""
	}

	prevPath := CurrentPath() + "public/uploads/" + path
	return prevPath
}

// 去除空格回车
func TrimAll(s string) string {
	s = strings.TrimSpace(s)
	s = strings.Replace(s, " ", "", -1)
	s = strings.Replace(s, "\n", "", -1)
	return s
}

func ToLowerInArray(search string, arr []string) bool {
	for _, item := range arr {
		if strings.ToLower(search) == strings.ToLower(item) {
			return true
		}
	}
	return false
}

// 加密id 纯数字
func EncodeId(id uint64) int {
	o := optimus.New(561604931, 848718699, 1452111999)
	number := o.Encode(id)
	return int(number)
}

// 解密id 纯数字
func DecodeId(id uint64) int {
	o := optimus.New(561604931, 848718699, 1452111999)
	origId := o.Decode(id) // Returns 15 back
	return int(origId)
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 获取唯一redis生成的编号
 * @Date 2020/11/2 12:27:02
 * @Param
 * @return
 **/

func CurrentDate() (string, string, string) {
	year, month, day := time.Now().Date()
	yearStr := strconv.Itoa(year)
	monthStr := strconv.Itoa(int(month))
	if month < 10 {
		monthStr = "0" + monthStr
	}
	dayStr := strconv.Itoa(day)
	if day < 10 {
		dayStr = "0" + dayStr
	}

	return yearStr, monthStr, dayStr
}

func SetIncr(key string) int64 {
	val, err := cmf.NewRedisDb().Incr(key).Result()
	if err != nil {
		_, _, line, _ := runtime.Caller(0)
		fmt.Println("redis err"+strconv.Itoa(line), err.Error())
	}
	return val
}

// redis 原子性UUID生成

func DateUuid(ident string, insertKey string, date string, salt int) string {
	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */
	// 设置当天失效时间
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
	cmf.NewRedisDb().ExpireAt(insertKey, today)
	val := SetIncr(insertKey)

	now := time.Unix(time.Now().Unix(), 0).Format("20060102")

	saltStr := ""
	if salt > 0 {
		saltStr = strconv.Itoa(salt)
	}

	nStr := saltStr + date + strconv.FormatInt(val, 10)

	t1 := time.Now()
	todayUnix := 86400 - today.Sub(t1).Seconds()
	n, _ := strconv.Atoi(nStr)

	n += int(todayUnix)

	nEncrypt := strconv.Itoa(EncodeId(uint64(n)))
	uid := ident + now + nEncrypt
	return uid
}

func EncryptUuid(insertKey string, date string, salt int) string {
	/*
	 ** 唯一uid编号生成逻辑
	 ** 日期 + 当天排号数量
	 */
	// 设置当天失效时间
	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 23, 59, 59, 59, time.Local)
	cmf.NewRedisDb().ExpireAt(insertKey, today)
	val := SetIncr(insertKey)

	saltStr := ""
	if salt > 0 {
		saltStr = strconv.Itoa(salt)
	}

	nStr := saltStr + date + strconv.FormatInt(val, 10)

	t1 := time.Now()
	todayUnix := 86400 - today.Sub(t1).Seconds()
	n, _ := strconv.Atoi(nStr)

	n += int(todayUnix)

	nEncrypt := strconv.Itoa(EncodeId(uint64(n)))
	uid := nEncrypt
	return uid
}

// 对参数签名，获取签名参数
func ResponseSign(params string, pk string) (sign string) {

	h := sha256.New()
	h.Write([]byte(params))
	// hashed := h.Sum(nil)
	// 加密生成sign
	// block 私钥

	block := []byte(pk)

	blocks, _ := pem.Decode(block)
	privateKey, err := x509.ParsePKCS8PrivateKey(blocks.Bytes)
	if err != nil {
		panic(err.Error())
	}

	digest := h.Sum(nil)
	s, _ := rsa.SignPKCS1v15(nil, privateKey.(*rsa.PrivateKey), crypto.SHA256, digest)
	sign = base64.StdEncoding.EncodeToString(s)

	return sign
}

/**
 * @Author return <1140444693@qq.com>
 * @Description 计算两经纬度的位置
 * @Date 2021/1/7 23:17:58
 * @Param
 * @return
 **/

func EarthDistance(lat1, lng1, lat2, lng2 float64) float64 {
	radius := 6371000.0
	rad := math.Pi / 180.0
	lat1 = lat1 * rad
	lng1 = lng1 * rad
	lat2 = lat2 * rad
	lng2 = lng2 * rad
	theta := lng2 - lng1
	dist := math.Acos(math.Sin(lat1)*math.Sin(lat2) + math.Cos(lat1)*math.Cos(lat2)*math.Cos(theta))
	return dist * radius / 1000
}

func MonthCount(year int, month int) (days int) {

	if month != 2 {
		if month == 4 || month == 6 || month == 9 || month == 11 {
			days = 30

		} else {
			days = 31
		}
	} else {
		if isLeapYear(year) {
			days = 29
		} else {
			days = 28
		}
	}

	return
}

func YearCount(year int) (days int) {
	if isLeapYear(year) {
		days = 366
	} else {
		days = 365
	}
	return
}

func isLeapYear(year int) bool { //y == 2000, 2004
	//判断是否为闰年
	if year%4 == 0 && year%100 != 0 || year%400 == 0 {
		return true
	}
	return false
}

func UploadFileInfo(dirName string) (filename string, filepath string) {

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
		// tempStr := "/" + current
		timeDir += current
	}

	fileUuid, err := uuid.NewV4()

	publicPath := "public/uploads/"

	filename = dirName + "/" + timeDir + "/" + cmfUtil.GetMd5(fileUuid.String()) + ".png"

	uploadPath := publicPath + dirName + "/" + timeDir + "/"

	_, err = os.Stat(uploadPath)
	if err != nil {
		os.MkdirAll(uploadPath, os.ModePerm)
	}

	filepath = publicPath + filename

	return
}

func GetFileExt(file string) string {

	if file == "" {
		return ""
	}

	filenameAll := path.Base(file)
	fileSuffix := path.Ext(file)
	filePrefix := strings.TrimSuffix(filenameAll, fileSuffix)

	return filePrefix
}

// 创建压缩包
func ZipCreate(inFiles []string, targetName string) (result []string, err error) {

	// 创建准备写入的文件
	result = make([]string, 0)
	fw, err := os.Create(targetName)
	defer fw.Close()
	if err != nil {
		return result,err
	}

	// 通过 fw 来创建 zip.Write
	zw := zip.NewWriter(fw)
	defer func() {
		// 检测一下是否成功关闭
		if err := zw.Close(); err != nil {
			return
		}
	}()

	var fr *os.File

	for _, fPath := range inFiles {

		file, err := os.Open(fPath)
		fi, err := file.Stat()

		// 通过文件信息，创建 zip 的文件信息
		fh, err := zip.FileInfoHeader(fi)
		if err != nil {
			return result,err
		}

		// 替换文件信息中的文件名
		fileName := strings.Split(fPath, "/")
		if len(fileName) < 1 {
			err = errors.New("文件路径不合法")
			return result,err
		}
		fh.Name = fileName[len(fileName)-1]

		// 这步开始没有加，会发现解压的时候说它不是个目录
		if fi.IsDir() {
			fh.Name += "/"
		}

		// 写入文件信息，并返回一个 Write 结构
		w, err := zw.CreateHeader(fh)
		if err != nil {
			return result,err
		}

		// 检测，如果不是标准文件就只写入头信息，不写入文件数据到 w
		// 如目录，也没有数据需要写
		if !fh.Mode().IsRegular() {
		}

		// 打开要压缩的文件
		fr, err = os.Open(fPath)

		if err != nil {
			return result,err
		}

		// 将打开的文件 Copy 到 w
		_, err = io.Copy(w, fr)
		if err != nil {
			result = append(result, err.Error())
			return result,err
		}

	}

	defer fr.Close()

	return result, nil

}

/*func GetUploadFileName(mid int) string {

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
		// tempStr := "/" + current
		timeDir += current
	}

	temPath := "default"

	if mid > 0 {
		temPath = "tenant/" + strconv.Itoa(mid)
	}

	insertKey := "mp_isv:filename:"+strconv.Itoa(mid)
	filename := EncryptUuid(insertKey,"",0)

	filepath := temPath + "/" + filename + ".png"

	return filepath

}
*/
