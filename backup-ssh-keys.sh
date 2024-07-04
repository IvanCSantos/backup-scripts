#!/bin/bash

# Variables
me=`whoami`
date=`date +%d%m%y`
source .env
encrypt_password=${ENCRYPT_PASSWORD}
backup_path=${BACKUP_SSH_CONFIG_PATH}
retention=30

# In case the ssh backup directory doesn't exists, create it
if [[ ! -d ${backup_path} ]]; then
    mkdir -p ${backup_path}
fi

zip --encrypt -P ${encrypt_password} -r ${backup_path}/ssh-$me-$date.zip ~/.ssh
find ${backup_path}/*.zip -mtime +${retention} -exec rm {} \;