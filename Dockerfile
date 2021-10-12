FROM Ubuntu：20.04
EXPOSE "8080"
RUN echo "Install Nginx&PHP&cron..." \
    apt update \
    && apt upgrade \
    && apt install nginx php7.4 php7.4-fpm php7.4-cgi cron -y \
    && echo -e "Done.\n" \
    && echo "Add user www..." \
    && groupadd -r www \
    && adduser -r -g www www \
    && echo -e "\n www ALL=(ALL)  NOPASSWORD:ALL" >> /etc/sudoers \
    && echo -e "Done.\n" \
    && echo "Modify the files..." \
    && rm /etc/nginx/conf/nginx.conf \
    && rm /etc/php/7.4/fpm/php.ini \
    && rm /etc/php/7.4/fpm/php-fpm.conf \
    && rm /etc/php/7.4/fpm/pool.d/www.conf \
    && echo -e "Done.\n" \
COPY ./*.sh /home/script \
    ./nginx.conf /etc/nginx/conf \
    ./php.ini /etc/php/7.4/fpm/php.ini \
    ./php-fpm.conf  /etc/php/7.4/fpm/php-fpm.conf \ 
    ./www.conf /etc/php/7.4/fpm/pool.d/www.conf \
    ./info.php /var/www/html
USER www:www
CMD ["service","php7.4-fpm","start"]