#!/bin/sh

dockerfile=$1
username=$2
password=$3
pool_file=$4
tag=$5

if [ -z dockerfile ] || [ -z $username ] || [ -z $password ] || [ -z $pool_file ] || [ -z $tag ]; then
    echo "Usage: run-build.sh [dockerfile] [username] [password] [pool_file] [tag]"
    exit
fi

pools=$(cat $pool_file)

sudo docker build -t $tag --build-arg username=$username --build-arg password=$password --build-arg pools="$pools" --build-arg name=$tag -f $dockerfile .
