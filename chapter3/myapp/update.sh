#!/bin/bash
#
# After having pulled the latest changes from the git repository, this script
# performs post-update tasks.
#
set -euxfo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

/bin/bash -c "$SCRIPT_DIR/log_successful_update.sh"
