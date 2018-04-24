FROM ruby:2.5.1

ARG APP_PATH='/app'
ARG TIMEZONE=America/Sao_Paulo

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev       \
    imagemagick     \
    locales         \
    nodejs          \
    nano

RUN mkdir $APP_PATH

WORKDIR $APP_PATH

COPY src/Gemfile $APP_PATH/
COPY src/Gemfile.lock $APP_PATH/

RUN bundle install

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

EXPOSE 3000