WORK_DIR:=$(shell readlink -f $(dir $(lastword $(MAKEFILE_LIST))))

VERSION?=68.0.3440.84

default:
	cd $(WORK_DIR)
	docker build -t ${USER}/chromium_browser:$(VERSION) --build-arg VERSION=$(VERSION) \
	             --build-arg NAME=${USER} --build-arg UID=$(shell id -u) \
	             --build-arg GID=$(shell id -g) .
