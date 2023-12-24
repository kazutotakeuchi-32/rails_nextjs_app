build:
	docker-compose build
up:
	docker-compose up --build
down:
	docker-compose down
stop:
	docker-compose stop
api: 
	docker-compose exec api bash
front:
	docker-compose exec front bash
web:
	docker-compose exec web bash
db: 
	docker-compose exec db bash
prod_build:
	docker-compose -f docker-compose.prod.yml build
prod_up:
	docker-compose -f docker-compose.prod.yml up --build
prod_down:
	docker-compose -f docker-compose.prod.yml down
prod_stop:
	docker-compose -f docker-compose.prod.yml stop
ssl_build:
	docker-compose -f docker-compose.ssl.yml build
ssl_up:
	docker-compose -f docker-compose.ssl.yml up  --build
ssl_down:
	docker-compose -f docker-compose.ssl.yml down
ssl_stop:
	docker-compose -f docker-compose.ssl.yml stop

