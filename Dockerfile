# Modeled after https://github.com/Footage-Firm/alpine-laravel
FROM alpine:3.8
LABEL Maintainer="S.Myagmarsuren <selmonal@gmail.com>" \
      Description="A Laravel optimized Docker image using Alpine Linux."

# https://github.com/docker-library/php/issues/240
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-zip php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-xmlwriter php7-ctype \
    php7-mbstring php7-gd php7-session php7-pdo php7-pdo_mysql php7-tokenizer php7-posix \
    php7-fileinfo php7-opcache php7-cli php7-mcrypt php7-pcntl php7-iconv php7-simplexml \
    nginx supervisor curl git openssh-client

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/app.conf
COPY config/php.ini /etc/php7/conf.d/app.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure start sciprt
COPY config/start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

# Setup Application Folder
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

EXPOSE 80
CMD ["start-container"]
