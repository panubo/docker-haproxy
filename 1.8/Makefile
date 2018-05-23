NAME = panubo/haproxy
VERSION = $(shell sed -E -e '/^ENV BUILD_VERSION/!d' -e 's/^ENV BUILD_VERSION[= ](.*)/\1/' Dockerfile)
VERSION_MAJOR = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f1)
VERSION_MINOR = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f2)
VERSION_HOTFIX = $(shell echo $(VERSION) | sed -e 's/^v//' -e 's/-/./' | cut -d\. -f3)

help:
	@printf "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)\n"

build: ## Builds docker image latest
	docker build -t $(NAME):latest .

git-release: ## Creates git tag for release
	@echo "Make sure all changes are commited if this fails"
	[ "x$$(git status --porcelain 2> /dev/null)" == "x" ]
	git tag $(VERSION)
	git push --tags

docker-release: ## Builds and pushes docker image
	git checkout tags/$(VERSION)
	docker build -t $(NAME):$(VERSION) .
	for reg in docker.io; do \
		docker tag $(NAME):$(VERSION) $${reg}/$(NAME):$(VERSION); \
		docker tag $(NAME):$(VERSION) $${reg}/$(NAME):$(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_HOTFIX); \
		docker tag $(NAME):$(VERSION) $${reg}/$(NAME):$(VERSION_MAJOR).$(VERSION_MINOR); \
		docker push $${reg}/$(NAME):$(VERSION); \
		docker push $${reg}/$(NAME):$(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_HOTFIX); \
		docker push $${reg}/$(NAME):$(VERSION_MAJOR).$(VERSION_MINOR); \
	done
