#!/bin/bash

cd /var/app/src

git init
git remote add origin git@bitbucket.org:bragteam/datamodeler-ui.git
git pull origin master

npm install
gulp build


pm2 startOrGracefulReload ecosystem.json
