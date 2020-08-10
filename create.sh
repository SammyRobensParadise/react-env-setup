#!/bin/bash

# constants
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'
#helper functions
helpFunction()
{
   echo -e ""
   echo -e "Usage: $0 -a gitUsername -b projectName -c withFirebase"
   echo -e -e "\t-a Description of what is gitUsername"
   echo -e -e "\t-b Description of what is projectName"
   echo -e -e "\t-c Description of what is withFirebase"
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
echo -e "${PURPLE}Beginning Script...."
echo -e "${GREEN}Git Username: $gitUsername"
echo -e "Project Name $projectName"
echo -e "With Firebase: $withFirebase"
echo -e "${PURPLE}Making Project in parent directory using create-react-app..."
npx create-react-app ../$projectName
cd ../$projectName && git init
echo -e "Initializing repository as git repository"
echo -e "Updating npm..."
npm -v
npm i npm
npm -v
echo -e "Installing npm dependencies"
pwd
echo -p
npm install @loadable/component react-cookie react-lazy-load-image-component react-lazyload @material-ui/core react-redux react-router react-router-dom react-scripts react-scroll styled-components
npm audit fix
echo -e "${GREEN}Sucessfully installed dependencies"
echo -e "committing and pushing to a remote repository"
git add .
git commit -m "Initial commit to repository"
git remote add origin https://github.com/$gitUsername/$projectName.git
git push origin master
echo -e "done"