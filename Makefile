# Settings
include Makefile.cfg

#defaults
APP_NAME ?= default_app_name
IMAGE_NAME ?= default_image_name
VERSION ?= latest
DOCKER_REPO ?= default_repo_name

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# DOCKER

# builds
build: ## build tagged image
	docker build $(BUILD_ARGS) -t $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION) .

run-test: ## test run container with vars and ports and remove it after stop
	docker run -i -t --rm $(RUN_ENVS) $(RUN_PORTS) --name=$(APP_NAME):$(VERSION) $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

run: ## start production container in background
	docker run -d $(RUN_ENVS) $(RUN_PORTS) $(VOLUMES) $(RESTART_POLICY) --name=$(APP_NAME)-$(VERSION) $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

# runs
ps: ## prints docker ps for current container
	docker ps -a -f "name=$(APP_NAME)"

up: build run ## alias for build and run

stop: ## stops container
	docker stop $(APP_NAME)-$(VERSION)

rm: ## removes container
	docker rm $(APP_NAME)-$(VERSION)

rmi: ## removes image
	docker rmi $(DOCKER_REPO)/$(IMAGE_NAME):$(VERSION)

clean: stop rm ## stop and remove container

clean-all: stop rm rmi ## stops and removes container and image

logs: ## show logs for working container
	docker logs -f $(APP_NAME)-$(VERSION)
