#!/bin/bash

# script/download_prod_db_and_restore_local: Captures and downloads the production database and restores your local
# with it.

BACKUP_FILE_NAME='./latest.dump'
HEROKU_APP_NAME=retomautos
DEV_DATABASE_NAME="retomautos_development"
# DEV_DATABASE_USER="" default postgres user for this app

if  test -f ./latest.dump ; then
    read -rp "A $BACKUP_FILE_NAME was found. This script will delete it and create a new one. Is that ok? [Y (default) / abort otherwise]: "  overwrite
    overwrite=${overwrite:-Y}

    # Abort if user does not want to overwrite
    if [ "$overwrite" == 'Y' ]; then
      echo "Deleting $BACKUP_FILE_NAME"
      rm $BACKUP_FILE_NAME
    else
      echo 'Aborting script'
      exit 1
    fi
fi

heroku pg:backups:capture --app $HEROKU_APP_NAME
heroku pg:backups:download --app $HEROKU_APP_NAME
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d $DEV_DATABASE_NAME $BACKUP_FILE_NAME
