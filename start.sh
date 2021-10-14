#!/bin/bash

root="/var/www/html"
script_root="/home/script"

if [[ $1 != "none" ]]
then
        if [ -n "`ls -A ${root}`" ]
        then
                echo "Clean up ${root}..."
                rm -rf $root
                mkdir $root
                echo "Done."
        fi
        #clone the repo
        printf "Start clone from Git repo..."
        printf "GitURL: %s\n" $1
        git clone $1 $root --depth 1
        printf "Done.\n"
        #Configure automatic updates
        case "$2" in
        "timing") #Create timed script
                echo "Update /etc/crontab..."
                timing=echo ${@:3}
                echo "${timing} /home/script/update.sh ${root}" >> /etc/crontab
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
                cp ${script_root}/webhook.php ${root}/.webhook/${webhook}.php
                echo "Done."
                printf "Add this webhook to you Git service provider:yourdomain.com/.webhook/%s.php\n" $webhook
                ;;
        *)      echo "The repo will never update."
                ;;
esac
else
        echo "Skip clone file."
fi

#Run additional scripts
echo "Run additional scripts..."

#Set permissions
echo "Set permissions..."
chmod -R 755 $root
echo -e "Done.\n"

#All Done
echo "All Done."

#Starting service
${script_root}/launch.sh