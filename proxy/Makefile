PACKAGES=$(shell go list ./... | grep -v /vendor/)
RACE := $(shell test $$(go env GOARCH) != "amd64" || (echo "-race"))

help:
	@echo 'Available commands:'
	@echo
	@echo 'Usage:'
	@echo '    make deps     		Install go deps.'
	@echo '    make build    		Compile the project.'
	@echo '    make restore  		Restore all dependencies.'
	@echo '    make clean    		Clean the directory tree.'
	@echo

test: ## run tests, except integration tests
	@go test ${RACE} ${PACKAGES}

deps:
	go get -u github.com/BurntSushi/toml

build:
	@echo "Compiling..."
	@mkdir -p ./bin
	@go build -i -o ./bin/proxy
	@echo "All done! The binaries is in ./bin let's have fun!"

vet: ## run go vet
	@test -z "$$(go vet ${PACKAGES} 2>&1 | grep -v '*composite literal uses unkeyed fields|exit status 0)' | tee /dev/stderr)"

ci: vet test

restore:
	@dep ensure

clean:
	@rm -frv bin
