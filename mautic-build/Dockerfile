FROM php:5.6-cli
MAINTAINER tuschl@digitalmobil.com

RUN adduser --gecos "" --disabled-password --home /home/mautic-build mautic-build

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
    ssh sudo subversion git bzip2 zip unzip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
     php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');" && \
     php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
     php composer-setup.php --filename=composer --install-dir=/bin && \
     php -r "unlink('composer-setup.sig');" && \
     php -r "unlink('composer-setup.php');" 

# Define working directory.
WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
# Define default command.
CMD ["bash"]
ENTRYPOINT ["/entrypoint.sh"]
