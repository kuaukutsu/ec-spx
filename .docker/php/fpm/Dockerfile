FROM ghcr.io/kuaukutsu/php:8.4-fpm AS app_image

RUN apk update \
    && apk add --no-cache --virtual .persistent-deps \
        fcgi \
        zlib-dev

FROM app_image AS app_setup

# Arguments
ARG UID=10001
ARG WORKDIR="/src"

# Configure
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/www.conf.default /usr/local/etc/php-fpm.d/www.conf.default
COPY conf/www.conf /usr/local/etc/php-fpm.d/www.conf
# Dependencies
COPY --from=composer:latest --link /usr/bin/composer /usr/bin/composer
# user
RUN <<EOF
    adduser -u ${UID} -G www-data -s /bin/sh -D developer www-data
EOF
# workdir
RUN <<EOF
    mkdir -p ${WORKDIR}
    chown -R ${UID}:www-data ${WORKDIR}
EOF
# composer
RUN <<EOF
    mkdir /var/.composer
    chown developer:www-data /var/.composer
EOF
ENV COMPOSER_CACHE_DIR=/var/.composer

FROM app_setup AS app_devel

RUN install-php-extensions opcache igbinary spx xdebug

#RUN { \
#  echo "extension=spx.so"; \
#  echo "spx.http_enabled=1"; \
#  echo "spx.http_key=\"dev\""; \
#  echo "spx.http_ip_whitelist=\"*\""; \
#  echo "spx.http_trusted_proxies=\"*\""; \
#  echo "spx.http_ui_assets_dir=\"/usr/local/share/misc/php-spx/assets/web-ui\""; \
#} > /usr/local/etc/php/conf.d/docker-php-ext-spx.ini

USER $UID
WORKDIR $WORKDIR

EXPOSE 9000
