# Copyright (c) 2019,2020,2021 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019,2020,2021 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-php-app> for details.

ARG FRX_OS_VARIANT=alpine
ARG FRX_PHP_VERSION=8.0
FROM php:${FRX_PHP_VERSION}-fpm-${FRX_OS_VARIANT}

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"
ARG FRX_BUILD_COMMIT_DATE=0000-00-00
ARG FRX_BUILD_COMMIT_SHA=0000000
ARG FRX_OS_VARIANT=alpine
ARG FRX_PHP_VERSION=8.0
ENV FRX_BUILD_COMMIT_DATE=${FRX_BUILD_COMMIT_DATE} \
    FRX_BUILD_COMMIT_SHA=${FRX_BUILD_COMMIT_SHA} \
    FRX_OS_VARIANT=${FRX_OS_VARIANT} \
    FRX_PHP_VERSION=${FRX_PHP_VERSION}

COPY build /frx/
RUN /frx/build
COPY Dockerfile LICENSE README.md /frx/

ENV FRX_LOG_PREFIX_MAXLEN=8 \
    FRX_MOTD=default

WORKDIR /app
EXPOSE 80 9001
ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/usr/local/bin/frx-start" ]