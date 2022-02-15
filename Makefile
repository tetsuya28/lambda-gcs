.PHONY: build
build:
	GOOS=linux go build -o bin/main main.go
