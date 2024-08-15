package main

import (
	"fmt"
	"io"
	"net/http"
	"time"
)

const (
	ipCheckURL  = "https://api.ipify.org"
	updateURL   = "https://freedns.afraid.org/dynamic/update.php?czlQQm5tcU8wQ2tiaGo4RWlrRmc6MjI5OTM5MzI="
	ipCacheFile = "current_ip.txt"
)

func getCurrentIP() (string, error) {
	resp, err := http.Get(ipCheckURL)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	ip, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	return string(ip), nil
}

func updateIP() error {
	resp, err := http.Get(updateURL)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	responseData, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	fmt.Println("Update response:", string(responseData))
	return nil
}

func main() {
	currentIP, err := getCurrentIP()
	if err != nil {
		fmt.Println("Error fetching current IP:", err)
		return
	}

	updateIP()

	for true {
		time.Sleep(time.Minute)
		tmpIP, err := getCurrentIP()
		if err != nil {
			fmt.Println("Error fetching current IP:", err)
			return
		}
		if currentIP != tmpIP {
			currentIP = tmpIP
			updateIP()
		}
	}

}
