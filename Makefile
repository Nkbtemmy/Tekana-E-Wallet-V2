COMPOSE_FILE = docker-compose.dev.yaml
COMPOSE_FILE_PROD = docker-compose.yaml
APP = app
DATABASE_NAME = postgres_db 

dev: 
	docker compose -f $(COMPOSE_FILE) up --build
start: 
	docker compose -f $(COMPOSE_FILE_PROD) up --build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans

build:
	docker compose -f $(COMPOSE_FILE) build

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

exec:
	docker compose -f $(COMPOSE_FILE) exec $(DATABASE_NAME) <command>

generate-service:
	nest g service $(APP)

reset-db:
	docker compose -f $(COMPOSE_FILE) down -v $(DATABASE_NAME)

ps:
	docker compose -f $(COMPOSE_FILE) ps

clean:
	docker system prune --volumes --force

rebuild: down build

restart: down start

redev: down dev

default: up

restart: 
	down start
migration:
	docker compose  run app npx prisma migrate dev --name init
