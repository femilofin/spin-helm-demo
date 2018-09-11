#!/bin/bash

set -ex

APP_VERSION=`cat chart/spin-helm-demo/Chart.yaml | grep appVersion | awk '{print $2}'`
DOCKER_REPO=oluwafemi/spin-helm-demo

# docker login
docker login -u oluwafemi -p $DOCKER_PASSWORD

# build and tag
docker build -t ${DOCKER_REPO}:${APP_VERSION} .
docker tag ${DOCKER_REPO}:${APP_VERSION} ${DOCKER_REPO}:latest

# push
docker push ${DOCKER_REPO}:${APP_VERSION}
docker push ${DOCKER_REPO}:latest
