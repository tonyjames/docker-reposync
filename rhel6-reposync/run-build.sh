#!/bin/sh

username=$1
password=$2
pool_file=$3
tag="rhel6-reposync"

if [ -z $username ] || [ -z $password ] || [ -z $pool_file ]; then
    echo "Usage: run-build.sh [username] [password] [pool_file]"
    exit
fi

pools=$(cat $pool_file)

sudo docker build -t $tag --build-arg username=$username --build-arg password=$password --build-arg pools="$pools" .
