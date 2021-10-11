#!/bin/bash

root = $1
cd $root
branch = $(git rev-parse --abbrev-ref HEAD)
local_commit = $(git rev-parse HEAD)
origin_commit=$(git rev-parse origin/{$branch})
if [$local_commit != $origin_commit]
then
    git pull --depth 1
    chmod -R 755 $root
fi