FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    # Install apache
    apache2 \
    # Install php 7.4
    libapache2-mod-php7.4 \
    php7.4-cli \
    php7.4-pgsql \
	php7.4-mysql \
    php7.4-json \
    php7.4-curl \
    php7.4-gd \
    php7.4-ldap \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-xml \
    php7.4-zip \
    php7.4-intl \
    php-imagick \
    # Install tools
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    iputils-ping \
    locales \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite && a2enmod headers
COPY web.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite web.conf
EXPOSE 80

WORKDIR /var/www/html
CMD chown -R www-data:www-data html/*
CMD apachectl -D FOREGROUND 