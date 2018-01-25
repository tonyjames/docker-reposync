#!/bin/sh

image=$1
repos_volume=$2
repos_file=$3

if [ -z $image ] || [ -z $repos_volume ] || [ -z $repos_file ]; then
   echo "Usage: run-reposync.sh [image] [repos_volume] [repos_file]"
   exit
fi

for repo in $(cat $repos_file |grep -v "#"); do
    echo "### BEGIN $repo ###"
    docker run --rm --security-opt label=disable -v $repos_volume:/repos $image reposync -l -p /repos -r $repo -d --downloadcomps --download-metadata
    docker run --rm --security-opt label=disable -v $repos_volume:/repos $image createrepo --update /repos/$repo
    echo "### END $repo ###"
done
