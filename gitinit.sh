#!/bin/bash

# Mark's magic script to import and update all remote GIT branches to remote repo
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
# 

echo "Initial Import and Export of Repositories"
echo ""
echo ""
echo ""

echo "Removing repos"
rm -Rf *.git

filecontent=( `cat repos.txt` )

for repo in "${filecontent[@]}"; do
	echo "Importing $repo"
	gitimport.sh $repo

	if [ "$repo" = "ltm_mobile.git" ]; then
		echo "Moving $Repo to new naming convention"
		mv $repo ltm-mobile.git
		repo="ltm-mobile"
	fi

	if [ "$repo" = "ngm_mobile.git" ]; then
		echo "Moving $Repo to new naming convention"
		mv $repo ngm-mobile.git
		repo="ngm-mobile"
	fi

	echo ""
	echo ""

	echo "Exporting $repo"
	gitexport.sh $repo

	echo ""
	echo ""
	echo ""
done

echo "All Repositories now exported"