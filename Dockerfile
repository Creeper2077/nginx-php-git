FROM ubuntu:20.04
RUN echo "Update source..." \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt update -qq \
    && apt upgrade -y -qq \
    && echo "Done." \
    && echo "Install CA Certificates..." \
    && apt install ca-certificates -y -qq --no-install-recommends \
    && echo "Done." \
    && echo "Install Nginx&PHP&cron..." \
    && apt install nginx php7.4 php7.4-fpm php7.4-cgi php7.4-json php7.4-curl cron -y -qq --no-install-recommends \
    && echo  "Done." \
    && echo "Install Git.." \
    && apt install git -y -qq --no-install-recommends \
    && echo "Done." \
    && echo "Add user www..." \
    && groupadd -r www \
    && useradd -r -g www www \
    && echo -en "\n www ALL=(ALL)  NOPASSWORD:ALL" >> /etc/sudoers \
    && echo "Done." \
    && echo "Modify the files..." \
    && mv /var/www/html/index.nginx-debian.html /var/www/html/index.html \
    && rm /etc/nginx/nginx.conf \
    && rm /etc/php/7.4/fpm/php.ini \
    && rm /etc/php/7.4/fpm/php-fpm.conf \
    && rm /etc/php/7.4/fpm/pool.d/www.conf \
    && echo "Done." \
    && echo "Clean Cache..." \
    && apt clean -qq \
    && apt autoremove -qq \
    && echo "Done."
ADD file.tar /
RUN echo "Setting permission..." \
    && chmod -R +x /home/script \
    && chmod -R 755 /var/www/html \
    && echo "Done."