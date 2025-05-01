#!/bin/bash
#
# Inform the user about successful update.
#
set -euxfo pipefail

SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

DATE_TIME_ISO=$(date +"%Y-%m-%d %H:%M:%S")

OLD_DIR=$(pwd)
cd "$SCRIPT_DIR" || exit 1
SHORT_LATEST_COMMIT_HASH=$(git rev-parse --short HEAD)
cd "$OLD_DIR" || exit 1

echo "[$SCRIPT_NAME] The current time is $DATE_TIME_ISO"
echo "[$SCRIPT_NAME] You are running version $SHORT_LATEST_COMMIT_HASH"

