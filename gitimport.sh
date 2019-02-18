#!/bin/bash

# Mark's magic script to checkout all remote GIT branches for cloning to remote repo
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
#

# Git Config changes
git config --global core.compression 0

# Check for command line args
if test -z "$1"
then
	echo "Please enter remote repository resource (e.g. nzherald.git): "
	read input_resource
else
	input_resource="$1"
fi

echo "Cloning Project git@git:$input_variable $input_variable"
#git clone --depth 1 git@git:$input_variable $input_variable
git clone git@git:$input_resource $input_resource
cd $input_resource

git submodule init
git submodule update

echo "Doing a fetch on remote branch"
git fetch --depth 2147483647
#git fetch --unshallow
git fetch --all

echo "Retrieving Remote Branches"

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

echo "Running fetch"
git fetch --all

echo "Getting all Tags"

git fetch --tags

echo "Pulling all Branches"
git pull --all

git checkout master
git submodule update

echo "Task Complete"
cd ..