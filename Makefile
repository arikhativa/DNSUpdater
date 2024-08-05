BINARY_NAME=dns-updater
BUILD_DIR=bin


all: build


build:
	@echo "Building the project..."
	@go build -o $(BUILD_DIR)/$(BINARY_NAME) cmd/dns-updater/main.go

test:
	@echo "Running tests..."
	@go test ./...

clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)/$(BINARY_NAME)


.PHONY: all build test clean 