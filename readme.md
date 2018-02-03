# Hackey Golang Builder
#### For Golang Projects where you want to bake your HTML into your binary

This project is mostly for my own benefit, but others might find it useful.

I prefer to ship Golang projects with everything self contained in a single binary, mostly it is a bunch of:
* HTML
* Images
* Javascript
* Templates, you name it.

This is how I build my binaries for this. 

#### How do I use it:

1. Put everything you want to include in your package in the html directory
2. use `make build` to build you executable

Make users go-bindata to basically zip everything up, and creates a package
in the `src/localhtml` directory.

Then it uses:
* `go build ./...` Builds the packages
* `go install ./...` Builds the binaries

When you are done you should have a binary called main in the `bin` directory

If it is working properly you should be able to run it.
