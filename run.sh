#!/bin/bash

# Check if exist ssh key
SSH_FILE="id_rsa"
SSH_FILE_PUBLIC="$SSH_FILE.pub"

cd ~/.ssh/

if [ ! -e "$SSH_FILE" ]
then
    echo "Creating $SSH_FILE key..."
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/$SSH_FILE -q -N ""
    eval "$(ssh-agent -s)"
    ssh-add $SSH_FILE
    chown -R root:root ~/.ssh
    RUN /bin/chmod 0400 /root/.ssh/id_rsa
    touch ~/.ssh/known_hosts
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
    echo "Created."
fi

echo "========================================================================"
echo "You can now copy the ssh key:"
echo ""
cat $SSH_FILE_PUBLIC
echo ""
echo "========================================================================"
