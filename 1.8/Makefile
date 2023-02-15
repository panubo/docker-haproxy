NAME = panubo/haproxy
VERSION = $(shell sed -E -e '/^FROM/!d' -e 's/.*:(.*)$$/\1/' Dockerfile)
VERSION_MAJOR = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f1)
VERSION_MINOR = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f2)
VERSION_HOTFIX = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f3)

build: ## Builds docker image latest
	docker build --pull -t $(NAME):$(VERSION) .

push:
	docker tag $(NAME):$(VERSION) $(NAME):$(VERSION_MAJOR).$(VERSION_MINOR)
	docker push $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION_MAJOR).$(VERSION_MINOR)

clean:
	docker rmi $(NAME):$(VERSION)
	docker rmi $(NAME):$(VERSION_MAJOR).$(VERSION_MINOR)

test:
	TARGET_IMAGE=$(NAME):$(VERSION) TARGET_PORT=80 bats ../tests/

build-with-cache:
	# Used by CI to speed up build and test process
	docker pull $(NAME):$(VERSION)
	docker build -t $(NAME):$(VERSION) --cache-from $(NAME):$(VERSION) .

_ci_test:
	TARGET_IMAGE=panubo/haproxy:test TARGET_PORT=80 bats ../tests/

_ci_version:
	@echo "$(VERSION)"
	@echo "$(VERSION_MAJOR).$(VERSION_MINOR)"
