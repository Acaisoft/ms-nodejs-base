all: clean secrets_decrypt run

PROJECT = ms-nodejs-basic
TAG ?= dev

clean:
	# If they aren't found, don't error out
	-docker-compose down
	-docker-compose rm -f

logs:
	docker-compose logs -f app

secrets_decrypt:
	scripts/decrypt.sh

secrets_encrypt:
	scripts/encrypt.sh

run:
	docker-compose up --build -d --remove-orphans

restart:
	docker-compose restart app

shell:
	docker-compose exec app bash

test:
	docker-compose exec app npm run test

build_container:
	docker build -t ${PROJECT}:${TAG} .

#Update docker push command!!!
push: docker_login
	docker push ${PROJECT}:${TAG}

#Update docker login command!!!
docker_login:
	docker login #Update login command!!!

run_dev:
	npm install
	npm run start-dev
