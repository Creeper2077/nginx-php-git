FROM ubuntu:20.04
RUN printf "Updating source...\n" \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt update -qq \
    && apt upgrade -y -qq \
    && printf "Done.\n" \
    && printf "Installing CA Certificates...\n" \
    && apt install ca-certificates -y -qq --no-install-recommends \
    && printf "Done.\n" \
    && printf "Installing Nginx&PHP&cron...\n" \
    && apt install nginx php7.4 php7.4-fpm php7.4-cgi php7.4-json php7.4-curl cron -y -qq --no-install-recommends \
    && printf  "Done.\n" \
    && printf "Installing Git...\n" \
    && apt install git -y -qq --no-install-recommends \
    && printf "Done.\n" \
    && printf "Adding user www...\n" \
    && groupadd -r www \
    && useradd -r -g www www \
    && echo -en "\n www ALL=(ALL)  NOPASSWORD:ALL" >> /etc/sudoers \
    && printf "Done.\n" \
    && printf "Modifing the files...\n" \
    && mv /var/www/html/index.nginx-debian.html /var/www/html/index.html \
    && rm /etc/nginx/nginx.conf \
    && rm /etc/php/7.4/fpm/php.ini \
    && rm /etc/php/7.4/fpm/php-fpm.conf \
    && rm /etc/php/7.4/fpm/pool.d/www.conf \
    && printf "Done.\n" \
    && printf "Cleaning Cache...\n" \
    && apt clean -qq \
    && apt autoremove -qq \
    && printf "Done.\n" \
    %% printf "Adding files...\n"
ADD file.tar /
RUN printf "Done.\n" \
    printf "Setting permission...\n" \
    && chmod -R +x /home/script \
    && chmod -R 755 /var/www/html \
    && printf "Done.\n"