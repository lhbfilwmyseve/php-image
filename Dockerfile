FROM crunchgeek/php-fpm:7.4-r1


# 换源国内
RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN cat /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/*
RUN apt-get update

#安装 xhprof

RUN pecl install xhprof && docker-php-ext-enable xhprof

#安装composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
ENV PATH="$PATH:/root/.composer/vendor/bin"
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#安装mcrypt 高版本没有 但需要使用的
RUN pecl install mcrypt \
    && docker-php-ext-enable mcrypt
#    安装xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

#安装graphviz
RUN apt-get install -y graphviz
