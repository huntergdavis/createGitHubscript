#!/bin/bash
# createGitHubscript.sh
# a shell script to iterate over directories
# and create github repositories based on the information given.

# we want k for api key, x for prefix, u for username, h for help

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


if [ -z "$PREFIX" ];
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


