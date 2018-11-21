#/bin/bash

DOMAIN="domain.com"
PASSWORD="P@ssword"

# Generate CRT and KEY
openssl req -new -x509 -nodes -days 365 -newkey rsa:2048 \
    -passout pass:${PASSWORD} \
    -keyout /certs/${DOMAIN}.key \
    -out /certs/${DOMAIN}.crt \
    -subj "/C=BR/ST=Distrito Federal/L=Brasilia/O=Organization/OU=IT Department/CN=${DOMAIN}"

# Generate P12
openssl pkcs12 -export \
    -passout pass:${PASSWORD} \
    -in /certs/${DOMAIN}.crt \
    -inkey /certs/${DOMAIN}.key \
    -out /certs/${DOMAIN}.p12

# Generate PEM
openssl pkcs12 -nodes \
    -password pass:${PASSWORD} \
    -in /certs/${DOMAIN}.p12 \
    -out /certs/${DOMAIN}.pem

# Generate DER
openssl x509 -outform der \
    -passin pass:${PASSWORD} \
    -in /certs/${DOMAIN}.pem \
    -out /certs/${DOMAIN}.der

# Generate BKS
keytool -noprompt -import -v -trustcacerts \
        -alias         'openssl x509 -passin pass:${PASSWORD} -inform PEM -subject_hash -noout -in /certs/${DOMAIN}.pem' \
        -file          /certs/${DOMAIN}.pem \
        -keystore      /certs/${DOMAIN}.bks \
        -storetype     BKS \
        -providerclass org.bouncycastle.jce.provider.BouncyCastleProvider \
        -providerpath  bc.jar \
        -storepass     ${PASSWORD}