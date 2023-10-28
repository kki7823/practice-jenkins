GIT_TAG               := $(shell git describe --exact-match --tags --abbrev=0  2> /dev/null || echo untagged)
VERSION ?=latest
REGISTRY_HOST ?= kki7823/sample-webapp
APP_NAME ?= "webapp"

ifeq ($(VERSION),latest)
VERSION := $(GIT_TAG)
endif

IMG ?=$(REGISTRY_HOST)/$(APP_NAME):$(VERSION)
CTR_CLI ?=podman

fmt:
	go fmt ./...

vet:
	go vet ./...

.PHONY: gobuild
gobuild: fmt vet
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o bin/$(APP_NAME) ./*.go

.PHONY: build
build:
	$(CTR_CLI) build --no-cache -t $(IMG) --file=Dockerfile .

.PHONY: push
push:
	$(CTR_CLI) push $(IMG)