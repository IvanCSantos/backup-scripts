#!/bin/bash

# Variables
me=`whoami`
date=`date +%d%m%y`
source .env
encrypt_password=${ENCRYPT_PASSWORD}
configs_dir=${CONFIGS_DIR}
backup_path=${BACKUP_CONFIGS_PATH}
retention=30

# In case the configs backup directory doesn't exists, create it
if [[ ! -d ${backup_path} ]]; then
    mkdir -p ${backup_path}
fi

zip --encrypt -P ${encrypt_password} -r ${backup_path}/configs-$me-$date.zip ${configs_dir}
find ${backup_path}/*.zip -mtime +${retention} -exec rm {} \;