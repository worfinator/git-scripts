#!/bin/bash

# Mark's magic script to update all local repos
# Make sure that you 
# chmod +x gitimport.sh
# so you can run this script
#

echo "Update of Repositories"
echo ""
echo ""
echo ""

gitclean.sh

for repo in *.git; do
	echo "Updating $repo repository"
	gitupdate.sh $repo

	echo ""
	echo ""
	echo ""
done 

echo "All now repositories updated"