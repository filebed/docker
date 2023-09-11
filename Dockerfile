FROM php:7.2-apache

RUN apt-get update && \
    apt-get install unzip && \
    apt-get clean && \
    curl -L -O https://github.com/Studio-42/elFinder/archive/2.1.23.zip && \
    unzip *.zip && \
    rm -f *.zip && \
    mv elFinder-* elFinder && \
    chown -R www-data:www-data elFinder && \
    sed 's/.*uploadDeny.*/"uploadDeny"=>array("all"),/g' elFinder/php/connector.minimal.php-dist > elFinder/php/connector.minimal.php-dist-2 && \
    sed 's/.*uploadAllow.*/"uploadAllow"=>array("all"),/g' elFinder/php/connector.minimal.php-dist-2 > elFinder/php/connector.minimal.php && \
    rm -rf elFinder/php/connector.minimal.php-dist* && \
    mv elFinder/elfinder.html elFinder/index.html && \
    rm -rf elFinder/files && \
    echo '<?php header("Location: /elFinder"); ?>'> index.php && \
    ln -s /files /var/www/html/elFinder/files

VOLUME /files
