#!/bin/bash

cd /var/app/src

git init
echo -e "Getting repository: ${REPO}"
git remote add origin ${REPO}
git pull origin master

npm install
gulp build


pm2 startOrGracefulReload ecosystem.json
