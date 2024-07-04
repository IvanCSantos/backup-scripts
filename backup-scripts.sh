#!/bin/bash

# Variables
me=`whoami`
date=`date +%d%m%y`
source .env
encrypt_password=${ENCRYPT_PASSWORD}
source_files=${SCRIPTS_DIR}
backup_path=${BACKUP_SCRIPTS_PATH}
retention=${RETENTION}

# In case the scripts backup directory doesn't exists, create it
if [[ ! -d ${backup_path} ]]; then
    mkdir -p ${backup_path}
fi

zip --encrypt -P ${encrypt_password} -r ${backup_path}/scripts-$me-$date.zip ${source_files}
find ${backup_path}/*.zip -mtime +${retention} -exec rm {} \;