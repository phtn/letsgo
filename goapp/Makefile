
r:
	nodemon --watch './**/*.go' -e 'go' --signal SIGTERM --exec 'go' run cmd/goapp/main.go

b:
	@go build -o build/goapp cmd/goapp/main.go && \
		clear && ./build/goapp

l:
	GOOS=linux GOARCH=amd64 go build -o build/goapp cmd/goapp/main.go

y:
	go mod tidy

t:
	go test ./tests/...
