#!/bin/bash

# Mark's magic script to update your origin to the new remote repository
# Make sure that you
# chmod +x gitimport.sh
# so you can run this script
#

if [ "$#" -gt 1 ]; then

	echo "cd $1";
	cd $1;
	echo `pwd`;

	echo "Updating $1 repository";

	echo "Setting up new Remote";
	git remote add new-origin git@adgit01.apnnz.co.nz:web-development/${2//_/-}.git;

	echo "Removing old Origin";
	git remote remove origin;

	echo "Setting New Remote as Origin";
	git remote rename new-origin origin;

	echo "Fetching data from newly added origin";
	git fetch --all;

	for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | sed 's/refs\/heads\///'); do
		echo " ";
		echo "Updating tracking information for branch: $branch";
    	git branch --set-upstream-to=origin/$branch $branch;
	done

	git checkout master;
	git remote show origin;
	echo " ";

	if [ -d "shared" ]; then
		cd shared;

		echo "Setting up new Remote for Shared";
		git remote add new-origin git@adgit01.apnnz.co.nz:web-development/shared.git;

		echo "Removing old Origin for Shared";
		git remote remove origin;

		echo "Setting New Remote as Origin for Shared";
		git remote rename new-origin origin;

		git fetch --all;

		for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | sed 's/refs\/heads\///'); do
			echo " ";
			echo "Updating tracking information for shared branch: $branch";
	    	git branch --set-upstream-to=origin/$branch $branch;
		done

		git remote show origin;

		cd ..;
	fi

	git submodule update --init;

	cd ..;
	pwd;

else
	echo "";
	echo "Error: insufficient arguments";
	echo "Please provide the directory name and current repo name in that order, for the repo that you wish to update origin info of";
	echo "e.g., git-scripts/gitswitch2.sh ngm ngm_mobile";
fi;