# Docker Image for packaging a PHP application, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/php-app.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/php-app.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/php-app.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-php-app.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-php-app.svg)

This image packages PHP with PHP-FPM & NGINX in a slim image so you can focus only on your application!

* Docker Hub: https://hub.docker.com/r/frxyt/php-app
* GitHub: https://github.com/frxyt/docker-php-app

## Docker Hub Image

**`frxyt/php-app`**

## Usage

1. Add your built PHP application into `/app`
1. Start the container

## Examples

### Symfony4 application with GD & MySQL extensions

`Dockerfile` file content:

```Dockerfile
FROM frxyt/php-dev-full:7.4-cli as build
COPY . /app
WORKDIR /app
RUN composer install --no-interaction --no-progress --no-suggest --no-dev --optimize-autoloader
RUN yarn install
RUN yarn encore production
RUN rm -rf node_modules

FROM frxyt/php-app:7.4 as app
COPY --from=build /app /app
RUN     echo -n "#!/bin/bash\nphp bin/console doctrine:migrations:migrate -n" > /usr/local/bin/frx-start.d/app \
    &&  chmod +x /usr/local/bin/frx-start.d/app \
    &&  /usr/local/bin/frx-tz Europe/Paris \
    &&  apk add --no-cache \
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
    &&  docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    &&  docker-php-ext-install -j$(nproc) gd \
    &&  docker-php-ext-install -j$(nproc) pdo_mysql \
    &&  sed -i 's/^\(\s*\)root\(\s*\)[^;]*;/\1root\2\/app\/public;/g' /etc/nginx/conf.d/default.conf
```

## Build & Test

```sh
docker build -f Dockerfile-7.4 -t frxyt/php-app:7.4 .
docker build -f Dockerfile-8.0 -t frxyt/php-app:8.0 .
docker run --rm -it frxyt/php-app:7.4 bash
docker run --rm -it frxyt/php-app:8.0 bash
```

## License

This project and images are published under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```