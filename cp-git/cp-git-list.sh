#!/bin/sh

input=$1

while IFS=' ' read -r repo url
do
  echo "********************************************************************************"
  echo "Copying $repo to $url"

  ./cp-git.sh $repo $url

done < "$input"
