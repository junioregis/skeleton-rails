FROM ruby:2.6.0-alpine

ARG APP_PATH='/app'
ARG TIMEZONE=America/Sao_Paulo

RUN apk add --update \
    build-base \
    imagemagick \
    linux-headers \
    nano \
    nodejs \
    postgresql-dev \
    tzdata

RUN rm -rf /var/cache/apk/*

RUN mkdir $APP_PATH

WORKDIR $APP_PATH

COPY src/Gemfile $APP_PATH/
COPY src/Gemfile.lock $APP_PATH/

RUN bundle install

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

EXPOSE 3000
