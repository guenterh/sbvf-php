### install ubuntu ###
FROM ubuntu:18.04
MAINTAINER guenter.hipler@unibas.ch
EXPOSE 80 443 3306
VOLUME ["/var/lib/mysql", "/var/run/mysqld", "/app", "/var/lib/xdebug"]
ENTRYPOINT ["/docker/entrypoint"]
CMD ["run"]

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y wget less vim  graphviz locales ssh rsync graphicsmagick-imagemagick-compat  \
        apache2 apache2-utils openssl ca-certificates  libcurl4 apt-utils tzdata \
#        libshibsp-plugins shibboleth-sp2-utils libshibsp7  libxmltooling7 \
#        libapache2-mod-shib2 git \
        make mariadb-client mariadb-server unzip \
        libapache2-mod-php7.2 php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-common php7.2-curl php7.2-dba php7.2-dev \
        php7.2-fpm php7.2-gd php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache \
        php7.2-readline php7.2-soap php7.2-xml php7.2-zip php7.2-xdebug

ENV APP_HOME=/app \
 APP_USER=dev \
 FCGID_MAX_REQUEST_LEN=16384000 \
 TIME_ZONE=Europe/Berlin \
 WEBGRIND_ARCHIVE=1.1.0 \
 WEBGRIND_FORK=rovangju \
 SHIB_HOSTNAME=https://localhost \
 SHIB_HANDLER_URL=/Shibboleth.sso \
 SHIB_SP_ENTITY_ID=https://hub.docker.com/r/smoebody/dev-dotdeb \
 SHIB_IDP_DISCOVERY_URL=https://wayf.aai.dfn.de/DFN-AAI-Test/wayf \
 SHIB_ATTRIBUTE_MAP="" \
 SQL_MODE="" \
 SMTP_HOST="" \
 SMTP_NAME=dev-dotdeb \
 SMTP_PORT=25

COPY assets/init /docker/init
COPY assets/build /docker/build
RUN chmod 755 /docker/init \
 && /docker/init
# && rm -rf /docker/build

COPY assets/setup /docker/setup
COPY assets/entrypoint /docker/entrypoint
RUN chmod 755 /docker/entrypoint
