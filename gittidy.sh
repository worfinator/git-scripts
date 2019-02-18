#!/bin/bash

# Mark's magic script to tidy up remote branches
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
#

echo "Warning!!!"
echo "All remote branches (except master) will be deleted"
echo ""
echo "Are you sure you want to run this script? (Yes): "
read response

if [ "$response" = "Yes" ]; then

	for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master | sed 's/remotes\/origin\///'`; do
	    echo "Removing branch: $branch from remote"
	    git branch -D $branch
	    #git push origin :$branch
	done
	echo ""
	echo "Task complete ... if anyone asks - it's your fault!"
else
	echo "I quit, I'm outta here!"
fi