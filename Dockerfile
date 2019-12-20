# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-php-app> for details.

ARG FRX_DOCKER_FROM=php:7.4-fpm-alpine
FROM ${FRX_DOCKER_FROM}
LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

COPY build /frx/
RUN /frx/build
COPY Dockerfile LICENSE README.md /frx/

ENV FRX_LOG_PREFIX_MAXLEN=8 \
    FRX_MOTD=default

WORKDIR /app
EXPOSE 80 9001
ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/usr/local/bin/frx-start" ]