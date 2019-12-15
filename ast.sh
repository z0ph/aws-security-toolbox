#!/bin/bash

# victor.grenu@gmail.com
# https://zoph.me

################ Project #######################
PROJECT="AWS-Security-Toolbox (AST)"
DESCRIPTION="Docker container image for SecOps folks"
################################################

################ Config ########################
AWS_REGION="eu-west-1"
PROFILE_NAME="zoph"
CONTAINER_IMAGE="aws-security-toolbox:latest"
GREEN='\033[0;32m'
NC='\033[0m' # No Color
################################################

help() {
    echo "$PROJECT"
	echo "$DESCRIPTION"
	echo ""
	echo "	build - build the container image based on Dockerfile (update tools)"
	echo "	login - log-in to the container image using interactive mode"
	echo "	exec [command] - exec your command using aws-vault remotly"
	echo "	stop - stop the current running SecOps Container"
}

build() {
	docker build -t $PROJECT .
    echo "--> Container: $CONTAINER_IMAGE built successfully"
}

login() {
	docker run -it -v ${HOME}/.aws:/root/.aws:ro --mount src="/tmp",target=/tmp,type=bind $CONTAINER_IMAGE /bin/bash
}

exec() {
    unset AWS_VAULT
    export $(aws-vault exec $PROFILE_NAME --assume-role-ttl=1h -- env | grep ^AWS | xargs)
    # For troubleshooting, uncomment below :)
    # echo $AWS_ACCESS_KEY_ID
    # echo $AWS_SECRET_ACCESS_KEY
    # echo $AWS_SESSION_TOKEN
    # echo $AWS_SECURITY_TOKEN
    printf "==> Running: ${GREEN}$@${NC}\n"
    docker run -it \
        -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
        -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
        -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
        -e AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
        $CONTAINER_IMAGE "$@"
}

stop() {
	docker stop `docker ps -q --filter ancestor=$CONTAINER_IMAGE`
	echo "--> Container: $CONTAINER_IMAGE stopped successfully"
}

if [[ "$1" == "build"* ]]; then
    build
elif [[ "$1" == "login"* ]]; then
    login
elif [[ "$1" == "exec"* ]]; then
    exec $2 $3 $4 $5 $6 $7 $8
elif [[ "$1" == "stop"* ]]; then
    stop
else
    help
fi
