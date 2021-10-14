#Start cron
echo "Starting cron..."
service cron start
echo -e "Done.\n"

#start PHP
echo "Starting PHP-fpm..."
service php7.4-fpm start
echo -e "Done.\n"

#Start nginx
echo "Starting nginx..."
service nginx start