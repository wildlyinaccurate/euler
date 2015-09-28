.PHONY: all build test

all: build test

build:
	cabal build

test:
	cat test/topic.yaml | bin/euler
