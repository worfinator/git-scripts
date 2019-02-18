#!/bin/bash

# Mark's magic script to update your origin to the new remote repository
# Make sure that you
# chmod +x gitimport.sh
# so you can run this script
#

for repo in *.git; do

	if [ $repo != "*.git" ]; then

		echo "Updating $repo repository"
		cd $repo

		echo "Setting up new Remote"
		git remote add new-origin git@adgit01.apnnz.co.nz:web-development/$repo

		echo "Removing old Origin"
		git remote remove origin

		echo "Setting New Remote as Origin"
		git remote rename new-origin origin

		git fetch --all

		for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | sed 's/refs\/heads\///'); do
			echo " ";
			echo "Updating tracking information for branch: $branch";
			#git checkout $branch
			#git branch --track ${branch##*/} $branch
	    	git branch --set-upstream-to=origin/$branch $branch
		done

		git checkout master
		git remote show origin
		echo " "

		if [ -d "shared" ]; then
			cd shared

		echo "Setting up new Remote for Shared"
		git remote add new-origin git@adgit01.apnnz.co.nz:web-development/shared.git

			echo "Removing old Origin for Shared"
			git remote remove origin

			echo "Setting New Remote as Origin for Shared"
			git remote rename new-origin origin

			git fetch --all

			for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | sed 's/refs\/heads\///'); do
				echo " ";
				echo "Updating tracking information for shared branch: $branch";
				#git checkout $branch
				#git branch --track ${branch##*/} $branch
		    	git branch --set-upstream-to=origin/$branch $branch
			done

			git remote show origin

			cd ..
		fi

		git submodule update

		cd ..
	else
		echo "No repo found that could be updated. Have you renamed the directories correctly?"
	fi

done
