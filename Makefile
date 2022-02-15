SUBDIRS := 1.8 2.0 2.2 2.5

.PHONY: build push clean version

build:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

push:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

clean:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

version:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

test:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done

build-with-cache:
	for dir in $(SUBDIRS); do \
		make TAG=$${dir//\//-} -C $$dir $(MAKECMDGOALS); \
	done
