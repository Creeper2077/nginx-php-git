#!/bin/bash
#Initialization

root="/var/www/html"

#Set server name
printf "Set server name..."
sed -i 's/@SERVERNAME_HERE@/${1}/g' /etc/nginx/nginx.conf
printf "Done."

if [[ $2 != "none" ]]
then
        if [ -n "`ls -A ${root}`" ]
        then
                printf "Clean up %s...\n" $root
                rm -rf $root
                mkdir $root
                printf "Done.\n"
        fi
        #clone the repo
        printf "Start clone from Git repo...\n"
        printf "GitURL: %s\n" $2
        git clone $2 $root --depth 1
        printf "Done.\n"
        #Configure automatic updates
        case "$3" in
        "timing") #Create timed script
                printf "Update /etc/crontab...\n"
                timing=echo ${@:4}
                echo "${timing} /home/script/update.sh ${root}" >> /etc/crontab
                printf "Done.\n"
                ;;
        "webhook") #Create webhook
                if [[ $4 ]]
                then
                        webhook=$4
                else
                        webhook=$(cat /proc/sys/kernel/random/uuid)
                fi
                printf "Create %s/.webhook/%s.php...\n" $root $webhook
                mkdir ${root}/.webhook
                cp ./webhook.php ${root}/.webhook/${webhook}.php
                printf "Done.\n"
                printf "Add this webhook to you Git service provider:yourdomain.com/.webhook/%s.php\n" $webhook
                ;;
        *)      printf "The repo will never update.\n"
                ;;
esac
else
        printf "Skip clone file.\n"
fi

#Run additional scripts
printf "Run additional scripts...\n"
./additional.sh
printf "Done.\n"

#Set permissions
printf "Set permissions...\n"
chmod -R 755 $root
printf "Done.\n"

#All Done
printf "All Done.\n"

#Starting service
./launch.sh