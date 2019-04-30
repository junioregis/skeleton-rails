ARG IMAGE

FROM $IMAGE

ARG TIMEZONE="America/Sao_Paulo"

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]