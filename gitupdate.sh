#!/bin/bash

# Mark's magic script to update all remote GIT branches to remote repo
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
#

# Git Config changes

# Check for command line args
if test -z "$1"
then
	echo "Please enter remote repository resource (e.g. nzherald.git): "
	read input_directory
else
	input_directory="$1"
fi

# Change directory and remove lock file
cd $input_directory
rm .git/index.lock

echo "Checking out master"
git checkout -f master
echo "Doing a Clean up"
git reset --hard origin/master
git pull
git submodule update

#Make sure we have all branches incase someone created one since we cloned
#echo "Doing a fetch on remote branch"
#for branch in `git fetch --all | grep new`; do
# echo "$branch"
#done
git fetch --all


# Reset the branches to original origin and clean up
echo "Retrieving and Pulling Remote Branches"
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master | grep -v new-origin | sed 's/remotes\/origin\///'`; do
    echo "Update Remote for branch: $branch"
    git checkout $branch
    #git branch --track ${branch##*/} $branch
    #git branch --set-upstream-to=origin/$branch
    #git fetch origin
    git reset --hard origin/$branch
    git clean -f -d
    git pull origin
done

# Lets get all the changes
echo "Running fetch"
git fetch --all

echo "Getting all Tags"
git fetch --tags origin

echo "Pulling all branches"
git pull --all

echo "Setting up new Remote git@adgit01.apnnz.co.nz:web-development/$input_directory"
git remote add new-origin git@adgit01.apnnz.co.nz:web-development/$input_directory

echo "Checking out master"
git checkout -f master
echo "Doing a Clean up"
git reset --hard origin/master
git pull
git submodule update

echo "Pushing all Local Branches to the New Remote"
git push --all new-origin

echo "Pushing all Local Tags to the New Remote"
git push --tags new-origin

echo "Task Complete"
cd ..