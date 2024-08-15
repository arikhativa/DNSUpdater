export BINARY_NAME=dns-updater
BUILD_DIR=bin
DOCKER_USERNAME=arikhativa

all: build

build:
	go build -o $(BUILD_DIR)/$(BINARY_NAME) src/main.go

test: build
	./$(BUILD_DIR)/$(BINARY_NAME)

docker-build:
	docker build -t $(BINARY_NAME) .

docker-run:
	docker run -d -it --name $(BINARY_NAME) $(BINARY_NAME)

docker-stop:
	docker stop  $(BINARY_NAME) 

docker-push:
	docker tag $(BINARY_NAME) $(DOCKER_USERNAME)/$(BINARY_NAME)
	docker push $(DOCKER_USERNAME)/$(BINARY_NAME)
