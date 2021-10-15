#!/bin/sh
#Update the Git repo
  
root = "/var/www/html"
cd $root
branch = $(git rev-parse --abbrev-ref HEAD)
local_commit = $(git rev-parse HEAD)
origin_commit=$(git rev-parse origin/${branch})
printf "Local commit:%s\n" $local_commit
printf  "Origin commir:%s\n" $origin_commit
if [$local_commit != $origin_commit]
then    
    printf "Pull from remote!\n"
    git pull --depth 1
    chmod -R 755 $root
    printf "Done.\n"
else
    printf "Already to date!\n"
fi
