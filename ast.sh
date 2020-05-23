#!/bin/bash

# vgrenu@zoph.io
# https://zoph.io

################ Project #######################
PROJECT="aws-security-toolbox"
DESCRIPTION="Docker image for SecOps folks"
################################################

################ Config ########################
PROFILE_NAME="zoph-audit"
CONTAINER_IMAGE="aws-security-toolbox:latest"
GREEN='\033[0;32m'
NC='\033[0m' # No Color
export $(cat .env | xargs)
################################################

help() {
    echo "$PROJECT"
	echo "$DESCRIPTION"
	echo ""
	echo "	build - build the container image based on Dockerfile (update tools)"
    echo "	pull - pull the container image from Docker hub"
	echo "	login - log-in to the container image using interactive mode"
	echo "	exec [command] - exec your command using aws-vault remotly - using $PROFILE_NAME Profile"
	echo "	stop - stop the current running SecOps Container"
}

build() {
	docker build -t $PROJECT .
    echo "--> Container: $CONTAINER_IMAGE built successfully"
}

pull() {
	docker pull zoph/$PROJECT
    echo "--> Container: zoph/$CONTAINER_IMAGE pulled successfully"
    docker tag zoph/$CONTAINER_IMAGE zoph/$PROJECT:$PROJECT
}

login() {
	docker run -it -v ${HOME}/.aws:/root/.aws:ro --mount src="/tmp",target=/tmp,type=bind $CONTAINER_IMAGE /bin/bash
}

exec() {
    unset AWS_VAULT
    PROFILE_NAME="zoph-audit"
    export $(aws-vault exec $PROFILE_NAME -- env | grep ^AWS | xargs)
    printf "==> Running: ${GREEN}$@${NC} (aws-vault profile: $PROFILE_NAME)\n"
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
elif [[ "$1" == "pull"* ]]; then
    pull
elif [[ "$1" == "login"* ]]; then
    login
elif [[ "$1" == "exec"* ]]; then
    exec $2 $3 $4 $5 $6 $7 $8
elif [[ "$1" == "stop"* ]]; then
    stop
else
    help
fi
