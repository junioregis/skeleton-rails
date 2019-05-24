#!/bin/bash

PATH=/home/${USER}/certs

mkdir ${PATH}

#ARCH=""
ARCH="--file docker-compose.prd.arm32v7.yml"

CMD="docker-compose --file docker-compose.yml ${ARCH}"

${CMD} build certs_generator
${CMD} run --rm certs_generator
