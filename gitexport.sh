#!/bin/bash

# Mark's magic script to push Local Branch to new Git Host
# Make sure that you 
# chmod +x gitexport.sh
# so you can run this script
#

# Check for command line args
if test -z "$1"
then
	echo "Please enter remote repository resource (e.g. nzherald.git): "
	read input_directory
else
	input_directory="$1"
fi

cd $input_directory

echo "Setting up new Remote git@adgit01.apnnz.co.nz:web-development/$input_directory"
git remote add new-origin git@adgit01.apnnz.co.nz:web-development/$input_directory

echo "Doing inital master branch push"
git checkout master
git push -u new-origin master

echo "Pushing all Local Branches to the New Remote"
git push --all new-origin

echo "Pushing all Local Tags to the New Remote"
git push --tags new-origin

echo "Task Complete"
cd ..