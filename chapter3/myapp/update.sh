#!/bin/sh
#
# After having pulled the latest changes from the git repository, this script
# performs post-update tasks.
#
Hier weiter: SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

/bin/bash -c "./log_successful_update.sh"
