#!/bin/bash

PROJECT_NAME="api"

HOST="domain.com"

DEPLOY_PATH="/home/ubuntu/apps/api/current"

CMD="ssh ubuntu@${HOST} \
     cd ${DEPLOY_PATH} &&  \
     docker-compose --project-name=${PROJECT_NAME} -f docker-compose.yml -f docker-compose.prd.yml"

function logs {
  ${CMD} logs -f app
}

case "$1" in
  logs)
      logs
      ;;
  *)
      echo "Usage: bash prd.sh logs"
      exit 1
  ;;
esac
