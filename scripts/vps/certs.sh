#!/bin/bash

WORKDIR=/tmp/certs
CERTS_DIR=/home/ubuntu/certs

DOCKER_IMAGE=certs_gen
DOCKER_CONTAINER=certs_gen

mkdir ${CERTS_DIR}

docker build -f ${WORKDIR}/Dockerfile --tag=${DOCKER_IMAGE} ${WORKDIR}
docker run --rm --name ${DOCKER_CONTAINER} -v ${CERTS_DIR}:/certs ${DOCKER_IMAGE}
docker rmi ${DOCKER_IMAGE}
docker container rm ${DOCKER_CONTAINER}

sudo chown ${USER}:${USER} ~/certs -R