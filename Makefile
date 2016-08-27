
VERSION = latest

.DEFAULT_GOAL := build

clean:
	docker rmi amarkwalder/cdk-base:${VERSION}
.PHONY: clean

build:
	docker build -t amarkwalder/cdk-base:${VERSION} .
.PHONY: build

run: build
	docker run -it --rm amarkwalder/cdk-base:${VERSION}
.PHONY: run
