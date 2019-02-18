################## Git Scripts ##################

These scripts have been created in order to facilitate the transfer of existing Git Repositories on Lenny to the new environment.

First step is to clone a new fresh copy of the git-scripts repository to you local machine in a place where there is sufficent space to store a fresh clone of all current repositories, this is to make sure none of your local dev branches are uploaded to the new Git Repo. Do this be checking out a project/repo as per the following example.

> cd /
> git clone git@my.git.server:utilities/git-scripts.git gittemp

These files will now be in the root folder and make sure they are executable ( chmod +x \*.sh ).

gitclean.sh
gitimport.sh
gitexport.sh
gitupdate.sh
gitsync.sh
gitswitch.sh

Synopisis

These scripts can either be run with a command line parameter, or you will be prompted for input

gitclean.sh

Removes all previous repos and runs gitimport against the list of repos contained in repos.txt

gitimport.sh projectname.git

Clones a copy of "project.name" repository and all current branches/tags to your local machine.

gitexport.sh projectname.git

Pushes the complete repository with all branches/tags to the new origin remote.

gitupdate.sh projectname.git

Pulls all branches/tags and updates the local repository as a clean copy of the source origin, then pushes all branches/tags to the new origin.

gitsync.sh

Performes a gitupdate.sh on all local directories with a .git extension.

gitwitch.sh

Switches all local repositories with a .git extension to the new origin.

################## First time setup of Remote ############

1.) Run gitinit.sh to push all the repos to the new remote >gitinit.sh > initreport.txt 2>&1

    Check text output file for errors (fatal,rejected,could not read,access denied)

################## Update Process ########################

1.) Run gitsync.sh to push all the changes to the new remote >gitsynch.sh > syncreport.txt 2>&1

    Check text output file for errors (fatal,rejected,could not read,access denied)

################## SSH Key setup ##################

Taken from the following Document http://serverfault.com/questions/194567/how-do-i-tell-git-for-windows-where-to-find-my-private-rsa-key

For Git Bash

If you are running msysgit (I am assuming you are) and are looking to run Git Bash (I recommend it over TortoiseGit, but I lean to the CLI more than GUI now), you need to figure out what your home directory is for Git Bash by starting it then type pwd (On Win7, it will be something like C:\Users\phsr I think). While you're in git bash, you should mkdir ~/.ssh.

After you have the home directory, and a .ssh folder under that, you want to open PuTTYgen and open the key (.ppk file) you have previously created. Once your key is open, you want to select Conversions -> Export OpenSSH key and save it to HOME.ssh\id_rsa. After you have the key at that location, Git bash will recognize the key and use it.

Note: Comments indicate that this doesn't work in all cases. You may need to copy the OpenSSH key to Program Files\Git.ssh\id_rsa (or Program Files (x86)\Git.ssh\id_rsa).

For TortoiseGit

When using TortoiseGit, you need to set the SSH key via pacey's directions http://serverfault.com/questions/194567/how-to-i-tell-git-for-windows-where-to-find-my-private-rsa-key/198614#198614 . You need to do that for every repository you are using TortoiseGit with

################## Inital Git Bash settings ##################

#Git Global Setup

git config --global user.name "Fred.Bloggs"

git config --global user.email "fred.bloggs@apn.co.nz"

################## Creating a new Repo ##################

#Create Repository

mkdir test

cd test

git init

touch README

git add README

git commit -m "first commit"

git remote add origin git@my.git.server:fred.bloggs/myproject.git

git push -u origin master

#Existing Git Repo

cd existing_git_repo

git remote add origin git@my.git.server:fred.bloggs/myproject.git

git push -u origin master
