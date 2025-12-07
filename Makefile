USER = $$(id -u)
VERSION ?= $$(git rev-parse --verify HEAD)
PHP_VERSION ?= 8.4

composer: ## composer install
	docker run --init -it --rm -u ${USER} -v "$$(pwd):/app" -w /app \
		composer:latest \
		composer install --optimize-autoloader --ignore-platform-reqs

composer-up: ## composer update
	docker run --init -it --rm -u ${USER} -v "$$(pwd):/app" -w /app \
		composer:latest \
		composer update --no-cache --ignore-platform-reqs

composer-dump: ## composer dump-autoload
	docker run --init -it --rm -u ${USER} -v "$$(pwd):/app" -w /app \
		composer:latest \
		composer dump-autoload

up: ## Run server
	VERSION=$(VERSION) USER=$(USER) \
		docker compose -f ./docker-compose.yml --profile serve up -d --remove-orphans

restart:
	VERSION=$(VERSION) USER=$(USER) \
		docker compose -f ./docker-compose.yml --profile serve restart

stop: ## Stop server
	docker compose -f ./docker-compose.yml --profile serve stop

down: stop
	docker compose -f ./docker-compose.yml down --remove-orphans

app:
	VERSION=$(VERSION) USER=$(USER) \
		docker compose -f ./docker-compose.yml run --rm -u $(USER) -w /src cli \
 		sh

run:
	VERSION=$(VERSION) USER=$(USER) \
		docker compose -f ./docker-compose.yml run --rm -u $(USER) -w /src cli \
 		php index.php

build:
	- VERSION=$(VERSION) USER=$(USER) docker compose -f ./docker-compose.yml build fpm
	- VERSION=$(VERSION) USER=$(USER) docker compose -f ./docker-compose.yml build cli
	- VERSION=$(VERSION) USER=$(USER) docker compose -f ./docker-compose.yml build angie

remove: _image_remove _container_remove

_image_remove:
	docker image rm -f \
		spx-cli \
		spx-fpm \
		spx-angie

_container_remove:
	docker rm -f \
		spx_cli \
		spx_fpm \
		spx_angie
