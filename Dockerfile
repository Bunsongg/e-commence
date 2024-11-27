FROM php:8.2-fpm

# Install necessary extensions and libraries
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif \
    && docker-php-ext-install pdo pdo_mysql zip

# Set the working directory
WORKDIR /var/www

# Copy the application code
COPY . .

# Copy composer from the composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port and set the appropriate command if necessary
# EXPOSE 9000
# CMD ["php-fpm"]