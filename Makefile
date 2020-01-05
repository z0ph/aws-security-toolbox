.DEFAULT_GOAL := help

help:
	@echo "${PROJECT}"
	@echo "${DESCRIPTION}"
	@echo ""
	@echo "	build - build the container based on Dockerfile (optional)"
	@echo "	push - push the container to DockerHub"

################ Project #######################
PROJECT ?= aws-security-toolbox
DESCRIPTION ?= Docker container for SecOps folks
################################################

build:
	@docker build -t ${PROJECT} .

push:
	@docker push zoph/${PROJECT}