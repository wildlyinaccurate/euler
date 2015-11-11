PATH  := bin:$(PATH)
SHELL := /bin/bash

layouts := $(wildcard layouts/*.yaml)
assets := assets/
manifests := manifests/
mozart-configs := mozart-configs/

.PHONY: all clean build test

all: clean build test

test: $(layouts)
	@for layout in $^ ; do \
		echo "Building $$layout through stdin" && \
		cat $$layout | euler && \
		echo "Building $$layout as an argument" && \
		euler $$layout  ; \
	done

build:
	cabal build

clean:
	rm -rf $(assets) $(manifests) $(mozart-configs)
