all: build

build:
	docker compose up --build

re:
	docker compose down -v
	docker compose build --no-cache
	docker compose up

up:
	docker compose up

down:
	docker compose down

fclean:
	docker compose down -v --rmi all

logs:
	docker compose logs -f

ps:
	docker compose ps

.PHONY: all build re up down fclean logs ps
