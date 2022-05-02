PROJECT = falcon
ENV     = lab
SERVICE = api

DOCKER_UID  = $(shell id -u)
DOCKER_GID  = $(shell id -g)
DOCKER_USER = $(shell whoami)

passwd_file:
	@echo '${DOCKER_USER}:x:${DOCKER_UID}:${DOCKER_GID}::/app:/sbin/nologin' > passwd

base:
	@docker build -t ${PROJECT}-${ENV}-${SERVICE}:base -f docker/base/Dockerfile .
	@docker build --build-arg IMAGE=${PROJECT}-${ENV}-${SERVICE}:base -t ${PROJECT}-${ENV}-${SERVICE}:build -f docker/build/Dockerfile .
	@docker build -t ${PROJECT}-${ENV}-${SERVICE}:snyk -f docker/snyk/Dockerfile .

snyk_code: passwd_file
	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v ${PWD}/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:snyk auth ${SNYK_TOKEN}
	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v ${PWD}/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:snyk code test

build: passwd_file
	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v "${PWD}"/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:build

snyk_test: build
	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v ${PWD}/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:snyk auth ${SNYK_TOKEN}
#	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v ${PWD}/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:snyk monitor
	@docker run --rm -u "${DOCKER_UID}":"${DOCKER_GID}" -v ${PWD}/passwd:/etc/passwd:ro -v "${PWD}"/app:/app ${PROJECT}-${ENV}-${SERVICE}:snyk test