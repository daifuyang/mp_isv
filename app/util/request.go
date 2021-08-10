/**
** @创建时间: 2021/7/31 11:51 下午
** @作者　　: return
** @描述　　:
 */
package util

import (
	"bytes"
	"compress/gzip"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
)

func Request(method string, url string, body io.Reader, header map[string]string) (int, []byte) {
	client := &http.Client{}
	switch method {
	case "get", "GET":
		method = "GET"
	case "post", "POST":
		method = "POST"
	case "put", "PUT":
		method = "PUT"
	case "delete", "DELETE":
		method = "POST"
	}
	r, err := http.NewRequest(method, url, body)
	if err != nil {
		fmt.Println("http错误", err)
	}

	r.Header.Add("Host", "")
	r.Header.Add("Connection", "keep-alive")
	r.Header.Add("Accept-Encoding", "gzip, deflate, br")
	r.Header.Add("Content-Length", "0")
	r.Header.Add("Cache-Control", "no-cache")
	for k, v := range header {
		r.Header.Add(k, v)
	}

	response, err := client.Do(r)

	if err != nil {
		fmt.Println(err.Error())
	}

	defer response.Body.Close()

	var data []byte = nil

	switch response.Header.Get("Content-Encoding") {
	case "gzip":
		reader, _ := gzip.NewReader(response.Body)
		for {
			buf := make([]byte, 1024)
			n, err := reader.Read(buf)
			if err != nil && err != io.EOF {
				panic(err)
			}
			if n == 0 {
				break
			}
			data = append(data, buf...)
		}
	default:
		data, err = ioutil.ReadAll(response.Body)
		if err != nil {
			fmt.Println("err", err.Error())
		}
	}

	index := bytes.IndexByte(data, 0)

	if index > 0 {
		data = data[:index]
	}

	return response.StatusCode, data
}

