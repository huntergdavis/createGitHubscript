#!/bin/bash
# createGitHubscript.sh
# a shell script to iterate over directories
# and create github repositories based on the information given.

# we want k for api key, x for prefix, u for username, h for help
# pre-set prefix to APPLICATION
PREFIX="APPLICATION";

while getopts "k:x:h:u:" opt;
do
case $opt in
k) API_KEY=$OPTARG;;
x) PREFIX=$OPTARG ;;
u) USERNAME=$OPTARG ;;
h) echo "Usage: createGitHubscript.sh -k GITHUB_API_KEY -u GITHUB_USERNAME -x DESCRIPTION_PREFIX" ; exit 1 ;;
*) echo "Usage: createGitHubscript.sh -k GITHUB_API_KEY -u GITHUB_USERNAME -x DESCRIPTION_PREFIX" ; exit 1 ;;
esac
done


if [ -z "$API_KEY" ];
then
echo "Must have a API KEY set!"
echo "Usage: createGitHubscript.sh -k GITHUB_API_KEY -u GITHUB_USERNAME -x DESCRIPTION_PREFIX" ;
exit 0;
fi


if [ -z "$USERNAME" ];
then
echo "Must have a API KEY set!"
echo "Usage: createGitHubscript.sh -k GITHUB_API_KEY -u GITHUB_USERNAME -x DESCRIPTION_PREFIX" ;
exit 0;
fi


echo "This script creates GitHub repositories from subdirectories in the current running folder";

# iterate over each directory
src=".";
 
# enable for loops over items with spaces in their name
# found this on http://heath.hrsoftworks.net/archives/000198.html
IFS=$'\n';
 
for dir in `ls "$src/"`
do
  if [ -d "$src/$dir" ]; then
    #yay, we get matches!
    cleandir="${dir// /_}";
    echo "Time to create a repository for $dir, named $cleandir";
    
    curl -F "login=$USERNAME" -F "token=$API_KEY" https://github.com/api/v2/yaml/repos/create -F name="$cleandir" -F description="$PREFIX - $dir";
    
    echo "Now sleep 15 seconds for politeness";
    echo sleep 15;
    
    # move down into the directory
    cd $dir;
    
    # init git
    git init;
    
    # add everything
    git add ./* ;
    
    # make a first commit
    git commit -a -m "initial commit for $cleandir";
    
    # add the remote origin
    git remote add origin git@github.com:$USERNAME/$cleandir.git ;
    
    # push it on up
    git push origin master
    
    # get back out
    cd ..;
    
  fi
done
