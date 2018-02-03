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

#### test

There is a test in the src/localtest directory to make sure you can read the local filesystem, but it is very basic

You can go the the `src/localhtml` directory and run `go test`,
or you can run the test globally using `make test`

#### Try it on Docker

If you want to try this code on Docker, you can run:

*   `make buildlinux`
*   `make dockerrun`

This will spin up the example on a Ubuntu image in Docker, and open port 3000 so you can try it out

#### There is also an option to build for Windows

* `make buildwindows`