TEST_FILES=samples
EXEC_NAME=zeep

all:: clean build run

clean::
	rm -f ./bin/*
	rm -f ./$(TEST_FILES)/*.zip
	rm -f ./$(TEST_FILES)/*.gz

build:: main.go
	go build -o ./bin/$(EXEC_NAME) main.go

publish:: main.go clean
	GOOS=linux   GOARCH=amd64 go build -o ./bin/$(EXEC_NAME)-linux-x64 main.go
	GOOS=linux   GOARCH=386   go build -o ./bin/$(EXEC_NAME)-linux-x86 main.go
	GOOS=linux   GOARCH=arm   go build -o ./bin/$(EXEC_NAME)-linux-arm main.go
	GOOS=darwin  GOARCH=amd64 go build -o ./bin/$(EXEC_NAME)-darwin-x64 main.go
	GOOS=darwin  GOARCH=386   go build -o ./bin/$(EXEC_NAME)-darwin-x86 main.go
	GOOS=windows GOARCH=amd64 go build -o ./bin/$(EXEC_NAME)-windows-x64 main.go
	GOOS=windows GOARCH=386   go build -o ./bin/$(EXEC_NAME)-windows-x86 main.go

run::
	./bin/$(EXEC_NAME) $(TEST_FILES)/*