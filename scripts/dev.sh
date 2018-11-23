#!/bin/bash

SERVICES="app db db_admin portainer"

CMD="docker-compose --project-name=api -f docker-compose.yml -f docker-compose.dev.yml"

function init {
    # Copy Template
    cp template/* src/ -R

    # Build Services
    ${CMD} build app

    # Start Services
    ${CMD} up -d app

    # Create Project Structure
    ${CMD} run -e RAILS_MASTER_KEY app \
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
    sudo chown -R ${USER}:${USER} .
}

case "$1" in
    init)
        echo –n "Initializing..."
        init
        ;;
    build)
        echo –n "Building..."
        build
        ;;
    start)
        echo –n "Starting..."
        start
        ;;
    stop) 
        echo –n "Stopping..."
        stop
        ;;
    restart)
        echo –n "Restarting..."
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
        echo "Usage: bash dev.sh init|build|start|stop|restart|logs|terminal|permissions|credentials"
        exit 1
    ;;
esac