.PHONY: all clean build run

TEST_FILES=files
EXEC_NAME=zeep

all: clean build run

clean:
	rm -f $(EXEC_NAME)
	rm -f ./$(TEST_FILES)/*.zip
	rm -f ./$(TEST_FILES)/*.gz

build: main.go
	go build -o ./bin/$(EXEC_NAME) main.go

publish: main.go
	GOOS="linux" GOARCH="amd64" go build -o ./bin/$(EXEC_NAME) main.go
	GOOS="windows" GOARCH="amd64" go build -o ./bin/$(EXEC_NAME).exe main.go

run:
	./bin/$(EXEC_NAME) $(TEST_FILES)/*