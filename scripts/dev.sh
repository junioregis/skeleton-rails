#!/bin/bash

PROJECT_NAME="skeleton_rails"

SERVICES="app redis db db_admin selenium portainer"

CMD="docker-compose --project-name=${PROJECT_NAME} -f docker-compose.yml -f docker-compose.dev.yml"

function init {
  # Copy Template
  cp -R template/* src/

  # Build Services
  ${CMD} build app

  # Start Services
  ${CMD} up -d app

  # Create Project Structure
  ${CMD} run --rm -e RAILS_MASTER_KEY app \
    rails new . \
      --api \
      --skip \
      --skip-git \
      --skip-bundle \
      --skip-gemfile \
      --database=postgresql

  # Initialize Database
  ${CMD} run app rake db:setup

  # Stop Services
  ${CMD} down

  # Check Permissions
  permissions
}

function gen-secret {
  ${CMD} exec app rake secret
}

function build {
  ${CMD} build
}

function start {
  ${CMD} up -d ${SERVICES}
}

function stop {
  ${CMD} down
}

function restart {
  ${CMD} restart ${SERVICES}
}

function logs {
  ${CMD} logs -f app
}

function terminal {
  ${CMD} exec app sh
}

function credentials {
  ${CMD} exec -e EDITOR=nano app rails credentials:edit
}

function permissions {
  sudo chown -R ${USER} .
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
  logs) 
    logs
    ;;
  terminal) 
    terminal
    ;;
  permissions) 
    permissions
    ;;
  credentials) 
    credentials
    ;;
  *)
    echo "Usage: bash dev.sh init|gen-secret|build|start|stop|restart|logs|terminal|permissions|credentials"
    exit 1
  ;;
esac