FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev

# Install PHP extensions (including pdo_mysql)
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www

# Copy existing project files to the container
COPY . /var/www

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader || true

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
