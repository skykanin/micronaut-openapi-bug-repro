
.PHONY: default
default: | help

.PHONY: build-mvn
build-mvn: ## Build project
	./mvnw clean install

.PHONY: run
run:
	java ${JAVA_OPTS} -Dmicronaut.config.files=application.yml -jar target/demo-0.1.jar

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'