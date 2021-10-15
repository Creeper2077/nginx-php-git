#!/bin/bash
#build the image

#make dirs
printf "Making tmp dir..\n"
mkdir -p ./tmp/etc/nginx
mkdir -p ./tmp/etc/php/7.4/fpm/pool.d
mkdir -p ./tmp/home/script
mkdir -p ./tmp/var/www/html
printf "Done.\n"

#Copy files
printf "Copying file...\n"
cp -f ./{additional,launch,start,update}.sh ./tmp/home/script
cp -f ./nginx.conf ./tmp/etc/nginx/nginx.conf
cp -f ./{php-fpm.conf,php.ini} ./tmp/etc/php/7.4/fpm
cp -f ./www.conf ./tmp/etc/php/7.4/fpm/pool.d
cp -f ./info.php ./tmp/var/www/html
printf "Done.\n"

#Create tar file
printf "Creating tar file...\n"
tar -cf file.tar ./tmp
printf "Done.\n"

#Delete temp dir
printf "Deleting temp dir...\n"
rm -r ./tmp
printf "Done.\n"

#Build image
printf "Starting building...\n"
if [[ $1 ]]
then
tag = $1
printf "Using tag:%s\n" $tag
else
tag="nginx-php-git"
printf "Using default tag:nginx-php-git\n"
fi
docker build . -t $tag
printf "Done.\n"


