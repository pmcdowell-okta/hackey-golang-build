package main


import (
	"fmt"
	"net/http"
	"log"
	"localhtml"
	//"os"
	"github.com/gorilla/mux"
)

func boom(w http.ResponseWriter, r *http.Request) {
	fmt.Println("called custom route")

}

func catchAllHtml(w http.ResponseWriter, r *http.Request) {

	// This code fetches the html file I want. Pulling from Assets that are compiled in
	data, err := localhtml.Asset(r.RequestURI[1:])
	if err != nil {
		// Asset was not found.
		logwrapper("File not found: "+r.RequestURI[1:])
	} else {
		fmt.Fprintf(w, string(data)) // send data to client side
	}
}


func main() {

	r := mux.NewRouter()

	//You can put specific routes in here
	r.HandleFunc("/customroute", boom)

	//If no other route is found, then look in the Asset's build in
	r.PathPrefix("/").HandlerFunc(catchAllHtml)

	http.Handle("/", r)

	err := http.ListenAndServe(":3000", nil) // set listen port
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func logwrapper ( logline string ) {
	fmt.Println(logline)
}
