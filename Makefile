include .env.make

# .env.make 파일에서 ENV값에 따라 dev, prod 환경을 구분
DOCKER_COMPOSE=docker-compose
DOCKER_COMPOSE_FILE=$(if $(filter prod,$(ENV)),$(PROD_COMPOSE_FILE),$(DEV_COMPOSE_FILE))
CMD=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: dev-build dev-up dev-down prod-build prod-up prod-down prod-push prod-pull

build: ## Build docker images
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build $(CMD)

up:  ## Run docker containers
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d $(CMD)

down:  ## Stop docker containers
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down $(CMD)

push:  ## Push docker images
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) push

pull:  ## Pull docker images
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) pull

logs:  ## Show logs
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f $(CMD)

exec: CMD=$(filter-out $@,$(MAKECMDGOALS))
exec:  ## Exec container
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) exec $(CMD)

restart: ## Restart container
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) restart $(CMD)

