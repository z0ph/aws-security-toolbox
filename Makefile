.DEFAULT_GOAL := help

help:
	@echo "${PROJECT}"
	@echo "${DESCRIPTION}"
	@echo ""
	@echo "	build - build the container based on Dockerfile (optional)"
	@echo "	run - run the magic localy"
	@echo "	exec - exec using existing Docker container on DockerHub"
	@echo "	stop - stop the current running container"
	@echo "	vault-run - run the magic using aws-vault"

################ Project #######################
PROJECT ?= aws-security-toolbox
DESCRIPTION ?= Docker container for SecOps folks
################################################

################ Config ########################
AWS_REGION ?= eu-west-1
################################################

build:
	@docker build -t ${PROJECT} .

run:
	@docker run -it -v ${HOME}/.aws:/root/.aws:ro aws-security-toolbox:latest /bin/bash

exec:
	@docker run -it -v ${HOME}/.aws:/root/.aws:ro aws-security-toolbox:latest /bin/bash

stop:
	@docker stop `docker ps -q --filter ancestor=aws-security-toolbox:latest`

vault-run:
	@aws-vault exec $1 -- docker run -it -v ${HOME}/.aws:/root/.aws:ro aws-security-toolbox:latest /bin/bash 