#!/bin/sh
#
# Inform the user about successful update.
#

SCRIPT_NAME=$(basename "$0")

DATE_TIME_ISO=$(date +"%Y-%m-%d %H:%M:%S")
SHORT_LATEST_COMMIT_HASH=$(git rev-parse --short HEAD)

echo "[$SCRIPT_NAME] The current time is $DATE_TIME_ISO"
echo "[$SCRIPT_NAME] You are running version $SHORT_LATEST_COMMIT_HASH"
