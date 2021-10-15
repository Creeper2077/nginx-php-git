#!/bin/sh
#Start the service

#Start cron
printf "Starting cron...\n"
service cron start
printf "Done.\n"

#start PHP
printf "Starting PHP-fpm...\n"
service php7.4-fpm start
printf "Done.\n"

#Start nginx
printf "Starting nginx...\n"
service nginx start