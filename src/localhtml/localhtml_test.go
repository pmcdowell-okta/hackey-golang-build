package localhtml

import ("testing"

	"fmt"
)

func Test(t *testing.T) {

	data, err := Asset("index.html")
	if err != nil {
		// Asset was not found.
	}

	//fmt.Println(data)
	fmt.Println(string(data))

}