#!/bin/bash

mkdir -p /var/www/app
mkdir -p /var/www/logs/app
cd /var/www/app/

if ! type "git" > /dev/null; then
    echo -e "---------------------------"
    echo -e " No git. Installing..."
    apt-get -y install git
    echo -e "\033[32m Git installed."
    echo -e "\033[30m---------------------------"
fi

git init
echo -e "Getting repository: ${GIT_URL}"
git remote add origin ${GIT_URL}
git pull origin master

echo -e "*** SSH PUBLIC KEY"
cat /root/.ssh/id_rsa.pub
echo -e "******************"

if ! type "node" > /dev/null; then
    echo -e "\033[31m Error: Node not installed."
    echo -e "\033[31m        Please install NodeJs. \033[30m"
    exit 1
else
    if ! type "bower" > /dev/null; then
        echo -e "---------------------------"
        echo -e " No bower. Installing..."
        npm install -g bower
        echo -e "\033[32m Bower installed."
        echo -e "\033[30m---------------------------"
    fi

    npm install
    bower install --allow-root

    if ! type "pm2" > /dev/null; then
        echo -e "---------------------------"
        echo -e " No pm2. Installing..."
        npm install -g pm2
        echo -e "\033[32m Pm2 installed."
        echo -e "\033[30m---------------------------"
    fi

    pm2 startOrGracefulReload ecosystem.json

fi
