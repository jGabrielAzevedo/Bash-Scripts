#!/bin/sh

# cp-git: This script run cp-git on multiple repos at once
# usage:
#   ./cp-git-list.sh <list filename>
#
# List file format
# each row is one pair of repository and new remote url seperated by a space
# Example:
#
# REPO_1 http://example.com/repo_1.git
# REPO_2 http://example.com/repo_3.git
# REPO_3 http://example.com/repo_2.git

input=$1

while IFS=' ' read -r repo url
do
  echo "********************************************************************************"
  echo "Copying $repo to $url"

  ./cp-git.sh $repo $url

done < "$input"
