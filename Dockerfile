FROM php:8.3-fpm

ARG user=deepdefense
ARG uid=1000

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    npm \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom configurations PHP
COPY docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

COPY ["package.json", "package-lock.json", "/var/www/"]
RUN npm install

COPY composer.json composer.lock ./
COPY --chmod=0777 . .
COPY .env.example .env
RUN composer update
RUN composer install
RUN php artisan key:generate \
    && npm run build

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user \
    && mkdir -p /home/$user/.composer \
    && chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

RUN 

# Set proper permissions
RUN chown -R $user:www-data /var/www && \
    chmod -R 755 /var/www

#CMD ["cron && tail -f /var/log/cron.log"]

USER $user