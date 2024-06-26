# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Install necessary PHP extensions and dependencies
RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libzip-dev \
        zip \
        unzip \
        libonig-dev \
        libxml2-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd pdo pdo_mysql mbstring zip exif pcntl

# Enable Apache mod_rewrite for clean URLs
RUN a2enmod rewrite

# Set ServerName to suppress the warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the application source code to the working directory
COPY src/ /var/www/html/
COPY styles/ /var/www/html/styles/
COPY main.js /var/www/html/

# Copy custom Apache configuration
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Ensure proper permissions for web root
RUN chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type d -exec chmod 755 {} \; && \
    find /var/www/html -type f -exec chmod 644 {} \;

# Expose port 80
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]
