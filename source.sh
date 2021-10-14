#!/bin/bash
source_file="/etc/apt/sources.list"
if [ -e "${1}.source" ]
then
    source = $1
else
    source = "def"
fi

printf "Update ${source_file}...\n"
printf "Using source:%s\n" $source
cp -f ${PWD}/${source}.source $source_file
prinf "Done.\n"

