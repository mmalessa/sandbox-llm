DC = docker compose

.DEFAULT_GOAL = help
APP_UID     ?= $(shell id -u)
#-----------------------------------------------------------------------------------------------------------------------

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: build
build: ## build image
	@$(DC) build

.PHONY: up
up: ## Up all
	@$(DC) up -d

.PHONY: down
down: ## Down all
	@$(DC) down

.PHONY: logs
logs: ## Ollama logs
	@$(DC) logs -f ollama

# https://ollama.com/library
.PHONY: fetch-models ## Download + prepare Ollama models
fetch-models:
	@$(DC) exec -it ollama bash /scripts/fetch-models.sh

.PHONY: list-models ## Download Ollama models
list-models:
	@$(DC) exec -it ollama ollama list

