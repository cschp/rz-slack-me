### Docker version of the sl-rz-me application 
### it sends a reminder in slack using your slack secret every hour
### to remind you to walk your dog

FROM composer:2 as composer
WORKDIR /app
COPY . .
RUN composer install --no-dev --optimize-autoloader

FROM php:8.2-cli
WORKDIR /app
COPY --from=composer /app /app

### Install required PHP extensions

RUN docker-php-ext-install pdo pdo_mysql

### Set environment variables

ARG SLACK_SECRET
ENV SLACK_SECRET=$SLACK_SECRET

### Generate application key

RUN php artisan key:generate

### Set the command to run the application

CMD ["php", "artisan", "slack-me"] 