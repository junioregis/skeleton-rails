ARG IMAGE

FROM $IMAGE

ARG BC_URL=http://repo1.maven.org/maven2/org/bouncycastle/bcprov-ext-jdk16/1.46/bcprov-ext-jdk16-1.46.jar

RUN apk add --no-cache --update \
  curl \
  openssl

RUN mkdir /certs
RUN mkdir /scripts

WORKDIR /scripts

COPY generator.sh /scripts

RUN chmod +x /scripts/generator.sh

RUN curl $BC_URL --output /scripts/bc.jar

VOLUME /certs

CMD [ "/bin/sh", "/scripts/generator.sh" ]