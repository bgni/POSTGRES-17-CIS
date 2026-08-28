CONTAINER_ENGINE ?= docker
COMPOSE = $(CONTAINER_ENGINE) compose -f tests/container/compose.yml

.PHONY: test-container test-docker test-podman clean-container

test-container:
	$(COMPOSE) up -d --build postgres17
	$(COMPOSE) exec -T postgres17 /workspace/tests/container/run.sh

test-docker:
	$(MAKE) test-container CONTAINER_ENGINE=docker

test-podman:
	$(MAKE) test-container CONTAINER_ENGINE=podman

clean-container:
	$(COMPOSE) down -v --remove-orphans
