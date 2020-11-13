#!/bin/bash

# vgrenu@zoph.io
# https://zoph.me

################ Project #######################
PROJECT="aws-security-toolbox"
DESCRIPTION="Docker image for SecOps folks"
################################################

################ Config ########################
CONTAINER_IMAGE="aws-security-toolbox:latest"
GREEN='\033[0;32m'
NC='\033[0m' # No Color
export $(cat .env | xargs)
################################################

help() {
    echo "${PROJECT}"
    echo "${DESCRIPTION}"
    echo ""
    echo "	build - build the container image based on Dockerfile (update tools)"
    echo "	pull - pull the container image from Docker hub"
    echo "	login - log-in to the container image using interactive mode"
    echo "	exec [command] - exec your command using aws-vault remotly"
    echo "	stop - stop the current running SecOps Container"
}

build() {
    docker build -t ${PROJECT} .
    echo "--> Container: ${CONTAINER_IMAGE} built successfully"
}

pull() {
    docker pull zoph/${PROJECT}
    echo "--> Container: zoph/${CONTAINER_IMAGE} pulled successfully"
    docker tag zoph/${CONTAINER_IMAGE} zoph/${PROJECT}:${PROJECT}
}

login() {
    docker run -it \
        -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
        -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
        -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
        -v ${HOME}/.aws:/root/.aws:ro --mount src="/tmp",target=/tmp,type=bind ${CONTAINER_IMAGE} /bin/bash
}

exec() {
    unset AWS_VAULT
    export $(aws-vault exec ${AWS_PROFILE} --assume-role-ttl=1h -- env | grep ^AWS | xargs)
    # For troubleshooting, uncomment below :)
    # echo ${AWS_ACCESS_KEY_ID}
    # echo ${AWS_SECRET_ACCESS_KEY}
    # echo ${AWS_SESSION_TOKEN}
    # echo ${AWS_SECURITY_TOKEN}
    printf "==> Running: ${GREEN}$@${NC} (aws-vault profile: ${AWS_PROFILE})\n"
    docker run -it \
        -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
        -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
        -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN} \
        -e AWS_SECURITY_TOKEN=${AWS_SECURITY_TOKEN} \
        ${CONTAINER_IMAGE} "$@"
}

stop() {
    docker stop `docker ps -q --filter ancestor=${CONTAINER_IMAGE}`
    echo "--> Container: ${CONTAINER_IMAGE} stopped successfully"
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
