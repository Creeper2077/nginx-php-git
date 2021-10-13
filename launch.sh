#Start cron
echo "Starting cron..."
service cron start
echo "Done."

#start PHP
echo "Starting PHP-fpm..."
service php7.4-fpm start
echo "Done."

#Start nginx
echo "Starting nginx..."
service nginx start