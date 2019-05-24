#!/bin/bash

export CURRENT_UID="$(id -u):$(id -g)"

PROJECT_NAME="skeleton_rails"

SERVICES="app bundle redis db db_admin selenium portainer"

CMD="docker-compose --project-name=${PROJECT_NAME} \
                    --file docker-compose.yml \
                    --file docker-compose.dev.yml"

function init {
  # Create folders
  mkdir -p src/app

  # Copy Template
  cp -R template/* src/

  # Build
  build

  # Create App Structure
  ${CMD} run --rm -e RAILS_MASTER_KEY app \
    bundle exec rails new . \
      --api \
      --skip \
      --skip-git \
      --skip-bundle \
      --skip-gemfile \
      --skip-active-storage \
      --database=postgresql

  # Check Permissions
  chown -hR ${CURRENT_UID} .

  # Initialize Database
  ${CMD} run --rm app bundle exec rake db:setup

  # Stop
  stop
}

function gen-secret {
  ${CMD} exec app rake secret
}

function build {
  ${CMD} build --pull ${SERVICES}
  ${CMD} pull ${SERVICES}
}

function start {
  ${CMD} up -d ${SERVICES}
}

function stop {
  ${CMD} down
}

function restart {
  stop
  start
}

function terminal {
  ${CMD} exec app sh
}

function credentials {
  ${CMD} exec -e EDITOR=nano app rails credentials:edit
}

function logs {
  ${CMD} logs -f
}

case "$1" in
  init)
    init
    ;;
  gen-secret)
    gen-secret
    ;;
  build)
    build
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
  terminal)
    terminal
    ;;
  credentials)
    credentials
    ;;
  logs)
    logs
    ;;
  *)
    echo "Usage: bash dev.sh init|gen-secret|build|start|stop|restart|terminal|credentials|logs"
    exit 1
  ;;
esac