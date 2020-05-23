.DEFAULT_GOAL := help

help:
	@echo "${PROJECT}"
	@echo "${DESCRIPTION}"
	@echo ""
	@echo "	build - build the container based on Dockerfile (optional)"
	@echo "	push - push the container to DockerHub"
	@echo "	prowler - run prowler on audited account"
	@echo "	creds - print aws creds"

################ Project #######################
PROJECT ?= aws-security-toolbox
DESCRIPTION ?= Docker container for SecOps folks
DATE := $(shell date +%FT%T)
PROFILE_NAME ?= "zoph-audit"
################################################

build:
	@docker build -t ${PROJECT} .

push:
	@docker push zoph/${PROJECT}

prowler:
	@./ast.sh exec /opt/artifacts/prowler/prowler -b -s > /tmp/prowler-report-${DATE}.txt

creds:
	@aws-vault exec ${PROFILE_NAME} -- env | grep AWS
