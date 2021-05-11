/**
** @创建时间: 2021/3/12 2:10 下午
** @作者　　: return
** @描述　　:
 */
package main

import (
	"fmt"
	"github.com/nfnt/resize"
	"github.com/shopspring/decimal"
	"image"
	"image/draw"
	"image/png"
	"os"
	"testing"
)

func Test_Image(t *testing.T) {

	bgFile, _ := os.Open("bg.png")
	bgImg, _ := png.Decode(bgFile)
	defer bgFile.Close()

	qrcodeFile, _ := os.Open("qrcode.png")
	qrcodeImg, _ := png.Decode(qrcodeFile)
	defer qrcodeFile.Close()

	// 缩小二维码
	qrcodeImg = resize.Resize(350, 350, qrcodeImg, resize.Lanczos3)

	offset := image.Pt(210, 430)
	b := bgImg.Bounds()
	m := image.NewRGBA(b)
	draw.Draw(m, b, bgImg, image.Point{}, draw.Src)
	draw.Draw(m, qrcodeImg.Bounds().Add(offset), qrcodeImg, image.Point{}, draw.Over)

	imgw, _ := os.Create("out.png")
	png.Encode(imgw, m)
	defer imgw.Close()

}

func Test_123(t *testing.T)  {
	refund := decimal.NewFromFloat(100.21).Round(2).Mul(decimal.NewFromInt(100)).IntPart()
	fmt.Println("refund",refund)
}
