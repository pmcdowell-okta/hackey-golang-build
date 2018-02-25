# I'm not an expert on Makefiles, but I found this useful
GOPATH=$(shell pwd)

setup:
	go get "github.com/gorilla/mux"
	go get "github.com/elazarl/go-bindata-assetfs"
	go get github.com/jteeuwen/go-bindata/...
	go get github.com/elazarl/go-bindata-assetfs/...

build:
#Make sure the src/localhtml directory exists
	mkdir -p src/localhtml

#Clear out directory
	rm -f src/localhtml/localhtml.go

#Go to HTML Directory and make go-bindata-assetfs package
	cd html ; \
	go-bindata-assetfs -prefix "html/" -pkg localhtml -o ../src/localhtml/localhtml.go ./...

#Do the regular build stuff

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

runlinux:
	docker run -it -p 3000:3000 -v `pwd`:/code  ubuntu /code/bin/linux_amd64/main

# I like to test and run in Docker
dockerrun:
	make rundocker
rundocker:
	#kill all containers called ubuntu
	docker ps | grep ubuntu | awk '{ print $$1 }' | xargs docker kill > /dev/null &
	docker ps | grep winer | awk '{ print $$1 }' | xargs docker kill > /dev/null &
	cd html ; \
	go-bindata-assetfs -prefix "html/" -pkg localhtml -o ../src/localhtml/localhtml.go ./...
	GOOS=linux GOARCH=amd64 go install ./...
	GOOS=linux GOARCH=amd64 go build ./...
	docker run -itd -p 3000:3000 -v `pwd`:/code  ubuntu /code/bin/linux_amd64/main


clean:
	rm -rf bin
	rm -rf pkg
	rm -rf src/localhtml/localhtml.go

test:
	go test ./...

#Continuous rebuild, anytime a file changes, the recompiles everything and launches it in Docker
monitor:
	fswatch -1 -e ".lock" -i "*.go" -i "*.html" ./src ./html
	docker stop  `docker ps -a -q`
	make build
	make buildlinux
	make runlinux
	make monitor

#This is nuts, and will require some homework and tweaking, but I was able to make the GOLANG windows
#binary run in Docker using Wine!
runwindows:
	make windowsrun
windowsrun:
	#kill all containers called ubuntu
	docker ps | grep winer | awk '{ print $$1 }' | xargs docker kill > /dev/null &
	docker ps | grep ubuntu | awk '{ print $$1 }' | xargs docker kill > /dev/null &
	cd html ; \
	go-bindata-assetfs -prefix "html/" -pkg localhtml -o ../src/localhtml/localhtml.go ./...
	GOOS=windows GOARCH=386 go install ./...
	GOOS=windows GOARCH=386 go build ./...
	docker run -itd -v `pwd`:/test -p 3000:3000  -e DISPLAY=$MYIP:0 oktaadmin/winer /bin/bash -c  "/usr/bin/wine /test/bin/windows_386/main.exe"
	


