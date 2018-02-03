package main


import (
	"fmt"
	"net/http"
	"log"
	"localhtml"
)


func sayhelloName(w http.ResponseWriter, r *http.Request) {

	// This code fetches the html file I want
	data, err := localhtml.Asset("index.html")
	if err != nil {
		// Asset was not found.
	}


	fmt.Fprintf(w, string(data)) // send data to client side
}


func main() {
	http.HandleFunc("/", sayhelloName) // set router
	err := http.ListenAndServe(":3000", nil) // set listen port
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
