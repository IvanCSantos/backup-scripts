#!/bin/bash

# Variables
me=`whoami`
year=`date +%Y`
source .env
backup_path=${BACKUP_YEARLY_PATH}
yearly_backup_path=${BACKUP_YEARLY_PATH}/${year}
alreadyRanFlag=${backup_path}/.yearly-backup-flag

# In case the yearly backup directory doesn't exists, create it
if [[ ! -d ${yearly_backup_path} ]]; then
  echo "Creating backup directory"
  mkdir -p ${yearly_backup_path}
fi

# If the Year Flag file doesn't exists, create it
if [[ ! -f ${alreadyRanFlag} ]]; then
  echo "File ${alreadyRanFlag} didn't exists. Creating it!"
  touch ${alreadyRanFlag}
fi

# Checks if the yearly backup already raun this Year. It should ran only once a year!
if [[ -f ${alreadyRanFlag} ]]; then
  yearFromFlag=$(head -n 1 ${alreadyRanFlag})
  echo "read yearFromFlag: ${yearFromFlag}"
  # Checks if the year flag came blank, if so, sets the yearFromFlag variable to 0
  if [[ -z ${yearFromFlag} ]]; then
    echo "As yearFromFlag returned empty string, it was set to \"0\""
    yearFromFlag=0
  fi
  # Checks if the last execution time (from yearFromFlag variable) was in this year
  if [[ ${year} -gt ${yearFromFlag} ]]; then
    echo "Moving ${MAC_FILES} and ${ONEDRIVE_DATA} backups to ${yearly_backup_path}"
    mv ${backup_path}/${MAC_FILES} ${yearly_backup_path}
    mv ${backup_path}/${ONEDRIVE_DATA} ${yearly_backup_path}
    
    echo "Re-creating backups directories"
    mkdir -p ${backup_path}/${MAC_FILES}
    mkdir -p ${backup_path}/${ONEDRIVE_DATA}

    echo "Setting ${alreadyRanFlag} to ${year}"
    echo "${year}" > ${alreadyRanFlag}
  else
    echo "Yearly backup already ran this year. Skipping."
  fi;
fi