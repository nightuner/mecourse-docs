#!/usr/bin/env bash

HOME=`echo ${HOME}`
SOURCE_PATH="${HOME}/Workspace/mecourse/mecourse-docs/"
REMOTE_PATH="/u01/mecourse-docs/"
EXCLUDE_FILE="${SOURCE_PATH}/scripts/exclude-list.txt"

TEST_SERVER="101.132.97.214"
PROD_SERVER="106.15.199.139"

case "$1" in
    test)
        echo "Syncing test..."
        rsync -a --progress -e "ssh -p 22" --delete ${SOURCE_PATH} mecourse@${TEST_SERVER}:${REMOTE_PATH} --exclude-from=${EXCLUDE_FILE}
        ;;
    prod)
        echo "Syncing production..."
        rsync -a --progress -e "ssh -p 22" --delete ${SOURCE_PATH} flux@${PROD_SERVER}:${REMOTE_PATH} --exclude-from=${EXCLUDE_FILE}
        ;;
    *)
        echo "Usage: $0 {test|prod}" >&2
        exit 3
        ;;
esac