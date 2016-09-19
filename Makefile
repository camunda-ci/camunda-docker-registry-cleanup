# image settings for the docker image name, tags and
# container name while running
IMAGE_NAME=registry.camunda.com/camunda-docker-registry-cleanup
TAGS=latest
NAME=registry-cleanup

# parent image name
FROM=$(shell head -n1 Dockerfile | cut -d " " -f 2)
# the first tag and the remaining tags split up
FIRST_TAG=$(firstword $(TAGS))
# the image name which will be build
IMAGE=$(IMAGE_NAME):$(FIRST_TAG)
# options to use for running the image, can be extended by FLAGS variable
OPTS=--name $(NAME) -t $(FLAGS)
# the docker command which can be configured by the DOCKER_OPTS variable
DOCKER=docker $(DOCKER_OPTS)

# default build settings
REMOVE=true
FORCE_RM=true
NO_CACHE=false

# build the image for the first tag and tag it for additional tags
build:
	$(DOCKER) build --rm=$(REMOVE) --force-rm=$(FORCE_RM) --no-cache=$(NO_CACHE) -t $(IMAGE) .

# pull image from registry
pull:
	-$(DOCKER) pull $(IMAGE)

# pull parent image
pull-from:
	$(DOCKER) pull $(FROM)

# push container to registry
push:
	@for tag in $(TAGS); do \
		$(DOCKER) push $(IMAGE_NAME):$$tag; \
	done

# pull parent image, build image and push to repository
publish: pull-from pull build push

# run container
run:
	$(DOCKER) run --rm $(OPTS) $(IMAGE)

# start interactive container with bash
bash:
	$(DOCKER) run --rm --entrypoint=/bin/bash -it $(OPTS) $(IMAGE)

# remove container by name
rmf:
	-$(DOCKER) rm -f $(NAME)

# remove image with all tags
rmi:
	@for tag in $(TAGS); do \
		$(DOCKER) rmi $(IMAGE_NAME):$$tag; \
	done

.PHONY: build pull pull-from push publish run bash rmf rmi export
