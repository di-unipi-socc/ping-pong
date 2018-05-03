package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"

	"github.com/BurntSushi/toml"
)

type config struct {
	Port    int
	NextURL string
}

var conf config

func handler(w http.ResponseWriter, r *http.Request) {
	var newURL = "http://" + conf.NextURL + fmt.Sprintf("%v", r.URL)

	resp, err := http.Get(newURL)
	if err != nil {
		log.Print("Request error: ", err)
		return
	}
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)
	fmt.Fprintf(w, "%s", body)

	log.Print("Receive request ", r.URL, " redirect to ", newURL)
}

func main() {
	_, err := toml.DecodeFile("conf.toml", &conf)
	if err != nil {
		log.Print("Cannot load configuration file - ", err)
		// load default
		conf.Port = 8080
		conf.NextURL = "127.0.0.1:8081"
	}
	log.Print("Load ", conf)

	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":"+strconv.Itoa(conf.Port), nil))
}
