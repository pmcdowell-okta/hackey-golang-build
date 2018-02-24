
build:
#Make sure the src/localhtml directory exists
	mkdir -p src/localhtml

#Clear out directory
	rm -f src/localhtml/localhtml.go

#Go to HTML Directory and make go-bindata package
	cd html ; \
	go-bindata -prefix "html/" -pkg localhtml -o ../src/localhtml/localhtml.go .

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
	
rundocker:
	make buildlinux
	docker run -it -p 3000:3000 -v `pwd`:/code  ubuntu /code/bin/linux_amd64/main

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
windowsrun:
	docker run -it -v `pwd`:/test -p 3000:9090  -e DISPLAY=$MYIP:0 winer /bin/bash -c  "/usr/bin/wine /test/bin/windows_386/main.exe"
	


