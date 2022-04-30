PROJECT = falcon
ENV     = lab
SERVICE = api

DOCKER_UID  = $(shell id -u)
DOCKER_GID  = $(shell id -g)
DOCKER_USER = $(shell whoami)

base:
	@docker build -t ${PROJECT}-${ENV}-${SERVICE}:base -f docker/base/Dockerfile .
	@docker build --build-arg IMAGE=${PROJECT}-${ENV}-${SERVICE}:base -t ${PROJECT}-${ENV}-${SERVICE}:build -f docker/build/Dockerfile .

build:
	echo '${DOCKER_USER}:x:${DOCKER_UID}:${DOCKER_GID}::/app:/sbin/nologin' > passwd
	docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v "${PWD}"/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:build