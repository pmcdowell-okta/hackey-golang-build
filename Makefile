
build:
	rm -rf src/localhtml/*
	cd html ; \
	go-bindata -prefix "html/" -pkg localhtml -o ../src/localhtml/localhtml.go .
	go build ./...
	go install ./...

buildwindows:
	GOOS=windows GOARCH=386 go install ./...
	GOOS=windows GOARCH=386 go build ./...

buildlambda:
	GOOS=linux GOARCH=amd64 go install ./...
	GOOS=linux GOARCH=amd64 go build ./...

buildlinux:
        GOOS=linux GOARCH=amd64 go install ./...
        GOOS=linux GOARCH=amd64 go build ./...

run:
	bin/main

clean:
	rm -rf bin
	rm -rf pkg
	rm -rf src/localhtml/*





