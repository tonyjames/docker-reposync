#!/bin/sh

image=$1
repos_volume=$2
repos_file=$3

if [ -z $image ] || [ -z $repos_volume ] || [ -z $repos_file ]; then
   echo "Usage: [image] [repos_volume] [repos_file]"
   exit
fi

for repo in $(cat $repos_file); do
    echo "### BEGIN $repo ###"
    sudo docker run --rm --security-opt label=disable -v $repos_volume:/repos $image reposync -l -p /repos -r $repo --downloadcomps --download-metadata
    sudo docker run --rm --security-opt label=disable -v $repos_volume:/repos $image createrepo /repos/$repo
    echo "### END $repo ###"
done
