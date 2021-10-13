FROM ubuntu:20.04
RUN echo "Install CA Certificates..." \
    && apt install ca-certificates -y -qq --no-install-recommends \
    && echo "Done.\n" \
    && echo "Install Nginx&PHP&cron..." \
    && apt update -qq \
    && apt upgrade -y -qq \
    && apt install nginx php7.4 php7.4-fpm php7.4-cgi php7.4-json php7.4-curl cron -y -qq --no-install-recommends \
    && echo "Done.\n" \
    && echo "Install Git.." \
    && apt install git -y -qq --no-install-recommends \
    && echo "Done\n" \
    && echo "Add user www..." \
    && groupadd -r www \
    && useradd -r -g www www \
    && echo "\n www ALL=(ALL)  NOPASSWORD:ALL" >> /etc/sudoers \
    && echo "Done.\n" \
    && echo "Modify the files..." \
    && cp /var/www/html/index.nginx-debian.html /var/www/html/index.html \
    && rm /etc/nginx/nginx.conf \
    && rm /etc/php/7.4/fpm/php.ini \
    && rm /etc/php/7.4/fpm/php-fpm.conf \
    && rm /etc/php/7.4/fpm/pool.d/www.conf \
    && rm /var/www/html/index.nginx-debian.html \
    && echo "Done.\n" \
    && echo "Clean Cache..." \
    && apt clean -qq \
    && apt autoremove -qq \
    && echo "Done.\n"
ADD file.tar /
RUN echo "Setting permission..."\
    && chmod -R +x /home/script \
    && chmod -R 755 /var/www/html \
    && echo "Done.\n"