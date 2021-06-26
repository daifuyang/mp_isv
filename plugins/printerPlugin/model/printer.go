/**
** @创建时间: 2021/4/11 4:02 下午
** @作者　　: return
** @描述　　:
 */
package model

import (
	"math"
	"strings"
)

type Printer struct {
	Type string `json:"type"`
}

type typeContent struct {
	Content string `json:"content"`
	Count   int    `json:"count"`
}

func (model Printer) FormatPrinter(order []map[string]string, mm string) string {

	var content string

	// 定义标题的长度
	tLen := 16 // 16个字符 （8个字符）
	cLen := 6  // 8个字符 （4个字符）
	FLen := 10 // 8个字符 （4个字符）

	if mm == "80mm" {
		// 定义标题的长度
		tLen = 24 // 24个字符 （8个字符）
		cLen = 12 // 16个字符 （4个字符）
		FLen = 20 // 16个字符 （4个字符）
	}

	for _, v := range order {

		// 统计标题总长度
		// 标题所在位置索引
		tTotal, titleArr := new(Printer).typesetting(v["title"], tLen)
		_, countArr := new(Printer).typesetting(v["count"], cLen)
		_, totalArr := new(Printer).typesetting(v["total"], FLen)

		// 判断需要打印的行数
		pLine := math.Floor(float64(tTotal / tLen))

		for i := 0; i < int(pLine)+1; i++ {

			title := titleArr[i].Content
			titleCount := titleArr[i].Count

			// 后补空白
			var indent []string
			if titleCount < tLen {
				indentLen := tLen - titleCount

				for i := 0; i < indentLen; i++ {
					indent = append(indent, " ")
				}
				title += strings.Join(indent, "")
			}

			if i == 0 {

				countContent := new(Printer).Indent(countArr, cLen, "X")

				title += countContent

				totalContent := new(Printer).Indent(totalArr, FLen, "￥")

				title += totalContent

			}

			content += "<L><BOLD>" + title + "</BOLD></L><BR>"
		}

	}

	return content

}

// 转换文本为格式化换行的数组
func (model Printer) typesetting(s string, limit int) (int, map[int]*typeContent) {
	// 递归全部标题
	total := 0

	var out = make(map[int]*typeContent, 0)

	for _, vt := range s {
		// 获取当前单个文字

		s := string(vt)
		sLen := 1

		if len(s) == 3 {
			sLen = 2
		}

		total += sLen

		// 获取文字所在的行数
		pLine := math.Floor(float64(total / limit))

		// 获取原来的内容
		if out[int(pLine)] == nil {
			out[int(pLine)] = new(typeContent)
		}

		titleContent := out[int(pLine)].Content
		titleContent += s

		titleCount := out[int(pLine)].Count
		titleCount += sLen

		// 放到对应的位置
		out[int(pLine)] = &typeContent{
			Content: titleContent,
			Count:   titleCount,
		}
	}

	return total, out
}

// 获取标题前置所需添加的空格格式化文本
func (model Printer) Indent(textArr map[int]*typeContent, limit int, symbol string) string {
	// 获取购买数量
	var tempCount []typeContent

	var countContent string
	var countCount int

	for _, v := range textArr {
		tempCount = append(tempCount, *v)
		countContent += v.Content
		countCount += v.Count

	}

	symbolLen := 0
	for _, v := range symbol {
		// 获取当前单个文字
		s := string(v)
		if len(s) == 3 {
			symbolLen += 2
		} else {
			symbolLen += 1
		}
	}

	cLenTem := countCount + symbolLen

	var indent []string
	// 数量的长度小于限制总长度
	if cLenTem < limit {
		indentLen := limit - cLenTem
		for i := 0; i < indentLen; i++ {
			indent = append(indent, " ")
		}
	}

	countContent = strings.Join(indent, "") + symbol + countContent

	return countContent
}
