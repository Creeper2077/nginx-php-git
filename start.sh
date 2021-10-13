#!/bin/bash

root="/var/www/html"

if [[ $1 != "none" ]]
then
        #clone the repo
        printf "Start clone from Git repo..."
        printf "GitURL: %s\n" $1

        if [ -n "`ls -A ${root}`" ]
        then
                echo "WARING: ${root} is not empty!"
                echo "Clean up the web dir..."
                rm -rf $root
                mkdir $root
                echo "Done."
        fi
        git clone $1 $root --depth 1
        echo "Done."
        #Configure automatic updates
        case "$2" in
        "timing") #Create timed script
                echo "Update /etc/crontab..."
                timing=echo ${@:3}
                echo "${timing} /home/script/update.sh ${root}" > /etc/crontab
                echo "Done."
                ;;
        "webhook") #Create webhook
                if [[ $3 ]]
                then
                        webhook=$3
                else
                        webhook=$(cat /proc/sys/kernel/random/uuid)
                fi
                printf "Create %s/.webhook/%s.php..." $root $webhook
                mkdir ${root}/.webhook
                echo "<?php \n exec(\"/home/script/update.sh ${root}\"); \n ?> \c" > ${root}/.webhook/${webhook}.php
                echo "Done."
                printf "Add this webhook to you Git service provider:yourdomain.com/.webhook/%s.php\n" $webhook
                ;;
        *)      echo "The repo will never update."
                ;;
esac
else
        echo "Skip clone file."
fi



#Set permissions
echo "Set permissions..."
chmod -R 755 $root
echo "Done."

#All Done
echo "All Done."

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