.PHONY: build run

SHELL := /bin/sh
PKG_NAME=$(shell basename `pwd`)
GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

install:
	govendor add +e

build: vet \
		test
		go build

# Ex with version command: make run arg=version
run:
	go run main.go $(arg)

doc:
	godoc -http=:6060

fmt:
	go fmt

lint:
	golint ./... | grep -v vendor

dev:
	DEBUG=* go get && govendor add +e && go run server.go

test:

bench:
	go test ./... -bench=. | grep -v vendor

vet:
	go vet

commit:
	read -r -p "Commit message: " message; \
	git add .; \
	git commit -m "$$message" \

# note pushes to origin
push: build
	git push origin $(GIT_BRANCH)

cover:
	read -r -p "package to get coverage from: " package; \
	export ENVIRONMENT=testing && go test -v ./"$$package" --cover --coverprofile=coverage.out | grep -v vendor \
	go tool cover -html=coverage.out

prune:

	git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d && git remote prune origin
