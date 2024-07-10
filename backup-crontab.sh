#!/bin/bash

# Variables
me=`whoami`
date=`date +%d%m%y`
source /Users/ivansantos/scripts/.env
encrypt_password=${ENCRYPT_PASSWORD}
backup_path=${BACKUP_CRONTAB_PATH}
retention=${RETENTION}

# In case the crontab backup directory doesn't exists, create it
if [[ ! -d ${backup_path} ]]; then
    mkdir -p ${backup_path}
fi

cd ~/scripts
crontab -l > crontab-$me.txt
zip --encrypt -P ${encrypt_password} -r ${backup_path}/crontab-$me-$date.zip crontab-$me.txt
rm crontab-$me.txt
find ${backup_path}/*.zip -mtime +${retention} -exec rm {} \;