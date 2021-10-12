#!/bin/bash

root="/home/html"

if [[ $1 != "none" ]]
then
        #clone the repo
        printf "Start clone from Git repo...\n"
        printf "GitURL: %s\n" $1

        if [ -n "`ls -A ${root}`" ]
        then
                echo "WARING: ${root} is not empty!"
                echo -e "Clean up the web dir...\c"
                rm -rf $root
                mkdir $root
                echo "Done."
        fi
        git clone $1 $root --depth 1
        echo "Done."
else
        echo "Skip clone file."
fi

#Configure automatic updates
case "$2" in
"timing") #Create timed script
        echo -e "Update /etc/crontab...\c"
        timing=echo ${@:3}
        echo "${timing} /home/script/update.sh ${root}" > /etc/crontab
        chmod +x /etc/profile.d/crontab.sh
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
        echo -e "<?php \n exec(\"/home/script/update.sh ${root}\"); \n ?> \c" > ${root}/.webhook/${webhook}.php
        echo "Done."
        printf "Add this webhook to you Git service provider:yourdomain.com/.webhook/%s.php\n" $webhook
        ;;
*)      echo "The repo will never update."
        ;;
esac

#Set permissions
echo -e "Set permissions...\c"
chmod -R 755 $root
echo "Done"

#Quit
echo "All Done."

#start nginx
echo "Starting nginx..."
service nginx start

