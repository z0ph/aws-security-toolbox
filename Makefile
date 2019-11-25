.DEFAULT_GOAL := help

help:
	@echo "${PROJECT}"
	@echo "${DESCRIPTION}"
	@echo ""
	@echo "	run - run the magic"

################ Project #######################
PROJECT ?= aws-security-toolbox
DESCRIPTION ?= Docker container for SecOps Professionals
################################################

################ Config ########################
AWS_REGION ?= eu-west-1
################################################

run:
	@docker run -it -v $HOME/.aws:/root/.aws:ro z0ph/aws-sec-toolbox:latest /bin/bash

stop:
	@docker 
