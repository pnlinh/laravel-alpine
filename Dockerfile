# Modeled after https://github.com/shufo/docker-laravel-alpine/tree/7.4.4
FROM shufo/laravel-alpine:7.4.4

LABEL Maintainer="S.Myagmarsuren <selmonal@gmail.com>" \
    Description="A Laravel optimized Docker image using Alpine Linux."

# Configure start sciprt
COPY config/start-container /usr/local/bin/start-container

RUN chmod +x /usr/local/bin/start-container \
    && docker-php-ext-install pcntl exif \
    && apk --no-cache add nginx supervisor sudo

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure php
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && echo "decorate_workers_output = no" >> /usr/local/etc/php-fpm.d/www.conf

# Configure opcache
COPY config/opcache.ini $PHP_INI_DIR/conf.d/

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["start-container"]
