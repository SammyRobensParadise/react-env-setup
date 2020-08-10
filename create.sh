#!/bin/bash

# constants
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'
#helper functions
helpFunction()
{
   echo ""
   echo "Usage: $0 -a gitUsername -b projectName -c withFirebase"
   echo -e "\t-a Description of what is gitUsername"
   echo -e "\t-b Description of what is projectName"
   echo -e "\t-c Description of what is withFirebase"
   exit 1 # Exit script after printing help
}

while getopts "a:b:c:" opt
do
   case "$opt" in
      a ) gitUsername="$OPTARG" ;;
      b ) projectName="$OPTARG" ;;
      c ) withFirebase="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$gitUsername" ] || [ -z "$projectName" ] || [ -z "$withFirebase" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "${PURPLE}Beginning Script...."
echo "${GREEN}Git Username: $gitUsername"
echo "Project Name $projectName"
echo "With Firebase: $withFirebase"
echo "${PURPLE}Making Project in parent directory using create-react-app..."
cd ../
npx create-react-app $projectName
cd ../$projectName
echo "Initializing repository as git repository"
git init
echo "Updating npm..."
npm -v
npm i npm
npm -v
echo "Installing npm dependencies"
npm install @loadable/component react-cookie react-lazy-load-image-component react-lazyload @material-ui/core react-redux react-router react-router-dom react-scripts react-scroll styled-components
echo "${GREEN}Sucessfully installed dependencies"
echo "committing and pushing to a remote repository"
git add .
git commit -m "Initial commit to repository"
git remote add origin https://github.com/$gitUsername/$projectName.git
git push origin master
