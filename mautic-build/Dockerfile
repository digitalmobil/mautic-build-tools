FROM php:5.6-cli
MAINTAINER tuschl@digitalmobil.com

RUN adduser --gecos "" --disabled-password --home /home/mautic-build mautic-build

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
    ssh sudo subversion git bzip2 zip unzip \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libc-client2007e-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN    docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql \
    && docker-php-ext-install -j$(nproc) mbstring zip \
    && docker-php-ext-install -j$(nproc) gd intl mcrypt \
    && mkdir /usr/kerberos \
    && ln -s /usr/lib/x86_64-linux-gnu /usr/kerberos/lib \
    && ln -s /usr/lib64/x86_64-linux-gnu /usr/kerberos/lib64 \
    && docker-php-ext-configure imap --with-kerberos \
    && docker-php-ext-install -j$(nproc) imap \

RUN  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
     php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');" && \
     php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
     php composer-setup.php --filename=composer --install-dir=/bin && \
     php -r "unlink('composer-setup.sig');" && \
     php -r "unlink('composer-setup.php');" 

RUN  php -r "copy('https://github.com/interconnectit/Search-Replace-DB/archive/master.zip', '/Search-Replace-DB-master.zip');" && \
     unzip /Search-Replace-DB-master.zip && \
     php -r "unlink('/Search-Replace-DB-master.zip');" && \
     chmod +x  /Search-Replace-DB-master/srdb.cli.php && \
     sed -i -E 's:/usr/bin/php:/usr/local/bin/php:g' /Search-Replace-DB-master/srdb.cli.php && \
     ln -s /Search-Replace-DB-master/srdb.cli.php /usr/bin/srdb

# Define working directory.
WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
# Define default command.
CMD ["bash"]
ENTRYPOINT ["/entrypoint.sh"]
