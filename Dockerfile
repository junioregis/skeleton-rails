ARG IMAGE

FROM $IMAGE

ARG APP_PATH="/app"
ARG TIMEZONE="America/Sao_Paulo"

RUN apk add --no-cache --update \
    build-base \
    imagemagick \
    linux-headers \
    nano \
    nodejs \
    postgresql-dev \
    tzdata

RUN mkdir $APP_PATH

WORKDIR $APP_PATH

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
