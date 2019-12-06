linux-build: local-build docker-build
local-build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
docker-build:
	docker build -t  dalongrong/redix:1.10 -f Dockerfile-linux . 
