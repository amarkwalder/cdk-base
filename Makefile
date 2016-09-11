
VERSION = 0.1.1 

.DEFAULT_GOAL := build

clean:
	-docker rmi amarkwalder/cdk-base:${VERSION}
	-docker rmi amarkwalder/cdk-base:latest
.PHONY: clean

build:
	docker build -t amarkwalder/cdk-base:${VERSION} .
.PHONY: build

tag:
	docker pull amarkwalder/cdk-base:${VERSION}
	docker tag amarkwalder/cdk-base:${VERSION} amarkwalder/cdk-base:latest
	docker push amarkwalder/cdk-base:latest
.PHONY: tag

run: build
	docker run -it --rm amarkwalder/cdk-base:${VERSION}
.PHONY: run
