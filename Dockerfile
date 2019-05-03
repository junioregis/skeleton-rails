ARG IMAGE

FROM $IMAGE

ARG APP_PATH="/app"
ARG TIMEZONE="America/Sao_Paulo"

ENV BUNDLE_PATH /bundle
ENV GEM_HOME    $BUNDLE_PATH
ENV GEM_PATH    $GEM_HOME
ENV PATH        $GEM_PATH/bin:$PATH

RUN apk add --no-cache --update \
    build-base \
    imagemagick \
    linux-headers \
    nano \
    nodejs \
    postgresql-dev \
    tzdata

RUN mkdir $APP_PATH
RUN mkdir $BUNDLE_PATH

WORKDIR $APP_PATH

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

RUN gem install bundler --user-install

COPY src/Gemfile $APP_PATH/
COPY src/Gemfile.lock $APP_PATH/

RUN bundle install

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]