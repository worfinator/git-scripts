#!/bin/bash

# Mark's magic script to import and update all remote GIT branches to remote repo
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
# 

echo "Removing repos"
rm -Rf *.git

filecontent=( `cat repos.txt` )

for repo in "${filecontent[@]}"; do
	echo "Importing $repo"
	gitimport.sh $repo

	if [ "$repo" = "ltm_mobile.git" ]; then
		echo "Moving $Repo to new naming convention"
		mv $repo ltm-mobile.git
	fi

	if [ "$repo" = "ngm_mobile.git" ]; then
		echo "Moving $Repo to new naming convention"
		mv $repo ngm-mobile.git
	fi

	echo ""
	echo ""
	echo ""
done
