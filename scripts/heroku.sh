#!/bin/bash

APP_NAME="skeleton-rails"

function install-cli {
  # Install CLI
  curl https://cli-assets.heroku.com/install.sh | sh

  # Login
  heroku login
}

function first-deploy {
  # Start Services
  bash scripts/dev.sh start

  APP_SECRET=$(bash scripts/dev.sh gen-secret)
  APP_MASTER_KEY=$(cat src/app/config/master.key)

  # Set App
  heroku git:remote --app ${APP_NAME}
  heroku access --app ${APP_NAME}

  # Set Ruby Project
  heroku buildpacks:add heroku/ruby

  # Install Postgres
  heroku addons:create heroku-postgresql:hobby-dev

  # Install Chrome driver
  heroku buildpacks:add https://github.com/heroku/heroku-buildpack-google-chrome.git
  heroku buildpacks:add https://github.com/heroku/heroku-buildpack-chromedriver

  # Install Redis
  heroku addons:create heroku-redis:hobby-dev -a ${APP_NAME}

  # Set Environments Variables
  heroku config:set RAILS_ENV=test \
                    RACK_ENV=test \
                    SECRET_KEY_BASE=${APP_SECRET} \
                    RAILS_MASTER_KEY=${APP_MASTER_KEY} \
                    RAILS_LOG_TO_STDOUT=true \
                    GOOGLE_CHROME_BIN=/app/.apt/opt/google/chrome/chrome \
                    GOOGLE_CHROME_SHIM=/app/.apt/opt/google/chrome/chrome

  # Push App
  git add .
  git commit -m "first commit"
  git push heroku `git subtree split --prefix src master`:refs/heads/master --force

  # Create Database
  heroku run rake db:migrate
  heroku run rake db:schema:load
  heroku run rake db:seed
}

function deploy {
  # Set App
  heroku git:remote --app ${APP_NAME}
  heroku access --app ${APP_NAME}

  # Push App
  git add .
  git commit -a --allow-empty-message -m ''
  git push heroku `git subtree split --prefix src master`:refs/heads/master --force
}

function logs {
  heroku logs -t
}

case "$1" in
  install-cli)
      install-cli
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
      echo "Usage: bash heroku.sh install-cli|first-deploy|deploy|logs"
      exit 1
  ;;
esac