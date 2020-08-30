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
   exit 1 # Exit script after printing help
}

while getopts "a:b:c:" opt
do
   case "$opt" in
      a ) gitUsername="$OPTARG" ;;
      b ) projectName="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$gitUsername" ] || [ -z "$projectName" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
cat << "EOF"
______ _____ ___  _____ _____      _____ _   _ _   _        _____ _____ _____ _   _______ 
| ___ \  ___/ _ \/  __ \_   _|    |  ___| \ | | | | |      /  ___|  ___|_   _| | | | ___ \
| |_/ / |__/ /_\ \ /  \/ | |______| |__ |  \| | | | |______\ `--.| |__   | | | | | | |_/ /
|    /|  __|  _  | |     | |______|  __|| . ` | | | |______|`--. \  __|  | | | | | |  __/ 
| |\ \| |__| | | | \__/\ | |      | |___| |\  \ \_/ /      /\__/ / |___  | | | |_| | |    
\_| \_\____|_| |_/\____/ \_/      \____/\_| \_/\___/       \____/\____/  \_/  \___/\_| 

EOF

echo -e "${PURPLE}Beginning Script...."
echo -e "${GREEN}Git Username: $gitUsername"
echo -e "Project Name $projectName"
echo -e "With Firebase: $withFirebase"
echo -e "${PURPLE}Making Project in parent directory using create-react-app..."
npm uninstall -g create-react-app
rm -rf ../$projectName
npx create-react-app ../$projectName
echo -e "${PURPLE}Initializing repository as git repository"
cd ../$projectName && git init
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
echo -e "bootstrapping react-router-dom"
rm -rf ./src/index.js
rm -rf ./src/App.js
cp ../react-env-setup/App.js ./src/
cp ../react-env-setup/index.js ./src/
cp ../react-env-setup/SecondPage.js ./src/
git add .
git commit -m "bootstrapped react-router-dom"
echo -e "${PURPLE}adding remote and pushing"
git remote add origin https://github.com/$gitUsername/$projectName.git
git push origin master
echo -e "done"