FROM php:8.2-fpm

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar diretório de trabalho
WORKDIR /var/www

# Copiar o projeto
COPY . /var/www

# Instalar dependências do Laravel
RUN composer install

# Permissões
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# Expor a porta
EXPOSE 9000

CMD ["php-fpm"]
