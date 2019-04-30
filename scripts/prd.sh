#!/bin/bash

export CURRENT_UID="$(id -u):$(id -g)"

PROJECT_NAME="api"

SERVICES="app bundle redis db selenium server portainer proxy letsencrypt"

ARCH=""
#ARCH="--file docker-compose.prd.arm32v7.yml"

CMD="docker-compose --project-name=${PROJECT_NAME} \
                    --file docker-compose.yml \
                    --file docker-compose.prd.yml ${ARCH}"

CAPISTRANO_CMD="docker-compose --project-name=skeleton_rails \
                               --file docker-compose.yml \
                               --file docker-compose.dev.yml \
                               run --rm app cap production"

function setup {
  ${CMD} exec -d app rake db:setup
}

function migrate {
  ${CMD} exec -d app rake db:migrate
}

function build {
  ${CMD} build --pull ${SERVICES}
  ${CMD} pull ${SERVICES}
}

function start {
  ${CMD} up -d --remove-orphans ${SERVICES}
}

function stop {
  ${CMD} down
}

function restart {
  stop
  start
}

function first-deploy {
  ssh ubuntu@domain.com 'bash -s' < echo -e "\nexport RAILS_MASTER_KEY=$(cat src/config/master.key)" | sudo tee -a /etc/environment
  ssh ubuntu@domain.com 'bash -s' < sudo source /etc/environment

  ${CAPISTRANO_CMD} deploy:init
}

function deploy {
  ${CAPISTRANO_CMD} deploy
}

function logs {
  ${CMD} logs -f
}

case "$1" in
  build)
    build
    ;;
  setup)
    setup
    ;;
  migrate)
    migrate
    ;;
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  first-deploy)
    first-deploy
    ;;
  deploy)
    deploy
    ;;
  logs)
    logs
    ;;
  *)
    echo "Usage: bash prd.sh build|setup|migrate|start|stop|restart|first-deploy|deploy|logs"
    exit 1
  ;;
esac
